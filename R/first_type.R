# Determine whether an expression is of the type that needs a first argument.
#
# @param a non-evaluated expression.
# @return logical - TRUE if expr is of "first-argument" type, FALSE otherwise.
is_first <- function(expr)
{
  !any(vapply(expr[-1L], identical, logical(1L), quote(.)))
}

# Prepare a magrittr rhs of "first-argument" type.
#
# @param a an expression which passes \code{is_first}
# @return an expression prepared for functional sequence construction.
prepare_first <- function(expr)
{
  as.call(c(expr[[1L]], quote(.), as.list(expr[-1L])))
}
