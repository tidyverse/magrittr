#' Functional sequences ala magrittr
#'
#' Build a function using one or more expressions which could serve as
#' right-hand sides in a call to \code{\%>\%.}
#'
#' @param ... one or more expressions compatible with the rhs parameter in a
#'   call to \code{\%>\%}. If inputs in one expression are to be reused in a
#'   subsequent expression, use the form \code{x ~ expr} to name the input
#'   \code{x}.
#'
#' @return a function.
#'
#' @export
#' @examples
#' mae <- fseq(residuals, abs, mean)
fseq <- function(...)
{
  # Capture the inputs
  dots <- eval(substitute(alist(...)))

  # Reference the calling environment.
  parent <- parent.frame()

  # standardize the expressions to be on the form arg ~ expr
  specifications <- lapply(dots, function(dot) {
    if (is.symbol(dot) || (is.call(dot) && !identical(dot[[1]], quote(`~`)))) {
      dot <- call("~", quote(.), dot)
    }
    dot
  })

  # These are the body parts of the individual sub functions.
  func_parts <- lapply(specifications,
                       function(spec)
                         Reduce(function(a, b) call("%>%", a, b),
                                c(spec[[2]], unlist(call_to_list(spec[[3]], quote(`%>%`))))))

  # argument names
  func_args <- sapply(specifications,
                      function(spec)
                        as.character(spec[[2]]))

  # Utility function to embed function parts in each other.
  # Used in the Reduce statement below.
  embed_funcs <- function(a, b)
  {
    inner_arg <- as.pairlist(setNames(list(quote(expr = )), b[[1]]))
    inner <- call("(", call("function", inner_arg, b[[2]]))

    outer_body <- call("%>%", a[[2]], inner)
    outer_arg  <- as.pairlist(setNames(list(quote(expr = )), a[[1]]))

    list(name = a[[1]], call = outer_body)
  }

  # From right to left, construct the functions, enclose them in parens,
  # and embed them in the previous expression.
  func <-
    Reduce(embed_funcs,
           mapply(list, func_args, func_parts, SIMPLIFY = FALSE),
           right = TRUE)

  arg  <- setNames(list(quote(expr = )), as.character(func[[1]]))
  func_wrap <- call("function", as.pairlist(arg), func[[2]])

  fs <- eval(func_wrap, parent, parent)
  attr(fs, "parts") <- dots
  class(fs) <- c("fseq", "function")
  fs
}

#' Functional sequence operator.
#'
#' @param lhs expression as in \code{fseq}
#' @param rhs expression as in \code{fseq}
#'
#' @return a function.
#' @rdname fseq
#' @export
`%,%` <- function(lhs, rhs)
{
  # Capture inputs
  lhs <- substitute(lhs)
  rhs <- substitute(rhs)

  parent <- parent.frame()

  # Utitility function to remove parens from call, when used
  # to group expressions anc control precedence of operators.
  rm_parens <- function(expr)
    if (is.call(expr) && identical(expr[[1]], quote(`{`))) {
      expr[[-1]]
    } else {
      expr
    }

  # split the call into its parts.
  parts <- lapply(c(unlist(call_to_list(lhs, quote(`%,%`))), rhs), rm_parens)

  # Use fseq to construct the functional sequence.
  cl <-	do.call(fseq, parts)

  # Evaluate and return.
  eval(cl, parent, parent)
}

#' Print method for functional sequences.
#'
#' Generic method for printing of functional sequences generated with
#' either \code{\%,\%} or \code{fseq}.
#'
#' @param x a composite function
#' @param ... not used.
#'
#' @rdname compose
#' @export
print.fseq <- function(x, ...)
{
  cat("Functional sequence with parts:\n\n")
  lapply(attr(x, "parts"), function(p) cat(deparse(p), "\n"))
  if (!is.null(attr(x, "added_args")))
    cat("\nAdditional arguments:", attr(x, "added_args"), "\n")
  invisible(x)
}
