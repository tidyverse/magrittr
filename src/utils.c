#define R_NO_REMAP
#include <Rinternals.h>


SEXP syms_delayed_assign = NULL;

void r_env_bind_lazy(SEXP env,
                     SEXP sym,
                     SEXP expr,
                     SEXP eval_env) {
  SEXP prom = PROTECT(Rf_allocSExp(PROMSXP));
  SET_PRENV(prom, eval_env);
  SET_PRCODE(prom, expr);
  SET_PRVALUE(prom, R_UnboundValue);

  Rf_defineVar(sym, prom, env);

  UNPROTECT(1);
  return;

  SEXP call = PROTECT(Rf_lang5(syms_delayed_assign, sym, expr, eval_env, env));
  Rf_eval(call, R_BaseEnv);
  UNPROTECT(1);
}


// For `R_removeVarFromFrame()` compatibility
SEXP syms_envir = NULL;
SEXP syms_inherits = NULL;
SEXP syms_list = NULL;
SEXP syms_rm = NULL;

#include <Rversion.h>

#if (R_VERSION < R_Version(4, 0, 0))
void r__env_unbind(SEXP env, SEXP sym) {
  // Check if binding exists to avoid `rm()` warning
  if (Rf_findVar(sym, env) != R_UnboundValue) {
    SEXP nm = PROTECT(Rf_allocVector(STRSXP, 1));
    SET_STRING_ELT(nm, 0, PRINTNAME(sym));

    // remove(list = y, envir = x, inherits = z)
    SEXP args = Rf_cons(Rf_ScalarLogical(0), R_NilValue);
    SET_TAG(args, syms_inherits);

    args = Rf_cons(env, args);
    SET_TAG(args, syms_envir);

    args = Rf_cons(nm, args);
    SET_TAG(args, syms_list);

    SEXP call = Rf_lcons(syms_rm, args);
    PROTECT(call);

    Rf_eval(call, R_BaseEnv);
    UNPROTECT(2);
  }
}
#endif


#include <R_ext/Parse.h>

static void abort_parse(SEXP code, const char* why) {
  if (Rf_GetOption1(Rf_install("rlang__verbose_errors")) != R_NilValue) {
   Rf_PrintValue(code);
  }
  Rf_error("Internal error in `r_parse()`: %s", why);
}

SEXP r_parse(const char* str) {
  SEXP str_ = PROTECT(Rf_mkString(str));

  ParseStatus status;
  SEXP out = PROTECT(R_ParseVector(str_, -1, &status, R_NilValue));
  if (status != PARSE_OK) {
    abort_parse(str_, "Parsing failed.");
  }
  if (Rf_length(out) != 1) {
    abort_parse(str_, "Expected a single expression.");
  }

  out = VECTOR_ELT(out, 0);

  UNPROTECT(2);
  return out;
}
SEXP r_parse_eval(const char* str, SEXP env) {
  SEXP out = Rf_eval(PROTECT(r_parse(str)), env);
  UNPROTECT(1);
  return out;
}

static SEXP new_env_call = NULL;
static SEXP new_env__parent_node = NULL;
static SEXP new_env__size_node = NULL;

#if 0
SEXP r_new_environment(SEXP parent, R_len_t size) {
  parent = parent ? parent : R_EmptyEnv;
  SETCAR(new_env__parent_node, parent);

  size = size ? size : 29;
  SETCAR(new_env__size_node, Rf_ScalarInteger(size));

  SEXP env = Rf_eval(new_env_call, R_BaseEnv);

  // Free for gc
  SETCAR(new_env__parent_node, R_NilValue);

  return env;
}
#endif


void magrittr_init_utils(SEXP ns) {
  syms_delayed_assign = Rf_install("delayedAssign");
  syms_envir = Rf_install("envir");
  syms_inherits = Rf_install("inherits");
  syms_list = Rf_install("list");
  syms_rm = Rf_install("rm");

  new_env_call = r_parse_eval("as.call(list(new.env, TRUE, NULL, NULL))", R_BaseEnv);
  R_PreserveObject(new_env_call);
  new_env__parent_node = CDDR(new_env_call);
  new_env__size_node = CDR(new_env__parent_node);
}
