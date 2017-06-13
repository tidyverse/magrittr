#' Debugging function for magrittr pipelines.
#'
#' This function is a wrapper around `browser`, which makes it
#' easier to debug at certain places in a magrittr pipe chain.
#'
#' @param x a value
#' @return x
#'
#' @export
debug_pipe <- function(x)
{
  browser()
  x
}

#' Debugging function for functional sequences.
#'
#' This is a utility function for marking functions in a functional 
#' sequence for debbuging.
#'
#' @param fseq a functional sequence.
#' @param ... indices of functions to debug. 
#' @return `invisible(NULL)`.
#'
#' @export
debug_fseq <- function(fseq, ...)
{
  is_valid_index <- function(i) i %in% 1:length(functions(fseq))

  indices <- as.list(...)
    if (!any(vapply(indices, is.numeric, logical(1L))) ||
        !any(vapply(indices, is_valid_index, logical(1L))))
      stop("Index or indices invalid.", call. = FALSE)

  invisible(lapply(indices, function(i) debug(functions(fseq)[[i]])))
}

#' @rdname debug_fseq
#' @export
undebug_fseq <- function(fseq)
{
  for (i in 1:length(functions(fseq)))
    if (isdebugged(functions(fseq)[[i]])) 
      undebug(functions(fseq)[[i]])
}
	
