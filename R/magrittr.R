#' @name magrittr
#' @title magrittr - a forward-pipe operator for R
#' @docType package
#' @description This package provides pipe-forwarding mechanisms similar to
#' (but not exactly like) e.g. F#'s pipe-forward operator. It allows writing
#' code in a clean and readable way, and avoids making a
#' mess in situations of multiple nested function calls. It is particularly
#' useful when manipulating data frames etc. The package also contains
#' useful functions which fit well into the syntax advocated by the package. For
#' a brief introduction, see \code{vignette("magrittr")}.
#' @details
#' \tabular{ll}{
#'  Package: \tab magrittr\cr
#'  Type: \tab Package\cr
#'  Version: \tab 1.1.0\cr
#'  Date: \tab 2014-01-01\cr
#'  License: \tab MIT\cr
#' }
#' The main feature is provided by the operator \code{\%>\%}. It takes a value
#' (e.g. a data.frame) on the left and a function expression on the right, see the
#' examples. One can use a single dot, \code{`.`},  as a placeholder for the
#' value on the left.
#' @author Stefan Milton Bache and Hadley Wickham.
#'
#' Maintainer: Stefan Holst Milton Bache <stefan[at]stefanbache.dk>
NULL

#' Function to create a pipe operator.
#'
#' @param tee logical indicating whether the left-hand side should be returned
#' rather than the result of the piped expression.
#'
#' @return When tee is FALSE a standard pipe operator is returned. When tee is
#'   TRUE, a tee operator is returned, i.e. an operator for which
#'   the right-hand side is used for the side-effect and the left-hand side
#'   is returned.
#'
#' @rdname magrittr-internal
#'
#' @details This is not exported.
pipe <- function(tee = FALSE)
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

    # Make an environment in which lhs is to be evaluated.
    env <- new.env(parent = parent.frame())

    # Find an appropriate name to use for evaluation:
    #   deparse(lhs) is useful for preserving the call
    #   but is not always feasible, in which case __LHS is used.
    #   It is also necessary to restrict the size of the name
    #   for a few special cases.
    nm <- paste(deparse(lhs), collapse = "")
    nm <-
      if (nchar(nm) < 9900 &&
            (is.call(lhs) || is.name(lhs))) nm else "."

    # carry out assignment. The name "." also points the resulting
    # value, to allow accessing the left-hand side in nested expressions.
    env[[nm]] <- env[["."]] <- eval(lhs, env)

    # First, a temporary check for and warn about deprecated use of anonymous
    # functions not enclosed in parentheses.
    if (is.call(rhs) && deparse(rhs[[1]]) %in% c("function", "lambda", "l")) {

      rhs <- eval(call("(", rhs), parent.frame(), parent.frame())
      warning("Using anonymous functions without enclosing parentheses ",
              "has been deprecated.\nCurrent call has been altered, but please",
              "change your code.")

    }

    if (is.function(rhs)) {

      # Case of a function: rare but possible
      res <- withVisible(rhs(env[[nm]]))

    } else {

      # Construct the final expression to evaluate from lhs and rhs. Scenarios:
      #  1)  rhs is a function name (symbol) and parens are omitted.
      #  2a) rhs has one or more dots that qualify as placeholder for lhs.
      #  2b) lhs is placed as first argument in rhs call.
      if (is.symbol(rhs)) {

        if (!exists(deparse(rhs), parent.frame(), mode = "function"))
          stop("RHS appears to be a function name, but it cannot be found.")
        e <- call(as.character(rhs), as.name(nm)) # (1)

      } else {

        # Match `.` placeholder at outmost level.
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

    # Return either result or lhs if tee == TRUE
    if (is.logical(tee) && tee) {
      env[[nm]]
    } else {
      if (res$visible) res$value else invisible(res$value)
    }
  }

#' Pipe an object forward into a function call/expression.
#'
#' The \code{\%>\%} operator pipes the left-hand side into an expression on the
#' right-hand side. The expression can contain a \code{.} as placeholder to
#' indicate the position taken by the object in the pipeline. If not present,
#' it will be squeezed in as the first argument. If the right-hand side
#' expression is a function call that takes only one argument, one can omit
#' parentheses and the "\code{.}". Only the outmost call is matched against the
#' dot for the purpose of deciding the on placement of the left-hand side.
#' Using the "\code{.}" in nested calls/functions is also possible, but magrittr
#' will not try to book-keep the call in this case, which can be useful at
#' at times, see e.g. a plotting example below where labels change.
#'
#' @param lhs a value
#' @param rhs a function/call/expression. Enclose in parentheses to force
#' evaluation of rhs before piping is carried out, e.g. anonymous functions
#' or call-generating expressions.
#' @return The result of evaluting the right-hand side with the left-hand side
#' as the specified argument(s).
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
#'
#' # Here, "." is used in a nested call to show how the call is not preserved
#' # in this case. It is visualized by noting the y-axis label.
#' 1:10 %>% plot(., col = .)      # not nested
#' 1:10 %>% plot(I(.), col = .)   # nested.
#'
#' # This examples shows how the placement of the lhs is independent of
#' # using . in a nested call:
#' 1:10 %>% rep(.)     # like rep(1:10)
#' 1:10 %>% rep(I(.))  # like 1:10 %>% rep(., .) and rep(1:10, 1:10)
#' }
`%>%` <- pipe()
