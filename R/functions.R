#' Extract the function list from a functional sequence.
#'
#' This can be used to extract the list of functions inside a functional
#' sequence created with a chain like \code{. \%>\% foo \%>\% bar}.
#'
#' @param fseq A functional sequence ala magrittr.
#' @return a list of functions
#' 
#' @export
functions <- function(fseq)
{
  if (!"fseq" %in% class(fseq))
    stop("Object is not a functional sequence.", call. = FALSE)
  environment(fseq)[["_function_list"]]
}

#' Print method for functional sequence.
#'
#' @param x A functional sequence object
#' @param ... not used.
#' @return x
#'
#' @export
print.fseq <- function(x, ...)
{
  flist <- functions(x)

  cat("Functional sequence with the following components:\n\n")
  lapply(seq_along(flist), 
      function(i) cat(" ", i, ". ", deparse(body(flist[[i]])), "\n", sep = ""))
  cat("\nUse 'functions' to extract the individual functions.", "\n")
  x
}
