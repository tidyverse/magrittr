#' Shorthand notation for anonymous/lambda functions
#' in magrittr pipelines.
#'
#' This is an alternative syntax for generating anonymous functions.
#' When used in chains, the call should be enclosed in parentheses to
#' force evaluation of the function generation before the left-hand side
#' is inserted.
#'
#' \code{lambda} has a special syntax, where the expression is defined as
#' \code{symbol ~ expression}. The alias \code{l} is shorthand for \code{lambda}.
#' Previous versions used symbol -> expression syntax, but this caused
#' problems with compiling packages. There is currently a warning if the
#' old syntax is used.
#'
#' @param expr A special kind of expression for the anonymous function.
#'   The syntax is \code{symbol ~ expression}, see the examples.
#' @return a function.
#' @rdname lambda
#' @export
#' @examples
#' lambda(x ~ x^2 + 2*x)
#'
#' sapply(1:10, lambda(x ~ x^2))
#'
#' Filter(lambda(x ~ x > 0), rnorm(100))
#'
#' iris %>%
#'   (lambda(dfr ~ rbind(dfr %>% head, dfr %>% tail)))
#'
#' 1:10 %>%
#'   sin %>%
#'   (lambda(x ~ {
#'     d <- abs(x) > 0.5
#'     x*d
#'   }))
lambda <- function(expr)
{

  expr <- substitute(expr)

  # Temporary check for warning against syntax change.
  if (is.call(expr) && identical(expr[[1]], quote(`<-`))) {
    expr <- call("~", expr[[3]], expr[[2]])
    warning("The lambda syntax has changed to symbol ~ expression.\n",
            "Current call has been changed to match new syntax.",
            call. = FALSE)
  }
  #

  if (!is.call(expr) || !identical(expr[[1]], quote(`~`))) {
    stop("Malformed expression. Expected format is symbol ~ expression.",
      call. = FALSE)
  }
  if (!is.symbol(expr[[2]])) {
    stop("Malformed expression. Expecting one variable name on LHS",
      call. = FALSE)
  }

  # Construct the function
  arg_name <- as.character(expr[[2]])
  args <- setNames(list(quote(expr = )), arg_name)
  body <- expr[[3]]

  eval(call("function", as.pairlist(args), body), parent.frame())
}

#' @rdname lambda
#' @export
l <- lambda
