#' Apply a list of functions sequentially
#'
#' This function applies the first function to \code{value}, then the
#' next function to the result of the previous function call, etc. 
#' 
#' @param value initial value.
#' @param function_list a list of functions.
#' @return The result after applying each function in turn.
#'
#'
#' @export
freduce <- function(value, function_list)
{
  k <- length(function_list)
  if (k == 1L) {
    result <- withVisible(function_list[[1L]](value))
    if (result[["visible"]])
      result[["value"]]
    else
      invisible(result[["value"]])
  } else {
    Recall(function_list[[1L]](value), function_list[-1L])
  }
}
