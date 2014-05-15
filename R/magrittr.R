#' @name magrittr
#' @title magrittr - a forward-pipe operator for R
#' @docType package
#' @description This package provides pipe-forwarding mechanisms similar to
#' (but not exactly like) e.g. F#'s pipe-forward operator. The semantics of
#' magrittr yield clean and readable code which can be read from left to right,
#' rather than from the inside and out (which is the case with nested function
#' calls), and reduce the need for temporary value bindings. This It is
#' particularly useful for manipulating data frames etc, where multiple steps
#' are needed before arriving at the desired result. The package also contains
#' useful functions/aliases which fit well into the syntax promoted by the
#' package. For a brief introduction, see \code{vignette("magrittr")}.
#' @details
#' \tabular{ll}{
#'  Package: \tab magrittr            \cr
#'  Type:    \tab Package             \cr
#'  Version: \tab 1.0.1               \cr
#'  Date:    \tab 2014-01-14          \cr
#'  License: \tab MIT + file LICENCE. \cr
#' }
#' The main feature is provided by the \code{\%>\%} binary operator. It takes a
#' value (e.g. a data.frame) on the left-hand side and a function or expression
#' on the right-hand side, see \code{\link{\%>\%}}.
#' @author Stefan Milton Bache and Hadley Wickham.
#'
#' Maintainer: Stefan Holst Milton Bache <stefan[at]stefanbache.dk>
NULL

#' Pipe an object forward into a function call/expression.
#'
#' The \code{\%>\%} operator pipes the left-hand side into an expression on the
#' right-hand side. The expression can contain a \code{.} as placeholder to
#' indicate the position taken by the object in the pipeline. If not present,
#' value  will be placed as the first argument. If the right-hand side
#' expression is a function call that takes only one argument, one can omit
#' parentheses and the \code{.}. Only the outmost call is matched against the
#' dot, which means that e.g. formulas can still use a dot which will not be
#' matched. Nested functions will not be matched either.
#'
#' When the right-hand side expression is enclosed in parentheses, it is
#' evaluated before the left-hand side is passed on, which can be
#' used when the right-hand side itself evaluates to the relevant
#' function or call. It is advised, but not strictly necessary, to parenthesize
#' anonymous function definitions when used in pipelines.
#'
#' @param lhs The value to be piped
#' @param rhs A function or expression
#' @rdname pipe
#' @export
#' @examples
#' \dontrun{
#' library(dplyr)
#' library(Lahman)
#'
#' Batting %>%
#'   group_by(playerID) %>%
#'   summarise(total = sum(G)) %>%
#'   arrange(desc(total)) %>%
#'   head(5)
#'
#'
#' iris %>%
#'   filter(Petal.Length > 5) %>%
#'   select(-Species) %>%
#'   colMeans
#'
#' iris %>%
#'   aggregate(. ~ Species, ., mean)
#'
#' rnorm(1000) %>% abs %>% sum
#' }
#'
#' rnorm(1000) %>%
#'  (function(x) {
#'    hist(x)
#'    x
#'  })
#'
#' 1:10 %>% (call("sum"))
#'
#' 1:10 %>% (substitute(a(), list(a = sum)))
`%>%` <-
  function(lhs, rhs)
  {

    # Capture unevaluated arguments
    lhs <- substitute(lhs)
    rhs <- substitute(rhs)

    # Should rhs be evaluated first due to parentheses?
    if (is.call(rhs) && identical(rhs[[1]], quote(`(`)))
      rhs <- eval(rhs, parent.frame(), parent.frame())

    # Check right-hand side
    if (!any(is.symbol(rhs), is.call(rhs), is.function(rhs)))
      stop("RHS should be a symbol, a call, or a function.")

    # In remaining cases, LHS will be evaluated and stored in a new environment.
    env <- new.env(parent = parent.frame())

    # Find an appropriate name to use for evaluation:
    #   deparse(lhs) is useful for preserving the call
    #   but is not always feasible, in which case __LHS is used.
    #   It is also necessary to restrict the size of the name
    #   for a few special cases.
    nm <- paste(deparse(lhs), collapse = "")
    nm <- if (nchar(nm) < 9900 && (is.call(lhs) || is.name(lhs))) nm else "__LHS"

    # carry out assignment.
    env[[nm]] <- eval(lhs, env)

    if (is.function(rhs)) {

      # Case of a function: rare but possible
      res <- withVisible(rhs(env[[nm]]))

    } else if (is.call(rhs) && deparse(rhs[[1]]) == "function") {

      # Anonymous function:
      res <- withVisible(eval(rhs, parent.frame(), parent.frame())(
                         eval(lhs, parent.frame(), parent.frame())))

    } else {

      # Construct the final expression to evaluate from lhs and rhs. Scenarios:
      #  1)  rhs is a function name and parens are omitted.
      #  2a) rhs has one or more dots that qualify as placeholder for lhs.
      #  2b) lhs is placed as first argument in rhs call.
      if (is.symbol(rhs)) {

        if (!exists(deparse(rhs), parent.frame(), mode = "function"))
          stop("RHS appears to be a function name, but it cannot be found.")
        e <- call(as.character(rhs), as.name(nm)) # (1)

      } else {

        # Find arguments that are just a single .
        dots <- c(FALSE, vapply(rhs[-1], identical, quote(.), FUN.VALUE = logical(1)))
        if (any(dots)) {
          # Replace with lhs
          rhs[dots] <- rep(list(as.name(nm)), sum(dots))
          e <- rhs
        } else {

          # Otherwise insert in first position
          e <- as.call(c(rhs[[1]], as.name(nm), as.list(rhs[-1])))
        }

      }

      res <- withVisible(eval(e, env))
    }

    if (res$visible) res$value else invisible(res$value)
  }

