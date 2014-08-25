pipe <- function()
{
  function(lhs, rhs)
  {
    parent <- parent.frame()
    cl     <- match.call()
    pl     <- pipe_list(cl)

    pipes <- pl[["pipes"]]
    calls <- pl[["calls"]]
    lhs   <- pl[["lhs"  ]]

    fseq <- 
      lapply(1:length(calls), 
        function(i) wrap_function(calls[[i]], pipes[[i]], parent))

    if (is_placeholder(lhs)) {
      env <- new.env(parent = parent)
      env[["__fseq__"]] <- fseq
     `class<-`(eval(quote(function(.) freduce(., `__fseq__`)),	env, env),
               c("fseq", "function"))
    } else {
      result <- withVisible(freduce(eval(lhs, parent, parent), fseq))
      if (is_compound_pipe(pipes[[1L]]))
        eval(call("<-", lhs, result[["value"]]), parent, parent)
      else 
        if (result[["visible"]]) 
          result[["value"]] 
        else 
          invisible(result[["value"]])
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
