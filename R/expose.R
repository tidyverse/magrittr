#' Expose the columns for direct use in an expression.
#'
#' This operator exposes columns/members the data.frame/list to the
#' expression on the right-hand side. This is useful when functions
#' do not have a data argument, i.e. there is no need to write
#' \code{data$var} to access \code{var}.
#'
#' @param lhs a data.frame or list.
#' @param rhs a call/expression.
#' @usage lhs \%$\% rhs
#' @rdname expose
#' @export
`%$%` <- function(lhs, rhs)
{
  # Capture unevaluated arguments
  rhs <- substitute(rhs)

  # reference the parent frame
  parent <- parent.frame()

  # Check right-hand side
  if (!is.call(rhs) && !is.symbol(rhs))
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

  # From now on, this environment cannot be re-used.
  env[["__locked__"]] <- TRUE

  # Evaluate the call
  res       <- withVisible(eval(rhs, lhs, parent))
  visibly   <- res$visible
  to.return <- res$value

  if (toplevel && !is.null(env[["__compound__"]])) {

    # Compound operator was used, so assign the result, rather than return it.
    eval(call("<-", get("__compound__", env), to.return), parent, parent)

  } else {

    if (visibly) to.return else invisible(to.return)

  }
}
