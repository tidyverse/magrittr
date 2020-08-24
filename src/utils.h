#ifndef MAGRITTR_UTILS_H
#define MAGRITTR_UTILS_H


#include <Rversion.h>

void r_env_bind_lazy(SEXP env,
                     SEXP sym,
                     SEXP expr,
                     SEXP eval_env);

static inline
void r_env_unbind(SEXP env, SEXP sym) {
#if (R_VERSION < R_Version(4, 0, 0))
  void r__env_unbind(SEXP, SEXP);
  r__env_unbind(env, sym);
#else
  R_removeVarFromFrame(sym, env);
#endif
}

SEXP r_parse(const char* str);
SEXP r_parse_eval(const char* str, SEXP env);

static inline
SEXP r_new_environment(SEXP parent) {
  SEXP env = Rf_allocSExp(ENVSXP);
  SET_ENCLOS(env, parent);
  return env;
}

static inline
SEXP r_env_get(SEXP env, SEXP sym) {
  SEXP obj = PROTECT(Rf_findVarInFrame3(env, sym, FALSE));

  // Force lazy loaded bindings
  if (TYPEOF(obj) == PROMSXP) {
    obj = Rf_eval(obj, R_BaseEnv);
  }

  UNPROTECT(1);
  return obj;
}

#if defined(RLIB_DEBUG)
SEXP R_inspect(SEXP x);
SEXP R_inspect3(SEXP x, int deep, int pvec);
#endif


#endif
