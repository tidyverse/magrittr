#' Tokenize an Expression Into Pipeline Components
#' 
#' @param expr A pipeline expression 
#' @param env The environment in which to evaluate parenthesized expression 
#'   components.
#'   
#' @return A list where the first entry is the left-hand side expression,
#'   then in turn a pipe operator and a right-hand side expression.
#'    
#' @noRd
tokenize_pipeline <- function(expr, env)
{
  if (is_parenthesized(expr))
    expr <- eval(expr, env, env)
  
  if (is_formularized(expr))
    expr <- expr[[2L]]
  
  if (is.call(expr) && length(expr) == 3L && is_pipe(expr[[1L]])) {
    c(tokenize_pipeline(expr[[2L]], env), expr[[1L]],
      tokenize_pipeline(expr[[3L]], env))
  } else {
    list(expr)
  }
}