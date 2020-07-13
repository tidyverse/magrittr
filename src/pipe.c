#include <stdbool.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>

#define export attribute_visible extern


static SEXP syms_dot = NULL;
static SEXP syms_pipe = NULL;

static void clean_pipe(void* data);
static SEXP eval_pipe(void* data);
static SEXP pipe_unroll(SEXP x, SEXP y);
static SEXP add_dot(SEXP x);
static SEXP new_pipe_node(SEXP car, SEXP cdr);

struct pipe_info {
  SEXP exprs;
  SEXP env;
};

struct cleanup_info {
  SEXP old;
  SEXP env;
};

// [[ register() ]]
SEXP magrittr_pipe(SEXP call, SEXP op, SEXP args, SEXP rho) {
  args = CDR(args);

  SEXP x = CAR(args); args = CDR(args);
  SEXP y = CAR(args); args = CDR(args);
  SEXP env = CAR(args);

  SEXP exprs = PROTECT(pipe_unroll(x, y));
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


bool is_magrittr_call(SEXP x) {
  return TYPEOF(x) == LANGSXP && CAR(x) == syms_pipe;
}

static
SEXP pipe_unroll(SEXP x, SEXP y) {
  SEXP out = new_pipe_node(y, R_NilValue);
  SEXP node = x;

  PROTECT_INDEX out_pi;
  PROTECT_WITH_INDEX(out, &out_pi);

  while (is_magrittr_call(node)) {
    SEXP args = CDR(node);
    SEXP rhs = CADR(args);

    out = new_pipe_node(rhs, out);
    REPROTECT(out, out_pi);

    node = CAR(args);
  }

  out = Rf_cons(node, out);

  UNPROTECT(1);
  return out;
}

static
SEXP new_pipe_node(SEXP car, SEXP cdr) {
  if (TYPEOF(car) != LANGSXP) {
    car = Rf_lcons(car, R_NilValue);
  }
  PROTECT(car);

  car = PROTECT(add_dot(car));
  SEXP out = Rf_cons(car, cdr);

  UNPROTECT(2);
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


SEXP magrittr_init(SEXP ns) {
  syms_dot = Rf_install(".");
  syms_pipe = Rf_install("%>%");
  return R_NilValue;
}

static const R_CallMethodDef call_entries[] = {
  {"magrittr_init",              (DL_FUNC) magrittr_init, 1},
  {NULL, NULL, 0}
};

static const R_ExternalMethodDef ext_entries[] = {
  {"magrittr_pipe",              (DL_FUNC) magrittr_pipe, 3},
  {NULL, NULL, 0}
};

export void R_init_magrittr(DllInfo *dll) {
    R_registerRoutines(dll, NULL, call_entries, NULL, ext_entries);
    R_useDynamicSymbols(dll, FALSE);
}
