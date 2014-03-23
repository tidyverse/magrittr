#' Shorthand notation for anonymous/lambda functions 
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
#' @rdname lambda
#' @export
#' @examples
#' iris %>%
#'   lambda(rbind(x %>% head, x %>% tail))
#'   
#' iris %>%
#'   lambda(rbind(z %>% head, z %>% tail), z)
#'   
#' 1:10 %>% 
#'   sin %>% 
#'   lambda({ d <- abs(x) > 0.5; x*d })
lambda <- function(value, body, arg = "x")
{
  # Capture the input arguments
  body <- substitute(body)
  arg  <- as.character(substitute(arg))

  # Construct the argument pairlist
  pl   <- as.pairlist({ al <- list(); `[[<-`(al, arg, ) })
  
  # Create and evaluate funtion.
  eval(call("function", pl, body), parent.frame(), parent.frame())(value)
}

#' @rdname aliases
#' @usage NULL
#' @export
l <- lambda