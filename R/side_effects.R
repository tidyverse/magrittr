# closure to create side effect functions -------------------------------------------

foreach <- function(close_valve) {
  close_valve <- match.fun(close_valve)

  open_valve <- function(flow, value) {
    force(flow)

    if (!is.call(flow) || !identical(flow[[1]], quote(`%>%`))) {
      flow <- call("%>%", value, flow)
    } else {
      flow[[2]] <- open_valve(flow[[2]], value)
    }

    flow
  }

  function(data, ...) {
    env <- environment()
    args <- eval(substitute(alist(...)))
    args <- lapply(args, open_valve, value = quote(data))
    lapply(args, function(arg) close_valve(arg, env))
    data
  }
}

# utility functions for echo ------------------------------------------------------

underline <- function(x) {
  cat(x, "\n")
  cat(paste(rep("-", nchar(x)), collapse = ""), "\n")
}

print_flow <- function(flow, env) {
  underline(deparse(flow))
  print(eval(flow, env))
  cat("\n")
}

#' Side-effect functions
#'
#' These functions are designed to be used for \emph{specific} side effects.
#'
#' @name side_effects
NULL

#' @usage ... \%>\% echo(...) \%>\% ...
#'
#' @section \code{echo}:
#'
#' Use \code{echo} for interactive data analysis to print out your intermediate
#' (or final) results, or for printing out information to log files if your code
#' is being called in an automated process.
#'
#' @rdname side_effects
#' @export
#' @examples
#' library(dplyr)
#' new_iris <- iris %>%
#'   mutate(Log.Sepal.Length = log(Sepal.Length)) %>%
#'   echo(head, str, summary)
#'
#' # using `%>%` within `echo`
#' library(ggvis)
#' sepal <- iris %>%
#'    echo(
#'      ggvis(~Sepal.Length, ~Sepal.Width) %>%
#'        layer_points
#'    ) %>%
#'    select(Sepal.Length, Sepal.Width)
echo <- foreach(print_flow)
