#include <stdbool.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>
#include "utils.h"

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

static SEXP syms_dot = NULL;
static SEXP syms_pipe = NULL;
static SEXP syms_pipe_compound = NULL;
static SEXP syms_pipe_tee = NULL;
static SEXP syms_pipe_dollar = NULL;
static SEXP calls_base_with = NULL;

static void clean_pipe(void* data);
static SEXP eval_pipe(void* data);
static SEXP pipe_unroll(SEXP expr, SEXP rhs, enum pipe_kind kind);
static SEXP add_dot(SEXP x);
static SEXP as_pipe_call(SEXP x);
static SEXP as_pipe_dollar_call(SEXP x);
static inline SEXP as_pipe_call_switch(enum pipe_kind kind, SEXP x);

// [[ register() ]]
SEXP magrittr_pipe(SEXP call, SEXP op, SEXP args, SEXP rho) {
  args = CDR(args);

  SEXP expr = CAR(args); args = CDR(args);
  SEXP rhs = CAR(args); args = CDR(args);
  SEXP kind = CAR(args); args = CDR(args);
  SEXP env = CAR(args);

  enum pipe_kind c_kind = INTEGER(kind)[0];

  SEXP exprs = PROTECT(pipe_unroll(expr, rhs, c_kind));
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
SEXP pipe_unroll(SEXP expr, SEXP rhs, enum pipe_kind kind) {
  PROTECT_INDEX out_pi;
  SEXP out = R_NilValue;
  PROTECT_WITH_INDEX(out, &out_pi);

  while (kind) {
    rhs = as_pipe_call_switch(kind, rhs);
    out = Rf_cons(rhs, out);
    REPROTECT(out, out_pi);

    SEXP args = CDR(expr);

    rhs = CADR(args);
    expr = CAR(args);
    kind = parse_pipe_call(expr);
  }

  out = Rf_cons(expr, out);

  UNPROTECT(1);
  return out;
}

static inline
SEXP as_pipe_call_switch(enum pipe_kind kind, SEXP x) {
  switch (kind) {
  case PIPE_KIND_magrittr:
  case PIPE_KIND_compound:
    return as_pipe_call(x);
  case PIPE_KIND_tee:
    Rf_error("todo");
    break;
  case PIPE_KIND_dollar:
    return as_pipe_dollar_call(x);
  case PIPE_KIND_none:
    Rf_error("Internal error in `pipe_unroll()`: Unexpected state.");
  }
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

static
SEXP as_pipe_dollar_call(SEXP x) {
  return Rf_lang3(calls_base_with, syms_dot, x);
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


SEXP magrittr_init(SEXP ns) {
  syms_dot = Rf_install(".");
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
