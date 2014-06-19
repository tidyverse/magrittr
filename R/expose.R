#' Expose the columns for direct use in an expression.
#'
#' This operator exposes columns/members the data.frame/list to the
#' expression on the right-hand side. This is useful when functions
#' do not have a data argument, i.e. there is no need to write
#' \code{data$var} to access \code{var}.
#'
#' @param lhs a data.frame or list.
#' @param rhs a call/expression.
#' @usage lhs \%$\% rhs
#' @rdname wrap
#' @export
`%$%` <- function(lhs, rhs) {

  # Check that the left-hand side expression is a data.frame or list.
  if (!is.data.frame(lhs) && !is.list(lhs))
    stop("left-hand side must be a list or data.frame.", call. = FALSE)

  # Check that the right-hand side is a call.
  rhs <- substitute(rhs)
  if (!is.call(rhs) && !is.symbol(rhs))
    stop("right-hand side must be symbol or a call.")

  # Evaluate the expression, exposing the contents of the left-hand side.
  eval(rhs, lhs, parent.frame())

}
