# Split an expression into its components.
#
# This function splits a pipe call into its components: its 
# left-hand side, a sequnce of right-hand sides, and the individual pipe
# components.
# 
# @param a non-evaluated pipe-line expression.
# @return a list with components \code{lhs}, \code{calls}, and \code{pipes}.
pipe_list <- function(expr, env)
{
  calls <- list()
  pipes <- list()

  i <- 1L 
  while(is.call(expr) && is_pipe(expr[[1L]])) {
    pipes[[i]] <- expr[[1L]]
    rhs <- expr[[3L]]

    if (is_parenthesized(rhs))
      rhs <- eval(rhs, env, env)

    calls[[i]] <- 
      if (is_function(rhs))
        prepare_function(rhs)
      else if (is_funexpr(rhs))
        prepare_funexpr(rhs)
      else if (is_first(rhs)) 
        prepare_first(rhs)
      else 
        rhs

    if (identical(calls[[i]][[1L]], quote(`function`)))
      stop("Anonymous functions myst be parenthesized", call. = FALSE)

    expr <- expr[[2L]]
    i <- i + 1L
  }

  list(calls = rev(calls), pipes = rev(pipes), lhs = expr)
}
