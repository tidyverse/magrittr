#' Prepare rhs According to Pipe
#' 
#' @param pipe A (quoted) pipe operator
#' @param rhs A rhs expression
#' @param last logical indicating whether an expression is the last
#' @noRd
prepare_rhs <- function(pipe, rhs, idx, last)
{
  rhs_dot <- `if`(idx == 1, quote(.), as.name(paste0(idx - 1, "._")))
  lhs_dot <-  as.name(paste0(idx, "._"))
  rhs     <- eval(call("substitute", rhs, list(. = rhs_dot)))
  
  if (is_tee_pipe(pipe)) {
    # The tee operator simply calls the rhs, but if it is the last operation,
    # we need to return the dot value.
    if (isTRUE(last)) {
      call("{", rhs, rhs_dot)
    } else {
      call("let", lhs_dot, call("{", rhs, rhs_dot)) 
    }
    
  } else if (is_exposition_pipe(pipe)) {
    # When the exposition pipe is used, `with` is used. Assignment is done
    # unless it is the last operation.
    
    if (isTRUE(last)) {
      substitute(with(., r), list(r = rhs, . = rhs_dot))
    } else {
      substitute(let(l., with(r., r)), list(r = rhs, l. = lhs_dot, r. = rhs_dot))
    }
    
  } else {
    # Otherwise call the rhs and assign to dot unless it is the last operation.
    
    if (isTRUE(last)) {
      rhs
    } else {
      call("let", lhs_dot, rhs) 
    }
  }
}



