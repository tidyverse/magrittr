#' Compose a chain block of expressions which can be deferred and re-used.
#'
#' This is useful when a sequence of expressions, say \code{a \%>\% b \%>\% c},
#' contains a subsequence, say \code{b \%>\% c}, which is frequently used.
#' \code{defer} allows you to compose this subsequence into a singleton which
#' can be used in subsequent pipe-lines.
#'
#' @param ... Expressions to be composed together with \code{\%>\%}
#' @param arg A name for the argument in the resulting function.
#'   Defaults to \code{quote(x)}.
#' @return A function composed by the arguments.
#' @rdname defer
#' @export
#' @examples
#' ilm <- defer(lm(iris), summary)
#'
#' ilm(Sepal.Length ~ .)
#' ilm(Sepal.Length ~ . - Species)
defer <- function(..., arg = quote(x))
{

  # List of elements with generic argument first.
  elems <-
    c(arg, as.list(substitute(list(...))[-1]))

  # Construct a call.
  cl <-
    as.call(parse(text = paste(elems, collapse = ' %>% ')))[[1]]

  # Evaluate and return the function
  eval(substitute(lambda(, cl, arg), list(cl = cl, arg = arg)))

}
