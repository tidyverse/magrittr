# Create a pipe operator.
#
# This function is used to create all the magrittr pipe operators.
pipe <- function()
{
  function(lhs, rhs)
  {
    # the parent environment
    parent <- parent.frame()
    
    # the environment in which to evaluate pipeline
    env    <- new.env(parent = parent)
    
    # split the pipeline/chain into its parts.
    parts <- split_pipeline(match.call(), env = env)

    pipes <- parts[["pipes"]] # the pipe operators.
    rhss  <- parts[["rhss" ]] # the right-hand sides.
    lhs   <- parts[["lhs"  ]] # the left-hand side.

    # Create the list of functions defined by the right-hand sides.
    pipeline <- compose_pipeline(pipes, rhss, parent)
    
    # Result depends on the left-hand side.
    if (is_placeholder(lhs)) {
      pipeline
    } else {
      # evaluate the LHS
      . <- eval(lhs, parent, parent)
      
      # If compound assignment pipe operator is used, assign result
      if (is_compound_pipe(pipes[[1L]])) {
        eval(call("<-", lhs, pipeline(.)), parent, parent)
      # Otherwise, return it.
      } else {
        pipeline(.)
      }
    }
  }
}

#' magrittr forward-pipe operator
#' 
#' Pipe an object forward into a function or call expression.
#' 
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#' @details \bold{Using \code{\%>\%} with unary function calls}\cr When
#' functions require only one argument, \code{x \%>\% f} is equivalent to
#' \code{f(x)} (not exactly equivalent; see technical note below.) \cr\cr
#' \bold{Placing \code{lhs} as the first argument in \code{rhs} call}\cr The
#' default behavior of \code{\%>\%} when multiple arguments are required in the
#' \code{rhs} call, is to place \code{lhs} as the first argument, i.e. \code{x
#' \%>\% f(y)} is equivalent to \code{f(x, y)}. \cr\cr \bold{Placing \code{lhs}
#' elsewhere in \code{rhs} call}\cr Often you will want \code{lhs} to the
#' \code{rhs} call at another position than the first. For this purpose you can
#' use the dot (\code{.}) as placeholder. For example, \code{y \%>\% f(x, .)} is
#' equivalent to \code{f(x, y)} and \code{z \%>\% f(x, y, arg = .)} is
#' equivalent to \code{f(x, y, arg = z)}. \cr\cr \bold{Using the dot for
#' secondary purposes}\cr Often, some attribute or property of \code{lhs} is
#' desired in the \code{rhs} call in addition to the value of \code{lhs} itself,
#' e.g. the number of rows or columns. It is perfectly valid to use the dot
#' placeholder several times in the \code{rhs} call, but by design the behavior
#' is slightly different when using it inside nested function calls. In
#' particular, if the placeholder is only used in a nested function call,
#' \code{lhs} will also be placed as the first argument! The reason for this is
#' that in most use-cases this produces the most readable code. For example,
#' \code{iris \%>\% subset(1:nrow(.) \%\% 2 == 0)} is equivalent to \code{iris
#' \%>\% subset(., 1:nrow(.) \%\% 2 == 0)} but slightly more compact. It is
#' possible to overrule this behavior by enclosing the \code{rhs} in braces. For
#' example, \code{1:10 \%>\% {c(min(.), max(.))}} is equivalent to
#' \code{c(min(1:10), max(1:10))}. \cr\cr \bold{Using \%>\% with call- or
#' function-producing \code{rhs}}\cr It is possible to force evaluation of
#' \code{rhs} before the piping of \code{lhs} takes place. This is useful when
#' \code{rhs} produces the relevant call or function. To evaluate \code{rhs}
#' first, enclose it in parentheses, i.e. \code{a \%>\% (function(x) x^2)}, and
#' \code{1:10 \%>\% (call("sum"))}. Another example where this is relevant is
#' for reference class methods which are accessed using the \code{$} operator,
#' where one would do \code{x \%>\% (rc$f)}, and not \code{x \%>\% rc$f}. \cr\cr
#' \bold{Using lambda expressions with \code{\%>\%}}\cr Each \code{rhs} is
#' essentially a one-expression body of a unary function. Therefore defining
#' lambdas in magrittr is very natural, and as the definitions of regular
#' functions: if more than a single expression is needed one encloses the body
#' in a pair of braces, \code{\{ rhs \}}. However, note that within braces there
#' are no "first-argument rule": it will be exactly like writing a unary
#' function where the argument name is "\code{.}" (the dot). \cr\cr \bold{Using
#' the dot-place holder as \code{lhs}}\cr When the dot is used as \code{lhs},
#' the result will be a functional sequence, i.e. a function which applies the
#' entire chain of right-hand sides in turn to its input. See the examples.
#' 
#' @section Technical notes: The magrittr pipe operators use non-standard 
#'   evaluation. They capture their inputs and examines them to figure out how 
#'   to proceed. First a function is produced from all of the individual 
#'   right-hand side expressions, and then the result is obtained by applying 
#'   this function to the left-hand side. For most purposes, one can disregard 
#'   the subtle aspects of magrittr's evaluation, but some functions may capture
#'   their calling environment, and thus using the operators will not be exactly
#'   equivalent to the "standard call" without pipe-operators. \cr\cr Another 
#'   note is that special attention is advised when using non-magrittr operators
#'   in a pipe-chain (\code{+, -, $,} etc.), as operator precedence will impact 
#'   how the chain is evaluated. In general it is advised to use the aliases 
#'   provided by magrittr.
#'   
#' @seealso \code{\link{\%<>\%}}, \code{\link{\%T>\%}}, \code{\link{\%$\%}}
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
`%>%`  <- pipe()

