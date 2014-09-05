pipe <- function()
{
  function(lhs, rhs)
  {
    parent <- parent.frame()
    env    <- new.env(parent = parent)

    chain_parts <- split_chain(match.call(), env = env)

    pipes <- chain_parts[["pipes"]] # the pipe operators.
    rhss  <- chain_parts[["rhss" ]] # the right-hand sides.
    lhs   <- chain_parts[["lhs"  ]] # the left-hand side.

    env[["_function_list"]] <- 
      lapply(1:length(rhss), 
             function(i) wrap_function(rhss[[i]], pipes[[i]], parent))

    env[["_fseq"]] <-
     `class<-`(eval(quote(function(value) freduce(value, `_function_list`)), 
                    env, env), c("fseq", "function"))
 
    # make freduce available to the resulting function 
    # even if magrittr is not loaded.
    env[["freduce"]] <- freduce 
    
    if (is_placeholder(lhs)) {
      # return the function itself.
      env[["_fseq"]]
    } else {
      # evaluate the LHS
      env[["_lhs"]] <- eval(lhs, parent, parent)
      
      # compute the result by applying the function to the LHS
      result <- withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
      
      # If compound assignment pipe operator is used, assign result
      if (is_compound_pipe(pipes[[1L]])) {
        eval(call("<-", lhs, result[["value"]]), parent, parent)
      # Otherwise, return it.
      } else {
        if (result[["visible"]]) 
          result[["value"]] 
        else 
          invisible(result[["value"]])
      }
    }
  }
}

#' magrittr pipe
#' 
#' @param lhs either a value or the magrittr placeholder.
#' @param rhs a function call using the magrittr semantics.
#' @return value of piping the left-hand side into the right-hand side call.
#' 
#' @details When the magrittr placeholder, \code{.}, is used as \code{lhs}
#' The result will be a functional sequence, i.e. a function which applies
#' the entire chain of right-hand sides in turn to its input.
#' 
#' @rdname pipe
#' @export
`%>%`  <- pipe()

#' @rdname pipe
#' @export
`%<>%` <- pipe() 

#' @rdname pipe
#' @export
`%T>%` <- pipe() 
