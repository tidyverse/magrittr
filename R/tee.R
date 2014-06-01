#' Pipe a result into an expression for its side-effect.
#'
#' Like \code{\%>\%} where the right-hand side is used for its
#' side-effect. The left-hand side is then passed along for
#' further processing. This can be useful, e.g. for logging
#' certain steps in a chain.
#'
#' @param lhs a value
#' @param rhs a function/call/expression used for its side effect.
#' @return lhs
#' @rdname tee
#' @export
#' @examples
#' 1:10 %T>%
#'    (function(x) cat("LHS:", x, "\n")) %>%
#'    multiply_by(2)
`%T>%` <- pipe(tee = TRUE)
