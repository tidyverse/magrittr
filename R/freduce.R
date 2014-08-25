#' Apply a list of functions in a sequence
#'
#' @param value initial value.
#' @param fl a list of functions.
#' @return The result after applying each function in turn.
#'
#' @details this function does not return a vector of the same length as 
#' \code{fl}. It applies the first function to \code{value}, the the next
#' function to the result of the previous, etc.
#'
#' @export
freduce <- function(value, fl)
{
  k <- length(fl)
  if (k > 1)
    for (i in 1:(k - 1L)) value <- fl[[i]](value)
      value <- withVisible(fl[[k]](value))
  if (value[["visible"]]) value[["value"]] else invisible(value[["value"]])
}