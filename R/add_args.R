#' Add arguments to a function.
#'
#' This can be used to add arguments to a function, either made with
#' \code{lambda}, \code{fseq}, or \code{\%,\%}.
#'
#' @param func the function to which arguments are added.
#' @param ... function arguments, possibly with default values.
#' @return a new function with added arguments.
#' @export
#' @examples
#'  # Build a mean-absolute error function which takes na.rm as argument
#'  # passed on to `mean`.
#'  mae <-
#'   residuals %,%
#'   abs %,%
#'   mean(na.rm = na.rm) %>%
#'   add_args(na.rm = TRUE)
#'
#' # Try it out.
#' iris %>%
#'    lm(Sepal.Length ~ ., .) %>%
#'    mae
add_args <- function(func, ...)
{
  # Ensure func is a function.
  if (!is.function(func))
    stop("func must be a function", call. = FALSE)

  # reference parent environment.
  parent <- parent.frame()

  # catch ... as unevaluated list.
  l <- eval(substitute(alist(...)))
  # and the names.
  nms <- names(l)

  # Create a list where unnamed elements are converted to named elements
  # with no value.
  pl <-
    sapply(1:length(l), function(i)
      if (nms[i] != "" && !is.null(nms[i])) l[i] else
        setNames(list(quote(expr = )), as.character(l[i])))

  # Create the call which will result in the function.
  cl <- call("function", as.pairlist(c(formals(func), pl)), body(func))

  # evalueate it, set attributes, and return.
  f <- eval(cl, parent, parent)
  attributes(f) <- attributes(func)
  attr(f, "added_args") <-
    paste(ifelse(names(l) != "",
                 paste(names(pl), pl, sep = " = "),
                 names(pl)), collapse = ", ")

  class(f) <- class(func)

  f
}
