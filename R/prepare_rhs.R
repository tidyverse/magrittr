#' Prepare rhs According to Pipe
#' 
#' @param pipe A (quoted) pipe operator
#' @param rhs A rhs expression
#' @param last logical indicating whether an expression is the last
#' @noRd
prepare_rhs <- function(pipe, rhs, last)
{
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
