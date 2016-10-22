#' Debugging function for magrittr pipelines.
#'
#' This function is a wrapper around \code{browser}, which makes it
#' easier to debug at certain places in a magrittr pipe chain.
#'
#' @param . a value
#' @return .
#'
#' @export
debug_pipe <- function(.)
{
  if (interactive())
    evalq(browser(), envir = parent.frame())
  
  .
}
