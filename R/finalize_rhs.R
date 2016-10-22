#' Expand Right-hand Side Expression
#'
#' @param rhs A right-hand side expression 
#' @param pipe A pipe operator
#' 
#' @return An expanded right-hand side, including inserted dots and 
#'   added parentheses.
#' 
#' @noRd
expand_rhs <- function(rhs, pipe)
{
  if (is_exposition_pipe(pipe) || is_lambda_expression(rhs))
    rhs
  else if (is_function(rhs) || has_special_operator(rhs))
    function_call(rhs)
  else if (needs_dot(rhs)) 
    with_dot(rhs)
  else 
    rhs
}

#' Finalize a Right-hand Side Expression for a Specific Pipeline Function.
#'
#' @param raw_rhs A right-hand side as the user specified it.
#' @param pipe A pipe operator.
#' @param last logical indicating whether the right-hand side is the last in
#'   a pipeline.
#'   
#' @return A list of statements as they appear in the final pipeline function.
#' @noRd
finalize_rhs <- function(raw_rhs, pipe, last)
{
  rhs <- expand_rhs(raw_rhs, pipe)
  
  if (is_tee_pipe(pipe)) {
    # The tee operator simply calls the rhs, but if it is the last operation,
    # we need to return the dot value.
    
    if (isTRUE(last)) {
      call("{", rhs, quote(.))
    } else {
      rhs 
    }
    
  } else if (is_exposition_pipe(pipe)) {
    # When the exposition pipe is used, `with` is used. Assignment is done
    # unless it is the last operation.
    
    if (isTRUE(last)) {
      substitute(with(., r), list(r = rhs))
    } else {
      substitute(. <- with(., r), list(r = rhs))
    }
    
  } else {
    # Otherwise call the rhs and assign to dot unless it is the last operation.
    
    if (isTRUE(last)) {
      rhs
    } else {
      call("<-", quote(.), rhs) 
    }
  }
}