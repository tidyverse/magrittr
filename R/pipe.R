#' Create a pipe operator.
#'
#' This function is used to create all the \code{magrittr} pipe operators.
#' A pipeline is compiled into a function as a whole, and this compilation
#' is triggered by only one of the pipes used. The pipes are  
#' distinguished by their symbol, and it is meaningless to use this function
#' to create other pipe operators than %>%, %T>%, %<>%, and %$%.
#' 
#' @return A pipe operator.
#' @noRd
pipe <- function()
{
  function(lhs, rhs)
  {
    # the parent environment
    parent <- parent.frame()
    
    # split the pipeline/chain into its parts.
    pipeline <- construct_pipeline(match.call(), parent)
    
    dot <- is_dot_placeholder(pipeline[["lhs"]])
    
    # If the left-most pipe operator is %<>% then the call is altered
    # and re-evaluated.
    if (pipeline[["compound"]]) {
      
      if (dot) 
        stop("Dot notation is invalid for compound assignment.", call. = FALSE)
      
      new_rhs <- 
        eval(call("substitute", match.call(), list("%<>%" = quote(`%>%`))))
      
      cl <- call("<-", pipeline[["lhs"]], new_rhs)
      
      eval(cl, parent, parent)
    
    } else if (dot) {
      
      pipeline[["fun"]]
      
    } else {
      
      # These two lines make error scenarios print more nicely.
      . <- eval(pipeline[["lhs"]], parent, parent)
      pipeline <- pipeline[["fun"]]
    
      # This temporary result variable is needed for backward compatibility
      # with some packages that rely on the result name.
      result <- withVisible(pipeline(.))
      
      if (result[["visible"]]) 
        result[["value"]] 
      else 
        invisible(result[["value"]])
    }
  }
}

