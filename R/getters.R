#' Extract function(s) from a functional sequence.
#'
#' @rdname fseq
#' @param x A functional sequence
#' @param ... index/indices.
#' @return A function.
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
	environment(y)[["__fseq__"]] <- functions(x)[...]
	y
}

