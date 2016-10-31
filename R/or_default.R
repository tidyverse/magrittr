# Tests if a value is missing and returns a default value instead
#
# @param  original_value an arbitrary value
# @param  fallback_value a fallback value that will be returned if the first parameter is NULL or NA (or a vector of NA).
# @return Any - The original value unless it is NA or NULL. Then the fallback value is returned.
or_default <- function(original_value, fallback_value) {
  if (is.null(original_value)) {
    return(fallback_value)
  }
  ifelse(is.na(original_value), fallback_value, original_value)
}


#' magrittr or_default operator
#' 
#' Tests if a value is NA or NULL and returns a default value instead.
#' 
#' @param original_value Any datatype.
#' @param fallback_value Any datatype.
#' 
#' @details The operator only returns the fallback_value when original_value is NULL, NA, or a vector of NAs. 
#' 
#' @examples
#' x <- NA
#' y <- x %||% 10
#'
#' @rdname ordefault
#' @export
`%||%` <- or_default