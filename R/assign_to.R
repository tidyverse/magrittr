#' Assign to a name after a chain of data manipulations
#'
#' Alias for the base function \code{\link{assign}}, which makes it easier to
#' assign the output of a chain of data manipulations.
#'
#' @param x a value to be assigned to \code{name}.
#' @param name an unquoted variable name.
#' @param where where to do the assignment. Default is the environment in which
#'   the chain of manipulations is called. Passed to \code{pos} argument of
#'   \code{\link{assign}}.
#'
#' @return The function is invoked for its side effect, which is to assign
#'   \code{x} to the variable \code{name}. \code{x} is then returned.
#'
#' @examples
#' mtcars %>%
#'   subset(select = c("cyl","drat", "wt", "qsec")) %>%
#'   by(.$cyl, colMeans) %>%
#'   assign_to(car_cyls)
#'
#' print(car_cyls)
#'
#' # It is also possible to assign in the middle of a chain.
#' mtcars %>%
#'   subset(select = c("cyl","drat", "wt", "qsec")) %>%
#'   by(.$cyl, colMeans) %>%
#'   assign_to(car_cyls) %>%
#'   lapply(function(x) as.data.frame(t(x))) %>%
#'   set_names(NULL) %>%
#'   do.call("rbind", .) %>%
#'   assign_to(carl_cyls_df)
#'   ls()
#'
#' print(car_cyls)
#' print(carl_cyls_df)
#'
#' @export

assign_to <- function(x, name, where = NULL) {
  name_string <- deparse(substitute(name))
  if (is.null(where)) {
    sys_calls <- sys.calls()
    assign_calls <- grepl("\\<assign\\_to\\(", sys_calls) & !grepl("\\<assign\\_to\\(\\.",sys_calls)
    where <- sys.frame(max(which(assign_calls)) - 1)
  }
  assign(name_string, value = x, pos = where)
}

  