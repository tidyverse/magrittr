#' Extract function(s) from a functional sequence.
#'
#' Functional sequences can be subset using single or double brackets.
#' A single-bracket subset results in a new functional sequence, and
#' a double-bracket subset results in a single function.
#'
#' @rdname fseq
#' @param x A functional sequence
#' @param ... index/indices. For double brackets, the index must be of length 1.
#' @return A function or functional sequence.
#' @export
`[[.fseq` <- function(x, ...)
{
  functions(x)[[...]]
}

#' @rdname fseq
#' @export
`[.fseq` <- function(x, ...)
{
  y  <- x
  environment(y) <- new.env(parent = parent.env(environment(x)))
  environment(y)[["_function_list"]] <- functions(x)[...]
  y
}


#' Get the calling environment of the pipe chain
#'
#' This function extracts the original environment from which the pipe
#' chain was called.
#'
#' \code{calling_env()} must be called at the top level of the pipe
#' chain component.
#' @return If called inside a pipe chain, the calling environment of
#'   the pipe chain. Otherwise, the parent frame.
#' @seealso \code{\link{parent.frame}()}
#' @export
calling_env <- function() {
  maybe_pipe_env <- parent.frame(5)
  if (exists("_fseq", envir = maybe_pipe_env)) {
    parent.env(maybe_pipe_env)
  } else {
    parent.frame(2)
  }
}
