#ifndef MAGRITTR_UTILS_H
#define MAGRITTR_UTILS_H


#include <Rversion.h>

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

SEXP r_new_environment(SEXP parent, R_len_t size);


#endif
