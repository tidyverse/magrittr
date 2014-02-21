#' Pipe an object forward into a function call/expression.
#'
#' The \code{\%>\%} operator pipes the left-hand side into an expression on the
#' right-hand side. The expression can contain a \code{.} as placeholder to
#' indicate the position taken by the object in the pipeline. If not present,
#' it will be squeezed in as the first argument. If the right-hand side
#' expression is a function call that takes only one argument, one can omit
#' parentheses and the \code{.}. Only the outmost call is matched against the
#' dot, which means that e.g. formulas can still use a dot which will not be
#' matched. Nested functions will not be matched either.
#'
#' @param lhs That which is to be piped
#' @param rhs the pipe to be stuffed with tobacco.
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
`%>%` <-
  function(lhs, rhs)
  {

    # Capture unevaluated arguments
    lhs <- substitute(lhs)
    rhs <- substitute(rhs)

    # Check right-hand side
    if (!any(is.symbol(rhs), is.call(rhs), is.function(rhs)))
      stop("RHS should be a symbol, a call, or a function.")

    # Case of a function: rare but possible
    if (is.function(rhs))
      return(rhs(eval(lhs, parent.frame(), parent.frame())))

    # Anonymous function:
    if (is.call(rhs) && deparse(rhs[[1]]) == "function")
      return(eval(rhs, parent.frame(), parent.frame())
            (eval(lhs, parent.frame(), parent.frame())))

    # In remaining cases, LHS will be evaluated and stored in a new environment.
    env <- new.env(parent = parent.frame())

    # Find an appropriate name to use for evaluation:
    #   deparse(lhs) is useful for preserving the call
    #   but is not always feasible, in which case __LHS is used.
    #   It is also necessary to restrict the size of the name
    #   for a few special cases.
    nm.tmp <- paste(deparse(lhs), collapse = "")
    nm  <-
      if (object.size(nm.tmp) < 1e4 && (is.call(lhs) || is.name(lhs)))
        nm.tmp
      else
        '__LHS'

    # carry out assignment.
    env[[nm]] <- eval(lhs, env)

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

    # Smoke the pipe (evaluate the call)
    eval(e, env)
  }

