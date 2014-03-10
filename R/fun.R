#' Shorthand notation for anonymous functions 
#' in magrittr pipelines.
#'
#' It is suggested to use this for anonymous functions when composing chains
#' with magrittr. It is shorter and has a signature designed for the purpose
#' (i.e. it takes a value as the first argument to be fed into the function),
#' and it avoids the high precedence of the \code{function} keyword.
#'
#' @param value the value to be fed into the function
#' @param body the body of the anonymous function
#' @param arg the name used to reference \code{value} in the function. Defaults to x.
#' @rdname fun
#' @export
#' @examples
#' iris %>%
#'   fun({ rbind(x %>% head, x %>% tail) })
#'   
#' iris %>%
#'   fun({ rbind(z %>% head, z %>% tail) }, z)
#'   
#' 1:10 %>% 
#'   sin %>% 
#'   fun({d <- abs(x) > 0.5; x*d})
fun <- function(value, body, arg = NULL)
{
  # Capture the input arguments
  body <- substitute(body)
  arg  <- substitute(arg)
  
  # If no arg is supplied, default to `x`
  if (is.null(arg))
    arg <- substitute(x)
  
  # Create a function inheriting from the parent frame
  fun <- eval(expression(function() {}), parent.frame(), parent.frame())
  formals(fun)[[as.character(arg)]] <- NA
  body(fun) <- body
  
  # Evaluate with arg = value  
  fun(value)
}