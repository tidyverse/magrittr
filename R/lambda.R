#' Shorthand notation for anonymous/lambda functions
#' in magrittr pipelines.
#'
#' It is suggested to use this for anonymous functions when composing chains
#' with magrittr. It is shorter and has a signature designed for the purpose
#' (i.e. it takes a value as the first argument to be fed into the function),
#' and it avoids the high precedence of the \code{function} keyword.
#'
#' \code{lambda} has a special syntax, where the expression is defined as
#' \code{symbol -> expression}. The alias \code{l} is shorthand for \code{lambda}.
#' If both \code{value} and \code{expression} is provided, the resulting function
#' is evaluated with \code{value} as input; otherwise the function is returned.
#'
#' @param value the value to be fed into the function
#' @param expr A special kind of expression for the anonymous function.
#'   The syntax is \code{symbol -> expression}, see the examples.
#' @return The anonymous function is evaluated and the result is returned
#'   (unless \code{value} is missing, in which case the function itself is
#'    returned.)
#' @rdname lambda
#' @export
#' @examples
#' lambda(x -> x^2 + 2*x)
#'
#' sapply(1:10, lambda(x -> x^2))
#'
#' Filter(lambda(x -> x > 0), rnorm(100))
#'
#' iris %>%
#'   lambda(dfr -> rbind(dfr %>% head, dfr %>% tail))
#'
#' 1:10 %>%
#'   sin %>%
#'   lambda(x -> { d <- abs(x) > 0.5; x*d })
lambda <- function(value, expr)
{

  shift <- missing(expr)
  expr  <- if (shift) substitute(value) else substitute(expr)

  if (!identical(expr[[1]], quote(`<-`)))
    stop("Malformed expression. Expected format is symbol -> expression.")
  if (!is.symbol(expr[[3]]))
    stop("Malformed expression. 'sym' in 'sym -> expression' is not a symbol.")

  # Construct the argument pairlist
  pl   <- as.pairlist({ al <- list(); `[[<-`(al, as.character(expr[[3]]), ) })

  result <- eval(call("function", pl, expr[[2]]), parent.frame(), parent.frame())
  if (shift) result else result(value)
}

#' @rdname aliases
#' @usage NULL
#' @export
l <- lambda