#' Forward Pipe Operator
#' 
#' Pipe an object forward into a function or call expression.
#' 
#' @param lhs A value, or the \code{magrittr} "dot" placeholder.
#' @param rhs A function call or expression using the \code{magrittr} semantics.
#' 
#' @details 
#' \bold{Using \code{\%>\%} with unary function calls}\cr 
#'   When functions require only one argument, \code{x \%>\% f} is equivalent to
#'   \code{f(x)} (not exactly equivalent; see technical note below.) \cr
#'   \cr 
#' \bold{Placing \code{lhs} as the first argument in \code{rhs} call}\cr 
#'   The default behavior of \code{\%>\%} is to place \code{lhs} as the first 
#'   argument in the \code{rhs} call, i.e. \code{x \%>\% f(y)} is equivalent to
#'   \code{f(x, y)}. \cr
#'   \cr 
#' \bold{Placing \code{lhs} elsewhere in \code{rhs} call}\cr 
#'   Sometimes you will want to place \code{lhs} at another position than the 
#'   first. For this purpose you can use a dot (i.e. \code{`.`}) as placeholder.
#'   For example, \code{y \%>\% f(x, .)} is equivalent to \code{f(x, y)} and
#'   \code{z \%>\% f(x, y, arg = .)} is equivalent to \code{f(x, y, arg = z)}.
#'   \cr\cr 
#' \bold{Using the dot for secondary purposes}\cr 
#'   Often, some attribute or property of \code{lhs} is desired in the
#'   \code{rhs} call in addition to the primary purpose of \code{lhs} itself.
#'   Examples are the number of rows or columns, dimensions, or names. It is
#'   perfectly valid to use the dot placeholder several times in the \code{rhs}
#'   call, but by design the behavior is slightly different when using it inside
#'   nested function calls. In particular, if the placeholder is only used in a
#'   nested function call, \code{lhs} will also be placed as the first argument!
#'   The reason for this is that in most use-cases this produces the most
#'   readable code. For example, \code{iris \%>\% subset(1:nrow(.) \%\% 2 == 0)}
#'   is equivalent to \code{iris \%>\% subset(., 1:nrow(.) \%\% 2 == 0)} but
#'   slightly more compact. It is possible to overrule this behavior by
#'   enclosing the \code{rhs} in braces. For example, \code{values \%>\%
#'   {c(min(.), max(.))}} is equivalent to \code{c(min(values), max(values))}.
#'   \cr
#'   \cr 
#' \bold{Using \%>\% with call- or function-producing \code{rhs}}\cr 
#'   It is possible to force evaluation of \code{rhs} before the piping of
#'   \code{lhs} takes place. This is useful when \code{rhs} produces the
#'   relevant call or function. To evaluate \code{rhs} first, enclose it in
#'   parentheses, i.e. \code{a \%>\% (function(x) x^2)}, and \code{1:10 \%>\%
#'   (call("sum"))}.\cr
#'   \cr 
#' \bold{Using lambda expressions with \code{\%>\%}}\cr 
#'   Each \code{rhs} is essentially a one-expression body of a unary function.
#'   Therefore defining lambdas in \code{magrittr} is very natural, and as the
#'   definitions of regular functions: if more than a single expression is
#'   needed one encloses the body in a pair of braces, \code{\{ rhs \}}. 
#'   However, note that within braces there are no "first-argument rule": it 
#'   will be exactly like writing a unary function where the argument name is 
#'   \code{`.`} (the dot). \cr
#'   \cr 
#' \bold{Using the dot-place holder as \code{lhs}}\cr 
#'   When the dot is used as \code{lhs}, the result will be a
#'   unary function which applies the pipeline operations. This is therefore
#'   a short-hand notation for writing functions that can be written as a 
#'   series of \code{rhs} expressions.\cr
#'   \cr
#' \bold{Using pipes in packages}\cr
#'   The non-standard evaluation used by \code{magrittr} pipes enable the use of
#'   the dot as placeholder, even when no \code{`.`} exists. In addition,
#'   the \code{\%$\%} operator exposes names that are not visible in the
#'   calling environment. This is a problem for the \code{R CMD check} which
#'   will note that there is no visible binding. \code{magrittr} supports 
#'   wrapping an \code{rhs} call in a one-sided formula to be explicit about 
#'   the fact that the \code{rhs} is evaluated in a special way, and that this
#'   is intended. For example: \code{value \%>\% ~some_function(arg1, .)}.
#'   Usually operator precendence would suggest that the formula would capture all 
#'   subsequent \code{rhs} expressions, but as the pipeline is jointly 
#'   compiled, \code{magrittr} handles this internally in a rather simple way.
#'   
#' @section Technical notes: The \code{magrittr} pipe operators use non-standard 
#'   evaluation. They capture the (unevaluated) call and compiles the combined
#'   pipeline into a unary 
#'   function which is then applied. For most purposes, one can disregard 
#'   the subtle aspects of \code{magrittr}'s evaluation, but some functions may capture
#'   their calling environment, and using the operators will not be exactly
#'   equivalent to the "standard call" without pipe-operators. \cr
#'   \cr 
#' Another 
#'   note is that special attention is advised when using non-\code{magrittr} operators
#'   in a pipe-chain (\code{+, -, *,} etc.), as operator precedence will impact 
#'   how the chain is evaluated. There are a few exceptions to the usual operator
#'   precedence: \code{`::`}, \code{`:::`}, and \code{`$`} are treated as special 
#'   to allow calls like
#'   \code{value \%>\% pkg::fun} and \code{value \%>\% obj$fun}.\cr
#'   \cr
#' Finally, the pipeline is greedy by design and cannot be used with functions
#'   that require inputs to be unevaluated. This, for example, would not work: 
#'   \code{value \%>\% dangerous_call \%>\% tryCatch(error = function(e) ...)}.
#' 
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

#' Compound Assignment Pipe-Operator
#' 
#' Pipe an object forward into a function or call expression and update the 
#' \code{lhs} object with the resulting value.
#' 
#' @param lhs An object which serves both as the initial value and as target.
#' @param rhs a function call using the \code{magrittr} semantics.
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
#' day <- "2016-09-01"
#' 
#' day %<>% as.Date
#' 
#' @rdname compound
#' @export
`%<>%` <- pipe() 

#' Tee Pipe Operator
#' 
#' Pipe a value forward into a function- or call expression and return the
#' original value instead of the result. This is useful when an expression
#' is used for its side-effect, say plotting or printing.
#' 
#' @param lhs A value or the \code{magrittr} placeholder.
#' @param rhs A function call using the \code{magrittr} semantics.
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

#' Exposition Pipe Operator
#' 
#' Expose the names in \code{lhs} to the \code{rhs} expression. This is useful when functions
#' do not have a built-in data argument.
#' 
#' @param lhs Usually a list, environment, or a data.frame. Other object types
#'   can be used if the \code{with} method is implemented, see details.
#' @param rhs An expression where the names in lhs is available.
#' 
#' @details Some functions, e.g. \code{lm} and \code{aggregate}, have a 
#' data argument, which allows the direct use of names inside the data as part 
#' of the call. This operator exposes the contents of the left-hand side object
#' to the expression on the right to give a similar benefit, see the examples.\cr
#' \cr
#' Internally, \code{\%$\%} relies on the generic method \code{with}.
#' This allows the developer to customize the way \code{\%$\%} works for a 
#' particular class.
#' 
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
