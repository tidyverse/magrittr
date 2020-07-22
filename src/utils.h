#ifndef MAGRITTR_UTILS_H
#define MAGRITTR_UTILS_H


static inline
bool r_is_string(SEXP x) {
  return TYPEOF(x) == STRSXP &&
    Rf_length(x) == 1 &&
    STRING_ELT(x, 0) != NA_STRING;
}


#endif
