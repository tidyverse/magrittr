#' Place a debug browser in a chain of commands.
#'
#' When using magrittr's piping syntax, it can be useful to
#' to debug at certain steps within a chain. This
#' is a simple wrapper around \code{browser} for this purpose.
#'
#' @param x A value.
#' @return returns the argument \code{x}.
#' @rdname debug_pipe
#' @export
#' @examples
#' iris %>%
#'   debug_pipe %>%
#'   head
debug_pipe <- function(x)
{
  browser()
  x
}
