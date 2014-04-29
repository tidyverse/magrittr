#' Partialize a function call.
#'
#' Specify a partial function based on an existing function
#' with a subset of the available parameters. Evaluation is
#' lazy and the prespecified aruments are evaluated when
#' the function is used as if they were set together with
#' the remaining arguments.
#'
#' @param expr A partial function call.
#' @rdname partialize
#' @export
#' @examples
#' partial.lm <-
#'   partialize(lm(Sepal.Length ~ ., iris, na.action = na.fail)) %>%
#'   print
#'
#' partial.lm(Species != "versicolor")
#'
#' partial.plot <-
#'   partialize(plot(pch = 19, cex = 0.5, main = "Partialized Plot")) %>%
#'   print
#'
#' partial.plot(runif(25), rnorm(25))
partialize <- function(expr)
{
  # Capture the expression and validate that it is a call.
  e <- substitute(expr)
  if (!is.call(e))
    stop("expr must be a (partial function) call.", call. = FALSE)

  # Check that it is a valid function being partialized.
  f <- eval(e[[1]], parent.frame(), parent.frame())
  if (!is.function(f))
    stop("Malformed expression. A function call was expected.", call. = FALSE)

  primitive <- is.primitive(f)

  # Standardize the call with names arguments.
  cl <- if (!primitive) match.call(f, e) else e

  # Extract the supplied arguments and their names
  supplied_args  <- as.list(cl)[-1]
  supplied_names <- names(supplied_args)

  # Get the available arguments for the function being partialized.
  available_args  <-  if (!primitive) formals(f) else primitive_formals(f)
  available_names <-  names(available_args)

  # Unidentified argument names are only available if ellipsis are part of
  # the available arguments.
  if (!"..." %in% available_names && any(!supplied_names %in% available_names))
    stop("Unknown arguments supplied and ellipsis is not availble.",
         call. = FALSE)

  # Internal utility function to finalize the call when partial function is
  # called. Makes the resulting function easier to interpret when inspected.
  finalise_with <- function(new_call)
  {
    as.call(c(e[[1]], supplied_args, as.list(new_call)[-1]))
  }

  # Get a reference to the environment in which to evaluate the partial
  # function.
  parent <- parent.frame()

  # Create the partial function call
  partial_function <-
    call("function",
         as.pairlist(available_args[!available_names %in% supplied_names]),
         quote({
          cl <- finalise_with(match.call())
          eval(cl, parent, parent)
         }))

  # Evaluate it.
  partial_function <- eval(partial_function)

  # Set its class.
  class(partial_function) <- c("partial.function", "function")

  # And store the supplied args as a attribute, e.g. used by
  # print.partial.function. The attr part, is to attach
  # previously partialized arguments.
  attr(partial_function, "args") <- c(supplied_args, attr(f, "args"))

  # Return the result.
  partial_function
}

#' #' @usage NULL
#' @export
#' @rdname partialize
partialise <- partialize

#' @S3method print partial.function
print.partial.function <- function(x, ...)
{
  # Check for the appropriate class.
  if (!"partial.function" %in% class(x))
    stop("Object is not a partial function.")

  # Get the signature of the partialized function.
  sig <- capture.output(args(x))

  # Get rid of the trailing "NULL", and collapse
  # elements to a "multiline" string.
  sig <- paste(sig[-length(sig)], collapse = "\n")

  # Get the list of prespecified arguments and
  # their names.
  specified_args  <- attr(x, "args")
  specified_names <- names(specified_args)

  # Tag unnamed arguments
  if (is.null(specified_names))
    specified_names <- character(length(specified_args))
  specified_names[specified_names == ""] <- "(unnamed)"

  # Create strings with name-value pairs for the
  # prespecified arguments.
  name_value <- sapply(1:length(specified_args), function(i) {
    sprintf("%s = %s\n", specified_names[i], deparse(specified_args[[i]]))
  })

  # Combine and print
  cat(sep = "",
    "Partial function with signature\n\n  ", sig, "\n\n",
    "Predefined arguments:\n\n  ",
    paste(name_value, collapse = "  "), "\n")

  invisible(x)
}
