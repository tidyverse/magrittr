#' Debugging function for magrittr pipelines.
#'
#' This function is a wrapper around \code{browser}, which makes it
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
