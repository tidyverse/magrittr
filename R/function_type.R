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
