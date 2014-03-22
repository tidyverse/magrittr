#' Pipe a result into an expression for its side-effect.
#'
#' Like \code{\%>\%} where the right-hand side is used for its
#' side-effect. The left-hand side is then passed along for
#' further processing. This can be useful, e.g. for logging
#' certain steps in a chain.
#'
#' @param lhs That which is to be piped
#' @param rhs a function call used for its side effect. 
#' @return lhs
#' @rdname tee
#' @export
#' @examples
#' 1:10 %T>% 
#'    lambda({ cat("LHS:", x, "\n")}) %>% 
#'    multiply_by(2)
`%T>%` <- 
  function(lhs, rhs)
  {
    cl      <- match.call()
    cl[[1]] <- quote(magrittr:::pipe)
    cl$tee  <- TRUE
    eval(cl, parent.frame(), parent.frame())
  }

#' Create a pipe operator with a fixed side-effect.
#'
#' This is useful e.g. for logging each step in a pipeline.
#'
#' @param fun a function which will be evaluated with left-hand side of
#'            a pipe expression as argument.
#' @return a pipe operator with the attached side effect.
#' @rdname teed_pipe
#' @export
#' @examples
#' # Define a logging function
#' logger <- function(x)
#'   cat(as.character(Sys.time()), ":", nrow(x), "\n")
#'
#' # mask %>% with a version using the logger.
#' `%>%` <- teed_pipe(logger)
#' 
#' # Test it:
#' iris %>% 
#'    subset(Species == "setosa") %>%  
#'    subset(Sepal.Length > 5) %>% 
#'    tail(10)
#'    
#' # Restore the original pipe:
#' rm(`%>%`)
teed_pipe <- 
  function(fun)
    if (!is.function(fun)) {
      stop("Argument `fun` must be a function.")
    } else {
      function(lhs, rhs)
      {
        cl      <- match.call()
        cl[[1]] <- quote(magrittr:::pipe)
        cl$tee  <- fun
        eval(cl, parent.frame(), parent.frame())
      }
    }
    