#' compose a lambda function or chain of functions.
#'
#' This is an alternative syntax for generating anonymous functions.
#' When used in pipelines, the call should be enclosed in parentheses to
#' force evaluation of the function generation before the left-hand side
#' is inserted. If multiple lambda expressions are given they will be
#' nested in a single global function, and evaluated as a chain. Here
#' each input will be available to the next lambda expression (with its
#' initial value).
#'
#' \code{lambda}s have a special syntax, where the expression is defined as
#' \code{symbol ~ expression}. The alias \code{l} is shorthand for \code{lambda}.
#' Previous versions used symbol -> expression syntax, but this caused
#' problems with compiling packages. There is currently a warning if the
#' old syntax is used.
#'
#' @param ... A special kind of expressions for the anonymous function(s).
#'   The syntax is \code{symbol ~ expression}, see the examples.
#' @return a function.
#' @rdname lambda
#' @export
#' @examples
#' compose(x ~ x^2 + 2*x)
#'
#' sapply(1:10, compose(x ~ x^2))
#'
#' Filter(compose(x ~ x > 0), rnorm(100))
#'
#' iris %>%
#'   (compose(dfr ~ rbind(dfr %>% head, dfr %>% tail)))
#'
#' 1:10 %>%
#'   sin %>%
#'   (compose(x ~ {
#'     d <- abs(x) > 0.5
#'     x*d
#'   }))
compose <- function(...)
{
  dots <- lapply(as.list(substitute(list(...))[-1]), function(dot) {
    if (is.symbol(dot)) {
      dot <- call(as.character(dot), quote(.))
    }
    if (is.call(dot) && !identical(dot[[1]], quote(`~`))) {
      dot <- call("~", quote(.), dot)
    }
    dot
  })

  # Utility function to generate the different function expressions.
  generate <- function(expr, rhs = NULL, parens = FALSE, wrap = FALSE)
  {
    # Check that lambdas are of the right form x ~ expression_of(x)
    if (!is.call(expr) || !identical(expr[[1]], quote(`~`))) {
      stop("Malformed expression. Expected format is symbol ~ expression.",
           call. = FALSE)
    }

    if (!is.symbol(expr[[2]])) {
      stop("Malformed expression. Expecting one variable name on LHS",
           call. = FALSE)
    }

    # Construct the function inputs
    arg_name <- as.character(expr[[2]])
    args <- setNames(list(quote(expr = )), arg_name)
    body <- expr[[3]]

    # Construct a function with or without wrapper/parens
    cl <- if (wrap) {
      inner.cl <-
        call("%>%", expr[[2]], call("(", call("function", as.pairlist(args), body)))
      if (!is.null(rhs))
        inner.cl <- call("%>%", inner.cl, rhs)
      inner.cl
    } else {
      call("function", as.pairlist(args), body)
    }

    if (parens) call("(", cl) else cl
  }

  if (length(dots) == 1) {
    # If only a single lambda is provided; regular lambda function.
    cl <- generate(dots[[1]])

  } else {
    # Multiple lambdas are given. Nest them, and create a single overall lambda.
    cl <-
      Reduce(function(l, r) {
        substitute(a ~ b, list(
          a = l[[2]],
          b = generate(l, wrap = TRUE, rhs = generate(r, parens = TRUE))))
        },
        dots,
        right = TRUE)
    cl <- generate(cl)

  }

  # Evaluate the final function, and return.
  eval(cl, parent.frame(), parent.frame())
}

#' @rdname lambda
#' @export
lambda <- compose

#' @rdname lambda
#' @export
l <- lambda
