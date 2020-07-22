#include <stdbool.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>

#define export attribute_visible extern


enum pipe_kind {
  PIPE_KIND_none = 0,
  PIPE_KIND_magrittr,
  PIPE_KIND_compound,
  PIPE_KIND_tee,
  PIPE_KIND_dollar
};

// Helper structures for unwind-protection of `.` restoration
struct pipe_info {
  SEXP exprs;
  SEXP env;
};
struct cleanup_info {
  SEXP old;
  SEXP env;
};

static SEXP syms_curly = NULL;
static SEXP syms_dot = NULL;
static SEXP syms_paren = NULL;
static SEXP syms_pipe = NULL;
static SEXP syms_pipe_compound = NULL;
static SEXP syms_pipe_tee = NULL;
static SEXP syms_pipe_dollar = NULL;
static SEXP calls_base_with = NULL;

static void clean_pipe(void* data);
static SEXP eval_pipe(void* data);
static SEXP pipe_unroll(SEXP lhs, SEXP rhs, SEXP env, enum pipe_kind kind, SEXP* p_assign);
static SEXP as_pipe_call(SEXP x);
static SEXP add_dot(SEXP x);
static inline SEXP as_pipe_tee_call(SEXP x);
static inline SEXP as_pipe_dollar_call(SEXP x);
static SEXP as_pipe_compound_lhs(SEXP lhs);
static __attribute__((noreturn)) void stop_compound_lhs_type();

// [[ register() ]]
SEXP magrittr_pipe(SEXP call, SEXP op, SEXP args, SEXP rho) {
  args = CDR(args);

  SEXP lhs = CAR(args); args = CDR(args);
  SEXP rhs = CAR(args); args = CDR(args);
  SEXP kind = CAR(args); args = CDR(args);
  SEXP env = CAR(args);

  enum pipe_kind c_kind = INTEGER(kind)[0];

  SEXP assign = R_NilValue;
  SEXP exprs = PROTECT(pipe_unroll(lhs, rhs, env, c_kind, &assign));
  SEXP old = PROTECT(Rf_findVar(syms_dot, env));

  struct pipe_info pipe_info = {
    .exprs = exprs,
    .env = env
  };
  struct cleanup_info cleanup_info = {
    .old = old,
    .env = env
  };

  SEXP out = R_ExecWithCleanup(&eval_pipe, &pipe_info, &clean_pipe, &cleanup_info);

  if (assign != R_NilValue) {
    Rf_defineVar(assign, out, env);
  }

  UNPROTECT(2);
  return out;
}

static
SEXP eval_pipe(void* data) {
  struct pipe_info* info = (struct pipe_info*) data;

  SEXP exprs = info->exprs;
  SEXP env = info->env;

  SEXP out = R_NilValue;
  while (exprs != R_NilValue) {
    out = PROTECT(Rf_eval(CAR(exprs), env));

    Rf_defineVar(syms_dot, out, env);
    UNPROTECT(1);

    exprs = CDR(exprs);
  }

  return out;
}

static
void clean_pipe(void* data) {
  struct cleanup_info* info = (struct cleanup_info*) data;

  if (info->old == R_UnboundValue) {
    R_removeVarFromFrame(syms_dot, info->env);
  } else {
    Rf_defineVar(syms_dot, info->old, info->env);
  }
}


static enum pipe_kind parse_pipe_call(SEXP x);

static
SEXP pipe_unroll(SEXP lhs,
                 SEXP rhs,
                 SEXP env,
                 enum pipe_kind kind,
                 SEXP* p_assign) {
  PROTECT_INDEX out_pi;
  SEXP out = R_NilValue;
  PROTECT_WITH_INDEX(out, &out_pi);

  PROTECT_INDEX rhs_pi;
  PROTECT_WITH_INDEX(rhs, &rhs_pi);

  while (true) {
    if (kind != PIPE_KIND_dollar && TYPEOF(rhs) == LANGSXP && CAR(rhs) == syms_paren) {
      rhs = eval(rhs, env);
      REPROTECT(rhs, rhs_pi);
    }

    switch (kind) {
    case PIPE_KIND_compound: {
      // Technically we want to give `%<>%` the same precedence as `<-`.
      // In practice, since we only support one top-level `%<>%, we
      // can just interpret it as `%>%` and communicate the assignment
      // variable via `p_assign`.
      lhs = as_pipe_compound_lhs(lhs);
      *p_assign = lhs;
      rhs = as_pipe_call(rhs);
      break;
    }
    case PIPE_KIND_magrittr: rhs = as_pipe_call(rhs); break;
    case PIPE_KIND_tee: rhs = as_pipe_tee_call(rhs); break;
    case PIPE_KIND_dollar: rhs = as_pipe_dollar_call(rhs); break;
    case PIPE_KIND_none: Rf_error("Internal error in `pipe_unroll()`: Unexpected state.");
    }

    out = Rf_cons(rhs, out);
    REPROTECT(out, out_pi);

    SEXP args = CDR(lhs);

    if ((kind = parse_pipe_call(lhs))) {
      lhs = CAR(args);
      rhs = CADR(args);
      continue;
    }

    break;
  }

  out = Rf_cons(lhs, out);

  UNPROTECT(2);
  return out;
}

