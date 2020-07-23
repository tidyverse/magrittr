#ifndef MAGRITTR_UTILS_H
#define MAGRITTR_UTILS_H


SEXP r_parse(const char* str);
SEXP r_parse_eval(const char* str, SEXP env);

SEXP r_new_environment(SEXP parent, R_len_t size);


#endif
