#' Check whether a symbol is a valid magrittr pipe operator
#'
#' @param pipe A quoted symbol
#' @return logical: TRUE if a valid magrittr pipe, FALSE otherwise.
#' @noRd
is_pipe <- function(pipe)
{
  identical(pipe, quote(`%>%`))   ||
    identical(pipe, quote(`%T>%`))  ||
    identical(pipe, quote(`%<>%`))  ||
    identical(pipe, quote(`%$%`))
}

#' Determine whether an non-evaluated call is parenthesized
#'
#' @param a non-evaluated expression
#' @return logical: TRUE if expression is parenthesized, FALSE otherwise.
#' @noRd
is_parenthesized <- function(expr)
{
  is.call(expr) && identical(expr[[1L]], quote(`(`))
}

#' Check Whether a pipe is the tee operator.
#'
#' @param pipe A (quoted) pipe
#' @return logical: TRUE if pipe is a tee, FALSE otherwise.
#' @noRd
is_tee_pipe <- function(pipe)
{
  identical(pipe, quote(`%T>%`))
}

#' Check whether a pipe is the exposition pipe
#'
#' @param pipe A (quoted) pipe
#' @return logical: TRUE if pipe is the dollar pipe, FALSE otherwise.
#' @noRd
is_exposition_pipe <- function(pipe)
{
  identical(pipe, quote(`%$%`))
}

#' Check whether a pipe is the compound assignment pipe operator
#'
#' @param pipe A (quoted) pipe
#' @return logical: TRUE if pipe is the compound assignment pipe,
#'   otherwise FALSE.
#' @noRd
is_compound_pipe <- function(pipe)
{
  identical(pipe, quote(`%<>%`))
}

#' Check whether expression is a magrittr lambda (enclosed in curly braces)
#'
#' @param  expr An expression to be tested.
#' @return logical: TRUE if expr is enclosed in braces, FALSE otherwise.
#' @noRd
is_lambda_expression <- function(expr)
{
  is.call(expr) && identical(expr[[1L]], quote(`{`))
}

#' Check whether expression has operator with special behaviour
#' 
#' The operators with special treatment are ::, :::, $.
#'
#' @param  expr An expression to be tested.
#' @return logical: TRUE if expr contains `::` or `:::`, FALSE otherwise.
#' @noRd
has_special_operator <- function(expr)
{
  is.call(expr) &&
    (identical(expr[[1L]], quote(`::`))  || 
       identical(expr[[1L]], quote(`:::`)) ||
       identical(expr[[1L]], quote(`$`)))
}

#' Check whether a symbol is the magrittr placeholder.
#'
#' @param  symbol A (quoted) symbol
#' @return logical: TRUE if symbol is the magrittr placeholder, FALSE otherwise.
#' @noRd
is_dot_placeholder <- function(symbol)
{
  identical(symbol, quote(.))
}

#' Check whether a rhs is a formula
#'
#' @param  expr An expression to be tested
#' @return logical: TRUE if expr is a valid formyla, FALSE otherwise.
#' @noRd
is_rhs_formula <- function(expr)
{
  is.call(expr) && identical(expr[[1L]], quote(`~`)) && length(expr) == 2
}

#' Determine whether an expression counts as a function in a magrittr chain.
#'
#' @param a non-evaluated expression.
#' @return logical: TRUE if expr represents a function, FALSE otherwise.
#' @noRd
is_function <- function(expr)
{
  is.symbol(expr) || is.function(expr)
}

#' Prepare a magrittr rhs of funtion type
#'
#' @param a an expression which passes \code{is_function}
#' @return an expression prepared for functional sequence construction.
#' @noRd
function_call <- function(f)
{
  as.call(list(f, quote(.)))
}

#' Determine whether an expression needs the dot as first argument
#'
#' @param a non-evaluated expression.
#' @return logical: TRUE if expr needs the dot, FALSE otherwise.
#' @noRd
needs_dot <- function(expr)
{
  !any(vapply(expr[-1L], identical, logical(1L), quote(.)))
}

#' Prepare a magrittr rhs by inserting the dot as first argument
#'
#' @param a an expression which passes \code{needs_dot}
#' @return a call expression with a dot as first argument.
#' @noRd
with_dot <- function(expr)
{
  as.call(c(expr[[1L]], quote(.), as.list(expr[-1L])))
}
