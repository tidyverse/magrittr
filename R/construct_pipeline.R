#' Construct a Pipeline
#' 
#' @param expr A pipeline expression.
#' @param env An environment which is used for evaluation.
#' 
#' @return A list with elements, 'lhs' (the left-hand side expression),
#'  'fun' (the actual pipeline function), and 'compound' (a logical flag
#'  indicating whether the call uses compound assignment)
#'  
#' @noRd
construct_pipeline <- function(expr, env)
{
  tokens <- tokenize_pipeline(expr, env)
  
  lhs  <- tokens[[1L]]
  pipeline_tokens <- tokens[-1]
  
  evens <- seq_along(pipeline_tokens) %% 2L == 0L
  rhss  <- pipeline_tokens[ evens]
  pipes <- pipeline_tokens[!evens]
  last  <- seq_along(rhss) == length(rhss)
  
  statements <- Map(finalize_rhs, rhss, pipes, last)
  
  body <- as.call(c(quote(`{`), statements))
  
  fun <- eval(call("function", as.pairlist(alist(.=)), body), env)

  compound <- is_compound_pipe(pipes[[1]])
  
  list(lhs = lhs, fun = fun, compound = compound)
}


