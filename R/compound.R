#' Compound assignment operator for magrittr chains.
#'
#' The \code{`:=`} operator is short-hand notation for altering a value and binding
#' the existing name to the new value, e.g. rather than \code{a <- a \%>\% b}
#' one can use \code{a := b}.
#'
#' @param lhs a reference to a value
#' @param rhs a chain expression.
#' @usage lhs := rhs
#' @rdname compound
#' @export
#' @examples
#' \dontrun{
#' tmp <- iris
#'
#' tmp :=
#'  subset(Species == "setosa") %>%
#'  set_names(LETTERS[1:5])
#'
#' tmp$A := add(2)
#'
#' x <- 1:10
#'
#' x :=
#'  replace(1:5, 0) %>%
#'  divide_by(2)
#'
#' }
`:=` <- function(lhs, rhs)
{
  # Capture inputs
  lhs <- substitute(lhs)
  rhs <- substitute(rhs)

  # Utility function to split the call chain.
  call2list <- function(cl)
  {
    if (is.call(cl) && identical(cl[[1]], quote(`%>%`))) {
      lapply(as.list(cl)[-1], call2list)
    } else {
      cl
    }
  }

  # Construct the new right-hand side.
  RHS <-
    Reduce(function(a, b) call("%>%", a, b), c(lhs, unlist(call2list(rhs))))

  # Generate the assignment call.
  cl <- call("<-", lhs, RHS)

  # Evaluate it.
  eval(cl, parent.frame(), parent.frame())
}
