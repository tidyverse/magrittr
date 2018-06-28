# Pipe Function
pipe <- function(lhs, rhs) {
  parent <- parent.frame()
  matched_call <- match.call()
  built <- build(matched_call, parent)

  if (identical(built[["lhs"]], quote(.))) {
    built[["pipeline"]]
  } else {
    . <- eval(built[["lhs"]], parent, parent)
    pipeline <- built[["pipeline"]]
    result   <- withVisible(pipeline(.))
    if (result[["visible"]]) {
      result[["value"]]
    } else {
      invisible(result[["value"]])
    }
  }
}

#' Forward-pipe Operator
#'
#' Pipe an object forward into a function or call expression.
#'
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#' @details
#' \bold{Using \code{\%>\%} with unary function calls}\cr
#' When functions require only one argument, \code{x \%>\% f} is equivalent
#' to `f(x)` (not exactly equivalent; see technical note below.)
#'
#' \bold{Placing `lhs` as the first argument in `rhs` call}\cr
#' The default behavior of \code{\%>\%} when multiple arguments are required
#' in the `rhs` call, is to place `lhs` as the first argument, i.e.
#' \code{x \%>\% f(y)} is equivalent to `f(x, y)`.
#'
#' \bold{Placing `lhs` elsewhere in `rhs` call}\cr
#' Often you will want `lhs` to the `rhs` call at another position than the first.
#' For this purpose you can use the dot (`.`) as placeholder. For example,
#' \code{y \%>\% f(x, .)} is equivalent to `f(x, y)` and
#' \code{z \%>\% f(x, y, arg = .)} is equivalent to `f(x, y, arg = z)`.
#'
#' \bold{Using the dot for secondary purposes}\cr
#' Often, some attribute or property of `lhs` is desired in the `rhs` call in
#' addition to the value of `lhs` itself, e.g. the number of rows or columns in
#' a tabular data object.
#' It is perfectly valid to use the dot placeholder several times in the `rhs`
#' call, but by design the behavior is slightly different when using it inside
#' nested function calls. In particular, if the placeholder is only used
#' in a nested function call, `lhs` will also be placed as the first argument!
#' The reason for this is that in most use-cases this produces the most readable
#' code. For example, \code{iris \%>\% subset(1:nrow(.) \%\% 2 == 0)} is
#' equivalent to \code{iris \%>\% subset(., 1:nrow(.) \%\% 2 == 0)} and
#' more compact. It is possible to overrule this behavior by enclosing
#' the `rhs` in braces. For example, \code{x \%>\% {c(min(.), max(.))}} is
#' equivalent to `c(min(x), max(x))`.
#'
#' \bold{Using \%>\% with call- or function-producing `rhs`}\cr
#' It is possible to force evaluation of `rhs` before the piping of `lhs` takes
#' place. This is useful when `rhs` produces the relevant call or function.
#' To evaluate `rhs` first, enclose it in parentheses, i.e.
#' \code{a \%>\% (function(x) x^2)}, and \code{1:10 \%>\% (call("sum"))}.
#'
#' \bold{Using lambda expressions with \code{\%>\%}}\cr
#' Each `rhs` is essentially a one-expression body of a unary function.
#' Therefore defining lambdas in magrittr is very natural, and as
#' the definitions of regular functions: if more than a single expression
#' is needed one encloses the body in a pair of braces, \code{\{ rhs \}}.
#' However, note that within braces there are no "first-argument rule":
#' it will be exactly like writing a unary function where the argument name is
#' "`.`" (the dot).
#'
#' \bold{Using the dot place-holder as `lhs`}\cr
#' When the dot is used as `lhs`, the result will be a functional sequence,
#' i.e. a function which applies the entire chain of right-hand sides in turn
#' to its input. See the examples.
#'
#' @section Technical notes:
#' The magrittr pipe operators use non-standard evaluation. They capture
#' their inputs and examines them to figure out how to proceed. First a function
#' is produced from all of the individual right-hand side expressions, and
#' then the result is obtained by applying this function to the left-hand side.
#' For most purposes, one can disregard the subtle aspects of magrittr's
#' evaluation, but some functions may capture their calling environment,
#' and thus using the operators will not be exactly equivalent to the
#' "standard call" without pipe-operators, and if right-hand side function
#' calls depend on a specific ancestor frame structure, then using pipes is
#' inapropriate.
#'
#' Another note is that special attention is advised when using non-magrittr
#' operators in a pipe-chain (`+, -, $,` etc.), as operator precedence will impact how the
#' chain is evaluated. In general it is advised to use the aliases provided
#' by magrittr.
#'
#' @seealso \code{\link{\%T>\%}}, \code{\link{\%$\%}}
#'
#' @examples
#' # Basic use:
#' iris %>% head
#'
#' # Use with lhs as first argument
#' iris %>% head(10)
#'
#' # Using the dot place-holder
#' "Ceci n'est pas une pipe" %>% gsub("une", "un", .)
#'
#' # When dot is nested, lhs is still placed first:
#' sample(1:10) %>% paste0(LETTERS[.])
#'
#' # This can be avoided:
#' rnorm(100) %>% {c(min(.), mean(.), max(.))} %>% floor
#'
#' # Lambda expressions:
#' iris %>%
#' {
#'   size <- sample(1:10, size = 1)
#'   rbind(head(., size), tail(., size))
#' }
#'
#' # renaming in lambdas:
#' iris %>%
#' {
#'   my_data <- .
#'   size <- sample(1:10, size = 1)
#'   rbind(head(my_data, size), tail(my_data, size))
#' }
#'
#' # Building unary functions with %>%
#' trig_fest <- . %>% tan %>% cos %>% sin
#'
#' 1:10 %>% trig_fest
#' trig_fest(1:10)
#'
#' @rdname pipe
#' @export
`%>%`  <- pipe

#' magrittr tee operator
#'
#' Pipe a value forward into a function- or call expression and return the
#' original value instead of the result. This is useful when an expression
#' is used for its side-effect, say plotting or printing.
#'
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#'
#' @details The tee operator works like \code{\link{\%>\%}}, except the
#' return value is `lhs` itself, and not the result of `rhs` function/expression.
#'
#' @seealso \code{\link{\%>\%}}, \code{\link{\%$\%}}
#'
#' @examples
#' rnorm(200) %>%
#' matrix(ncol = 2) %T>%
#' plot %>% # plot usually does not return anything.
#' colSums
#'
#' @rdname tee
#' @export
`%T>%` <- pipe

#' magrittr exposition pipe-operator
#'
#' Expose the names in `lhs` to the `rhs` expression. This is useful when functions
#' do not have a built-in data argument.
#'
#' @param lhs A list, environment, or a data.frame.
#' @param rhs An expression where the names in lhs is available.
#'
#' @details Some functions, e.g. `lm` and `aggregate`, have a
#' data argument, which allows the direct use of names inside the data as part
#' of the call. This operator exposes the contents of the left-hand side object
#' to the expression on the right to give a similar benefit, see the examples.

#' @seealso \code{\link{\%>\%}}, \code{\link{\%$\%}}
#'
#' @examples
#' iris %>%
#'   subset(Sepal.Length > mean(Sepal.Length)) %$%
#'   cor(Sepal.Length, Sepal.Width)
#'
#' data.frame(z = rnorm(100)) %$%
#'   ts.plot(z)
#'
#' @rdname exposition
#' @export
`%$%` <- pipe

#' Exposition Tee Pipe.
#'
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#'
#' @export
`%T$%` <- pipe
