# Check whether a symbol is a valid magrittr pipe.
#
# @param pipe A quoted symbol
# @return logical - TRUE if a valid magrittr pipe, FALSE otherwise.
is_pipe <- function(pipe)
{
  identical(pipe, quote(`%>%`))   ||
  identical(pipe, quote(`%T>%`))  ||
  identical(pipe, quote(`%<>%`))  ||
  identical(pipe, quote(`%$%`))
}

# Determine whether an non-evaluated call is parenthesized.
#
# @param a non-evaluated expression
# @retun logical - TRUE if expression is parenthesized, FALSE otherwise.
is_parenthesized <- function(expr)
{
  is.call(expr) && identical(expr[[1L]], quote(`(`))
}

# Check whether a pipe is the tee pipe operator.
#
# @param pipe A (quoted) pipe
# @return logical - TRUE if pipe is a tee, FALSE otherwise.
is_tee_pipe <- function(pipe)
{
  identical(pipe, quote(`%T>%`))
}

# Check whether a pipe is the exposition pipe operator.
#
# @param pipe A (quoted) pipe
# @return logical - TRUE if pipe is the dollar pipe, FALSE otherwise.
is_exposition_pipe <- function(pipe)
{
  identical(pipe, quote(`%$%`))
}

# Check whether a pipe is the assignment pipe operator.
#
# @param pipe A (quoted) pipe
# @return logical - TRUE if pipe is the compound assignment pipe,
#   otherwise FALSE.
is_assignment_pipe <- function(pipe)
{
  identical(pipe, quote(`%<>%`))
}

# Check whether expression is enclosed in curly braces.
#
# @param  expr An expression to be tested.
# @return logical - TRUE if expr is enclosed in `{`, FALSE otherwise.
is_funexpr <- function(expr)
{
  is.call(expr) && identical(expr[[1L]], quote(`{`))
}

# Check whether expression has double or triple colons.
#
# @param  expr An expression to be tested.
# @return logical - TRUE if expr contains `::` or `:::`, FALSE otherwise.
is_colexpr <- function(expr)
{
  is.call(expr) &&
    (identical(expr[[1L]], quote(`::`)) || identical(expr[[1L]], quote(`:::`)))
}

# Check whether a symbol is the magrittr placeholder.
#
# @param  symbol A (quoted) symbol
# @return logical - TRUE if symbol is the magrittr placeholder, FALSE otherwise.
is_placeholder <- function(symbol)
{
  identical(symbol, quote(.))
}
