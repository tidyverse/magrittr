# Split a chain expression into its components.
#
# This function splits a chain of pipe calls into its components: its 
# left-hand side, a sequnce of right-hand sides, and the individual pipe
# components.
# 
# @param a non-evaluated pipe-line expression.
# @return a list with components \code{lhs}, \code{rhss}, and \code{pipes}.
split_chain <- function(expr, env)
{
  rhss <- list()
  pipes <- list()

  i <- 1L 
  while(is.call(expr) && is_pipe(expr[[1L]])) {
    pipes[[i]] <- expr[[1L]]
    rhs <- expr[[3L]]

    if (is_parenthesized(rhs))
      rhs <- eval(rhs, env, env)

    rhss[[i]] <- 
      if (is_dollar(pipes[[i]]))
        rhs
      else if (is_function(rhs))
        prepare_function(rhs)
      else if (is_funexpr(rhs))
        prepare_funexpr(rhs)
      else if (is_first(rhs)) 
        prepare_first(rhs)
      else 
        rhs

    if (is.call(rhss[[i]]) && identical(rhss[[i]][[1L]], quote(`function`)))
      stop("Anonymous functions myst be parenthesized", call. = FALSE)

    expr <- expr[[2L]]
    i <- i + 1L
  }

  list(rhss = rev(rhss), pipes = rev(pipes), lhs = expr)
}
