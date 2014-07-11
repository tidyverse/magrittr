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
#'  Package: \tab magrittr   \cr
#'  Type:    \tab Package    \cr
#'  Version: \tab 1.1.0      \cr
#'  Date:    \tab 2014-01-01 \cr
#'  License: \tab MIT        \cr
#' }
#' The main feature is provided by the operator \code{\%>\%}. It takes a value
#' (e.g. a data.frame) on the left and a function expression on the right, see the
#' examples. One can use a single dot, \code{`.`},  as a placeholder for the
#' value on the left.
#' @author Stefan Milton Bache and Hadley Wickham.
#'
#' Maintainer: Stefan Holst Milton Bache <stefan[at]stefanbache.dk>
NULL

#' Function to make a piping environment.
#'
#' This function is used internally by magrittr to construct environments
#' for evaluation of chain components.
#'
#' @param parent the parent which to assign to the new environment.
#' @param compound a call which will be used as lhs in compound assignment.
#'        If not used, set to NULL. This is used to pass forward the
#'        compound call when environments are locked.
#'
#' @return an environment.
pipe_env <- function(parent, compound = NULL)
{
  # Create a new environment, and set top-level
  env <- new.env(parent = parent)

  env[["__env__"]]      <- env       # reference to "self"
  env[["__locked__"]]   <- FALSE     # controls whether the env can be re-used.
  env[["__compound__"]] <- compound  # a call for compound assignemt. Can be
                                     #  set here, in cases of locked envirs.

  env
}

#' Function to create a pipe operator.
#'
#' @param tee logical indicating whether the left-hand side should be returned
#' rather than the result of the piped expression.
#'
#' @param compound logical indicating whether the resulting pipe should
#' function as a compound assignment pipe operator.
#'
#' @return When tee is FALSE a standard pipe operator is returned. When tee is
#'   TRUE, a tee operator is returned, i.e. an operator for which
#'   the right-hand side is used for the side-effect and the left-hand side
#'   is returned.
#'
#' @rdname magrittr-internal
#'
#' @details This is not exported.
pipe <- function(tee = FALSE, compound = FALSE)
{
  if (tee && compound)
    stop("Invalid pipe specification.", call. = FALSE)

  function(lhs, rhs)
  {
    # Capture unevaluated arguments
    lhs <- substitute(lhs)
    rhs <- substitute(rhs)

    # reference the parent frame
    parent <- parent.frame()

    # Should rhs be evaluated first due to parentheses?
    if (is.call(rhs) && identical(rhs[[1]], quote(`(`)))
      rhs <- eval(rhs, parent, parent)

    # Check right-hand side
    if (!any(is.symbol(rhs), is.call(rhs), is.function(rhs)))
      stop("RHS should be a symbol, a call, or a function.")

    # Get an environment for evaluation of left-hand side.
    if (exists("__env__", parent, mode = "environment", inherits = FALSE)) {

      # get the existing environment and flag this as not being top-level
      env <- get("__env__", parent)

      # If it is locked, make a new one. Since compound is passed along in this
      # case, we require that toplevel still be FALSE.
      if (env[["__locked__"]])
        env <- pipe_env(parent, compound = env[["__compound__"]])
      toplevel <- FALSE

    } else {

      # Create a new environment, and set top-level
      env <- pipe_env(parent)
      toplevel <- TRUE

    }

    # If this is a compound pipe call, then make sure that it is the only one
    # and store lhs in the environment.
    if (compound) {

      if (!is.null(env[["__compound__"]]))
        stop("Cannot use compound assignment more that once in a chain.",
             call. = FALSE)

      env[["__compound__"]] <- lhs

    }

    # Find an appropriate name for lhs to use. If at top-level
    # or if tee, then try to mimic call, otherwise use "."
    if (!toplevel && !tee) {
      nm <- "."
    } else {
      nm <- paste(deparse(lhs), collapse = "")
      nm <-
        if ((is.call(lhs) || is.name(lhs)) && nchar(nm) < 9900) nm else "."
    }

    # carry out assignment. The name "." also points the resulting
    # value, to allow accessing the left-hand side in nested expressions.
    env[[nm]] <- env[["."]] <- eval(lhs, env)

    # A temporary check for and warn about deprecated use of anonymous
    # functions not enclosed in parentheses.
    if (is.call(rhs) && deparse(rhs[[1]]) %in% c("function", "lambda", "l")) {

      rhs <- eval(call("(", rhs), parent.frame(), parent.frame())
      warning("Using anonymous functions without enclosing parentheses ",
              "has been deprecated.\nCurrent call has been altered, but please ",
              "change your code.")

    }

    # Deal with sitatuations where the right-hand side is a raw function.
    if (is.function(rhs)) {

      # Attach function in environment
      env[["__fun__"]] <- rhs

      # Construct the expression/call
      e <- call("__fun__", as.name(nm))

    } else {

      # Otherwise, construct the final expression to evaluate from lhs and rhs.
      # Scenarios:
      #   * rhs is a function name (symbol) and parens are omitted.
      #   * rhs has one or more dots that qualify as placeholder for lhs.
      #   * lhs is placed as first argument in rhs call.
      if (is.symbol(rhs)) {

        if (!exists(deparse(rhs), env, mode = "function"))
          stop("RHS appears to be a function name, but it cannot be found.")

        e <- call(as.character(rhs), as.name(nm))

      } else {

        # Match `.` placeholder at outmost level.
        dots <-
          c(FALSE, vapply(rhs[-1], identical, quote(.), FUN.VALUE = logical(1)))

        if (any(dots)) {

          # Replace with lhs
          rhs[dots] <- rep(list(as.name(nm)), sum(dots))
          e <- rhs

        } else {

          # Otherwise insert in first position
          e <- as.call(c(rhs[[1]], as.name(nm), as.list(rhs[-1])))

        }

      }

    }

    # From now on, this environment cannot be re-used.
    env[["__locked__"]] <- TRUE

    # Evaluate the call
    res       <- withVisible(eval(e, env, env))
    visibly   <- res$visible
    to.return <- if (tee) env[[nm]] else res$value

    # clean the environment to keep it light in long chains.
    if (nm != ".")
      rm(list = nm, envir = env)

    if (toplevel && !is.null(env[["__compound__"]])) {

      # Compound operator was used, so assign the result, rather than return it.
      eval(call("<-", get("__compound__", env), to.return), parent, parent)

    } else if (tee) {

      to.return

    } else {

      if (visibly) to.return else invisible(to.return)

    }
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

#' Compound assignment pipe operator
#'
#' Use to overwrite/mask the left-hand side with the result of
#' piping it forward into the right-hand side, which itself may be a chain.
#'
#' @param lhs a symbol or expression which may serve as left-hand
#'        side for \code{`<-`}.
#' @param rhs a function/call/expression/chain.
#' @return No return value. Works by assigning the result.
#' @rdname compound.op
#' @export
#' @examples
#'
#' x <- 1:10
#'
#' x %<>% replace(1:2, 0)
#' x %<>% sqrt %T>% plot
#'
#' some.data <- iris
#' colnames(some.data) %<>% paste0("!")
#' some.data[, 1] %<>% multiply_by(2)
`%<>%` <- pipe(compound = TRUE)
