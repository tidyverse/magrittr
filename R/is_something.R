# Check whether a symbol is a valid magrittr pipe.
#
# @param pipe A quoted symbol
# @return logical - TRUE if a valid magrittr pipe, FALSE otherwise.
is_pipe <- function(pipe)
{
	identical(pipe, quote(`%>%`))   ||
	identical(pipe, quote(`%T>%`))  ||
	identical(pipe, quote(`%<>%`))
}

# Determine whether an non-evaluated call is parenthesized
#
# @param a non-evaluated expression
# @retun logical - TRUE if expression is parenthesized, FALSE otherwise.
is_parenthesized <- function(expr)
{
	is.call(expr) && identical(expr[[1]], quote(`(`))
}

# Check whether a pipe is a tee.
#
# @param pipe A (quoted) pipe
# @return logical - TRUE if pipe is a tee, FALSE otherwise.
is_tee <- function(pipe)
{
	identical(pipe, quote(`%T>%`))
}

# Check whether a pipe is the compound assignment pipe operator
#
# @param pipe A (quoted) pipe
# @return logical - TRUE if pipe is the compound assignment pipe, 
#   otherwise FALSE.
is_compound_pipe <- function(pipe)
{
	identical(pipe, quote(`%<>%`))
}


# Check whether a symbol is the magrittr placeholder.
#
# @param  symbol A (quoted) symbol
# @return logical - TRUE symbol is the magrittr placeholder, FALSE otherwise.
is_placeholder <- function(symbol)
{
	identical(symbol, quote(.))
}	
	
	
	