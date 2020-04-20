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
    chain_parts <- split_chain(match.call(), env = env)

    pipes <- chain_parts[["pipes"]] # the pipe operators.
    rhss  <- chain_parts[["rhss" ]] # the right-hand sides.
    lhs   <- chain_parts[["lhs"  ]] # the left-hand side.

    # Create the list of functions defined by the right-hand sides.
    env[["_function_list"]] <- 
      lapply(seq_along(rhss), 
             function(i) wrap_function(rhss[[i]], pipes[[i]], parent))

    # Create a function which applies each of the above functions in turn.
    env[["_fseq"]] <-
     `class<-`(eval(quote(function(value) freduce(value, `_function_list`)), 
                    env, env), c("fseq", "function"))
 
    # make freduce available to the resulting function 
    # even if magrittr is not loaded.
    env[["freduce"]] <- freduce 
    
    # Result depends on the left-hand side.
    if (is_placeholder(lhs)) {
      # return the function itself.
      env[["_fseq"]]
    } else {
      # evaluate the LHS
      env[["_lhs"]] <- eval(lhs, parent, parent)
      
      # compute the result by applying the function to the LHS
      result <- withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
      
      # If assignment pipe is used, assign result
      if (is_compound_pipe(pipes[[1L]])) {
        eval(call("<-", lhs, result[["value"]]), parent, parent)
      # Otherwise, return it.
      } else {
        if (result[["visible"]]) 
          result[["value"]] 
        else 
          invisible(result[["value"]])
      }
    }
  }
}

#' Pipe
#' 
#' Pipe an object forward into a function or call expression.
#' 
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#' @details
#' \subsection{Using `%>%` with unary function calls}{
#' 
#' When functions require only one argument, `x %>% f` is equivalent
#' to `f(x)` (not exactly equivalent; see technical note below.)
#' 
#' }
#' \subsection{Placing `lhs` as the first argument in `rhs` call}{
#' 
#' The default behavior of `%>%` when multiple arguments are required
#' in the `rhs` call, is to place `lhs` as the first argument, i.e. 
#' `x %>% f(y)` is equivalent to `f(x, y)`.
#' }
#' \subsection{Placing `lhs` elsewhere in `rhs` call}{
#' 
#' Often you will want `lhs` to the `rhs` call at another position than the first.
#' For this purpose you can use the dot (`.`) as placeholder. For example,
#' `y %>% f(x, .)` is equivalent to `f(x, y)` and
#' `z %>% f(x, y, arg = .)` is equivalent to `f(x, y, arg = z)`.
#' }
#' 
#' \subsection{Using the dot for secondary purposes}{
#' 
#' Often, some attribute or property of `lhs` is desired in the `rhs` call in
#' addition to the value of `lhs` itself, e.g. the number of rows or columns.
#' It is perfectly valid to use the dot placeholder several times in the `rhs`
#' call, but by design the behavior is slightly different when using it inside
#' nested function calls. In particular, if the placeholder is only used 
#' in a nested function call, `lhs` will also be placed as the first argument!
#' The reason for this is that in most use-cases this produces the most readable 
#' code. For example, `iris %>% subset(1:nrow(.) %% 2 == 0)` is 
#' equivalent to `iris %>% subset(., 1:nrow(.) %% 2 == 0)` but
#' slightly more compact. It is possible to overrule this behavior by enclosing
#' the `rhs` in braces. For example, `1:10 %>% {c(min(.), max(.))}` is
#' equivalent to `c(min(1:10), max(1:10))`.
#' }
#' 
#' \subsection{Using `%>%` with call- or function-producing `rhs`}{
#' 
#' It is possible to force evaluation of `rhs` before the piping of `lhs` takes 
#' place. This is useful when `rhs` produces the relevant call or function.
#' To evaluate `rhs` first, enclose it in parentheses, i.e. 
#' `a %>% (function(x) x^2)`, and `1:10 %>% (call("sum"))`.
#' Another example where this is relevant is for reference class methods
#' which are accessed using the `$` operator, where one would do
#' `x %>% (rc$f)`, and not `x %>% rc$f`.
#' }
#' 
#' \subsection{Using lambda expressions with `%>%`}{
#' 
#' Each `rhs` is essentially a one-expression body of a unary function.
#' Therefore defining lambdas in magrittr is very natural, and as 
#' the definitions of regular functions: if more than a single expression
#' is needed one encloses the body in a pair of braces, \code{\{ rhs \}}.
#' However, note that within braces there are no "first-argument rule":
#' it will be exactly like writing a unary function where the argument name is
#' "`.`" (the dot).
#' 
#' }
#' \subsection{Using the dot-place holder as `lhs`}{
#' 
#' When the dot is used as `lhs`, the result will be a functional sequence, 
#' i.e. a function which applies the entire chain of right-hand sides in turn 
#' to its input. See the examples.
#' }
#' 
#' @section Technical notes:
#' The magrittr pipe operators use non-standard evaluation. They capture
#' their inputs and examines them to figure out how to proceed. First a function
#' is produced from all of the individual right-hand side expressions, and 
#' then the result is obtained by applying this function to the left-hand side.
#' For most purposes, one can disregard the subtle aspects of magrittr's 
#' evaluation, but some functions may capture their calling environment, 
#' and thus using the operators will not be exactly equivalent to the 
#' "standard call" without pipe-operators.
#' 
#' 
#' Another note is that special attention is advised when using non-magrittr
#' operators in a pipe-chain (`+, -, $,` etc.), as operator precedence will impact how the 
#' chain is evaluated. In general it is advised to use the aliases provided 
#' by magrittr.
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

#' Assignment pipe
#' 
#' Pipe an object forward into a function or call expression and update the 
#' `lhs` object with the resulting value.
#' 
#' @param lhs An object which serves both as the initial value and as target.
#' @param rhs a function call using the magrittr semantics.
#' 
#' @details The assignment pipe, \code{\%<>\%}, is used to
#' update a value by first piping it into one or more `rhs` expressions, and 
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

#' Tee pipe
#' 
#' Pipe a value forward into a function- or call expression and return the
#' original value instead of the result. This is useful when an expression
#' is used for its side-effect, say plotting or printing.
#' 
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#' 
#' @details The tee pipe works like \code{\link{\%>\%}}, except the 
#' return value is `lhs` itself, and not the result of `rhs` function/expression.
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

#' Exposition pipe
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

#' @seealso \code{\link{\%>\%}}, \code{\link{\%<>\%}}, \code{\link{\%T>\%}}
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
