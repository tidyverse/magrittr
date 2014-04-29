#' An alternative to \code{formals}
#'
#' @param f A primitive function. This function will throw an error
#' if \code{f} is not primitive, or does not have a formal argument list.
#' Examples of the latter is \code{`while`} and \code{`<-`}.
#'
#' @return a pairlist with formal arguments.
#'
#' @rdname magrittr-internal
#'
#' @details This is not exported.
primitive_formals <- function(f)
{
  if (!is.primitive(f))
    stop("Expected a primitive function as argument.", call = FALSE)

  # Get the signature of the primitive function as text
  capture.output(args(f)) %>%
    # extract the argument-list inside the parentheses
    (function(s) regexec("\\((.+?)\\)", s) %>% regmatches(s, .))(.) %>%
    # unlist the result and extract the matched part
    unlist          %>%
    extract(2)      %>%
    # Split the arguments separated by commas
    strsplit(", ")  %>%
    # Unlist the result, and split the name-value pairs
    unlist          %>%
    strsplit(" = ") %>%
    # process each argument
    lapply(lambda(arg -> {
      if (length(arg) == 1) {
        # name without default
        setNames(list(quote(expr = )), arg)
      } else {
        # name with default
        value <- parse(text = arg[2])
        name  <- arg[1]
        name_value <- list(substitute(expr = value, list(value = value)))
        setNames(name_value, name)
      }
    })) %>%
    # unlist, convert to pairlist, and return.
    unlist %>%
    as.pairlist %>%
    (function(pl) {
      # Succeed only for primitives with a formal argument list.
      if (identical(pl, as.pairlist(setNames(list(quote(expr = )), "NA"))))
        stop("This primitive function has no formal arguments.", call = FALSE)
      pl
    })(.)
}
