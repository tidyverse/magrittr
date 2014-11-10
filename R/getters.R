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
