#' Function to prepare a block of expressions for pipe chains.
#'
#' Alternative to \code{defer}. Very experimental, and name is up to debate.
#' This is useful when a sequence of expressions, say \code{a \%>\% b \%>\% c},
#' contains a subsequence, say \code{b \%>\% c}, which is frequently used.
#' \code{defer} allows you to compose this subsequence into a singleton which
#' can be used in subsequent pipe-lines.
#'
#' @param expr A chain of expressions to be prepared for later use.
#' @param pipe The pipe to be used. Defaults to \code{\%>\%}.
#'   Defaults to \code{quote(x)}.
#' @return A function composed by the arguments.
#' @rdname prepare
#' @export
#' @examples
#' ilm <- prepare(lm(iris) \%>\% summary)
#'
#' ilm(Sepal.Length ~ .)
#' ilm(Sepal.Length ~ . - Species)
#'
#' ilm <- prepare(lm(Sepal.Length ~ ., data = .) %>% summary)
#' ilm(iris)
#'
#' verbose_na.omit <-
#'   prepare(lambda(cat("No. of NAs removed.", x %>% is.na %>% sum, "\n\n")) %>%
#'           na.omit, "%T>%")
#'
#' iris[1:10, 1] <- NA
#'
#' iris %>% verbose_na.omit %>% head
prepare <- function(expr, pipe = "%>%")
{
  expr <- substitute(expr)
  if (!is.name(expr) && !is.call(expr))
    stop("Argument expected to be a name or a call")
  if (length(expr) == 1) {
    eval(substitute(lambda(, e), list(e = call(pipe, quote(x), expr))))
  } else {
    pos <- if (length(expr[[2]]) > 1) 2 else 1
    expr[[pos]] <- call(pipe, quote(x), expr[[pos]])
    eval(substitute(lambda(, e), list(e = expr)))
  }
}