#' magrittr compound assignment pipe-operator
#' 
#' Pipe an object forward into a function or call expression and update the 
#' \code{lhs} object with the resulting value.
#' 
#' @param lhs An object which serves both as the initial value and as target.
#' @param rhs a function call using the magrittr semantics.
#' 
#' @details The compound assignment pipe-operator, \code{\%<>\%}, is used to
#' update a value by first piping it into one or more \code{rhs} expressions, and 
#' then assigning the result. For example, \code{some_object \%<>\% 
#' foo \%>\% bar} is equivalent to \code{some_object <- some_object \%>\% foo
#' \%>\% bar}. It must be the first pipe-operator in a chain, but otherwise it
#' works like \code{\link{\%>\%}}.
#' 
#' @seealso \code{\link{\%>\%}}, \code{\link{\%T>\%}}, \code{\link{\%$\%}}
#' 
#' @examples
#' iris$Sepal.Length %<>% sqrt
#' 
#' x <- rnorm(100)
#' 
#' x %<>% abs %>% sort
#' 
#' is_weekend <- function(day)
#' {
#'    # day could be e.g. character a valid representation
#'    day %<>% as.Date
#'    
#'    result <- day %>% format("%u") %>% as.numeric %>% is_greater_than(5)
#'    
#'    if (result)
#'      message(day %>% paste("is a weekend!"))
#'    else
#'      message(day %>% paste("is not a weekend!"))
#'    
#'    invisible(result)
#' }
#' 
#' @rdname compound
#' @export
`%<>%` <- pipe() 

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
#' return value is \code{lhs} itself, and not the result of \code{rhs} function/expression.
#' 
#' @seealso \code{\link{\%>\%}}, \code{\link{\%<>\%}}, \code{\link{\%$\%}}
#' 
#' @examples
#' rnorm(200) %>%
#' matrix(ncol = 2) %T>%
#' plot %>% # plot usually does not return anything. 
#' colSums
#' 
#' @rdname tee
#' @export
`%T>%` <- pipe() 

#' magrittr exposition pipe-operator
#' 
#' Expose the names in \code{lhs} to the \code{rhs} expression. This is useful when functions
#' do not have a built-in data argument.
#' 
#' @param lhs A list, environment, or a data.frame.
#' @param rhs An expression where the names in lhs is available.
#' 
#' @details Some functions, e.g. \code{lm} and \code{aggregate}, have a 
#' data argument, which allows the direct use of names inside the data as part 
#' of the call. This operator exposes the contents of the left-hand side object
#' to the expression on the right to give a similar benefit, see the examples.

#' @seealso \code{\link{\%>\%}}, \code{\link{\%<>\%}}, \code{\link{\%$\%}}
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
`%$%` <- pipe() 
