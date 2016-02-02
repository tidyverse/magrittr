#' Split a pipeline expression into its components.
#'
#' This function splits a chain of pipe calls into its components: its 
#' left-hand side, a sequnce of right-hand sides, and the individual pipe
#' components.
# 
#' @param expr a non-evaluated pipe-line expression.
#' @param env an environment in which to evaluate rhs parts.
#' @return a list with components \code{lhs} (the left-hand side), 
#'   \code{rhss} (the right-hand sides), and \code{pipes}.
#' @noRd
split_pipeline <- function(expr, env)
{
  # lists for holding the right-hand sides and the pipe operators.
  rhss  <- list()
  pipes <- list()

  # Process the call, splitting it at each valid magrittr pipe operator.
  i <- 1L 
  while(is.call(expr) && is_pipe(expr[[1L]])) {
    pipes[[i]] <- expr[[1L]]
    rhs <- expr[[3L]]

    if (is_rhs_formula(rhs))
      rhs <- rhs[[2L]]
          
    if (is_parenthesized(rhs))
      rhs <- eval(rhs, env, env)

    rhss[[i]] <- 
      if (is_exposition_pipe(pipes[[i]]) || is_lambda_expression(rhs))
        rhs
      else if (is_function(rhs) || has_special_operator(rhs))
        function_call(rhs)
      else if (needs_dot(rhs)) 
        with_dot(rhs)
      else 
        rhs

    # Make sure no anonymous functions without parentheses are used.
    if (is.call(rhss[[i]]) && identical(rhss[[i]][[1L]], quote(`function`)))
      stop("Anonymous functions must be parenthesized", call. = FALSE)

    expr <- expr[[2L]]
    i <- i + 1L
  }
  
  # return the components; expr will now hold the left-most left-hand side.
  list(rhss = rev(rhss), pipes = rev(pipes), lhs = expr)
}
