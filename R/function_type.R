# Determine whether an expression counts as a function in a magrittr chain.
#
# @param a non-evaluated expression.
# @return logical - TRUE if expr represents a function, FALSE otherwise.
is_function <- function(expr)
{
  is.symbol(expr) || is.function(expr)
}

# Prepare a magrittr rhs of funtion type
#
# @param a an expression which passes \code{is_function}
# @return an expression prepared for functional sequence construction.
prepare_function <- function(f)
{
  as.call(list(f, quote(.)))
}

# Prepare a magrittr rhs of funexpr type
#
# @param a an expression which passes \code{is_funexpr}
# @return an expression prepared for functional sequence construction.
prepare_funexpr <- function(fe)
{
  if (is.symbol(fe[[2L]]))
    fe[[2L]] <- call("<-", fe[[2L]], quote(.))
  fe
}
