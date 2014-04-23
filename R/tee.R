#' Pipe a result into an expression for its side-effect.
#'
#' Like \code{\%>\%} where the right-hand side is used for its
#' side-effect. The left-hand side is then passed along for
#' further processing. This can be useful, e.g. for logging
#' certain steps in a chain.
#'
#' @param lhs That which is to be piped
#' @param rhs a function call used for its side effect.
#' @return lhs
#' @rdname tee
#' @export
#' @examples
#' 1:10 %T>%
#'    lambda(x -> cat("LHS:", x, "\n")) %>%
#'    multiply_by(2)
`%T>%` <- pipe(tee = TRUE)

#' Create a pipe operator with a fixed side-effect.
#'
#' This is useful e.g. for logging, plotting, or printing
#' each step in a pipeline.
#'
#' @param fun a function which will be evaluated with
#'  left-hand side of a pipe expression as argument.
#' @return a pipe operator with the attached side effect.
#' @rdname pipe_with
#' @export
#' @examples
#' # Define a logging function
#' logger <- function(x)
#'   cat(as.character(Sys.time()), ":", nrow(x), "\n")
#'
#' # Create a pipe using the logger.
#' `%L>%` <- pipe_with(logger)
#'
#' # Test it:
#' iris %L>%
#'    subset(Species == "setosa") %L>%
#'    subset(Sepal.Length > 5) %L>%
#'    tail(10)
pipe_with <-
  function(fun)
    if (!is.function(fun)) {
      stop("Argument `fun` must be a function.")
    } else {
      pipe(tee = fun)
    }