static
SEXP as_pipe_compound_lhs(SEXP lhs) {
  switch (TYPEOF(lhs)) {
  case STRSXP: {
    if (!r_is_string(lhs)) {
      // Should only happen with constructed calls
      stop_compound_lhs_type();
    }
    return Rf_install(CHAR(STRING_ELT(lhs, 0)));
  }
  case SYMSXP: return lhs;
  default: stop_compound_lhs_type();
  }
}

static
__attribute__((noreturn))
void stop_compound_lhs_type() {
  Rf_errorcall(R_NilValue, "The left-hand side of `%%<>%%` must be a variable name.");
}


static
enum pipe_kind parse_pipe_call(SEXP x) {
  if (TYPEOF(x) != LANGSXP) {
    return PIPE_KIND_none;
  }

  SEXP car = CAR(x);

  if (car == syms_pipe) {
    return PIPE_KIND_magrittr;
  }
  if (car == syms_pipe_compound) {
    return PIPE_KIND_compound;
  }
  if (car == syms_pipe_tee) {
    return PIPE_KIND_tee;
  }
  if (car == syms_pipe_dollar) {
    return PIPE_KIND_dollar;
  }

  return PIPE_KIND_none;
}

static
SEXP as_pipe_call(SEXP x) {
  // Transform `foo` into `foo()`
  if (TYPEOF(x) != LANGSXP) {
    x = Rf_lcons(x, R_NilValue);
  }
  PROTECT(x);

  // Transform `foo()` into `foo(.)`
  x = add_dot(x);

  UNPROTECT(1);
  return x;
}

static inline
SEXP as_pipe_dollar_call(SEXP x) {
  return Rf_lang3(calls_base_with, syms_dot, x);
}

static inline
SEXP as_pipe_tee_call(SEXP x) {
  x = PROTECT(as_pipe_call(x));
  SEXP out = Rf_lang3(syms_curly, x, syms_dot);

  UNPROTECT(1);
  return out;
}

static
SEXP add_dot(SEXP x) {
  if (TYPEOF(x) != LANGSXP) {
    return x;
  }

  SEXP args = CDR(x);
  while (args != R_NilValue) {
    if (CAR(args) == syms_dot) {
      return x;
    }
    args = CDR(args);
  }

  return Rf_lcons(CAR(x), Rf_cons(syms_dot, CDR(x)));
}


// Initialisation ----------------------------------------------------

SEXP magrittr_init(SEXP ns) {
  syms_curly = Rf_install("{");
  syms_dot = Rf_install(".");
  syms_paren = Rf_install("(");
  syms_pipe = Rf_install("%>%");
  syms_pipe_compound = Rf_install("%<>%");
  syms_pipe_tee = Rf_install("%T>%");
  syms_pipe_dollar = Rf_install("%$%");

  calls_base_with = Rf_lang3(Rf_install("::"),
                             Rf_install("base"),
                             Rf_install("with"));
  R_PreserveObject(calls_base_with);
  MARK_NOT_MUTABLE(calls_base_with);

  return R_NilValue;
}

static const R_CallMethodDef call_entries[] = {
  {"magrittr_init",              (DL_FUNC) magrittr_init, 1},
  {NULL, NULL, 0}
};

static const R_ExternalMethodDef ext_entries[] = {
  {"magrittr_pipe",              (DL_FUNC) magrittr_pipe, 4},
  {NULL, NULL, 0}
};

export void R_init_magrittr(DllInfo *dll) {
    R_registerRoutines(dll, NULL, call_entries, NULL, ext_entries);
    R_useDynamicSymbols(dll, FALSE);
}
