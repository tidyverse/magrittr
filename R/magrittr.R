#' Function to create a pipe operator.
#'
#' @param tee Either a logical or a function. 
#'
#' @return When tee is FALSE a standard pipe is returned. When tee is TRUE
#'   a tee is returned, i.e. the rhs is used for the side-effect and the 
#'   the tee passes on the left-hand side. When tee is a function, the return
#'   value is a pipe where the function is attached as a side-effect, i.e. it
#'   works like a pipe, but also evaluates the function with the left-hand side
#'   as argument.
#'    
#' @details This is not exported.
pipe <- function(tee = FALSE) 
  function(lhs, rhs)
  {
    # Capture unevaluated arguments
    lhs <- substitute(lhs)
    rhs <- substitute(rhs)
    
    # Check right-hand side
    if (!any(is.symbol(rhs), is.call(rhs), is.function(rhs)))
      stop("RHS should be a symbol, a call, or a function.")

    # Make an environment in which lhs is to be evaluated.
    env <- new.env(parent = parent.frame())
    
    # Find an appropriate name to use for evaluation:
    #   deparse(lhs) is useful for preserving the call
    #   but is not always feasible, in which case __LHS is used.
    #   It is also necessary to restrict the size of the name
    #   for a few special cases.
    nm <- paste(deparse(lhs), collapse = "")
    nm <-
      if (nchar(nm) < 9900 && 
         (is.call(lhs) || is.name(lhs))) nm else "__LHS"
   
    # carry out assignment.
    env[[nm]] <- eval(lhs, env)
    
    # Evaluate potential tee if one such is attached.
    if (is.function(tee)) {
      # Evaluate the tee in env to preserve call (which e.g. is
      # used in `plot`)
      env$tee <- tee
      eval(substitute(tee(nm), list(nm = as.name(nm))), env)
    }
    
    if (is.function(rhs)) {
      
      # Case of a function: rare but possible
      res <- withVisible(rhs(env[[nm]]))
      
    } else if (is.call(rhs) && deparse(rhs[[1]]) == "function") {
      
      # Anonymous function:
      res <- withVisible(eval(rhs, parent.frame(), parent.frame())
                        (eval(lhs, parent.frame(), parent.frame())))
    
    } else {
      
      # Construct the final expression to evaluate from lhs and rhs. Scenarios:
      #  1)  rhs is a function name and parens are omitted.
      #  2a) rhs has one or more dots that qualify as placeholder for lhs.
      #  2b) lhs is placed as first argument in rhs call.
      if (is.symbol(rhs)) {
  
        if (!exists(deparse(rhs), parent.frame(), mode = "function"))
          stop("RHS appears to be a function name, but it cannot be found.")
        e <- call(as.character(rhs), as.name(nm)) # (1)
  
      } else {
  
        # Find arguments that are just a single .
        dots <- c(FALSE, vapply(rhs[-1], identical, quote(.), FUN.VALUE = logical(1)))
        if (any(dots)) {
          # Replace with lhs
          rhs[dots] <- rep(list(as.name(nm)), sum(dots))
          e <- rhs
        } else {
          # Otherwise insert in first position
          e <- as.call(c(rhs[[1]], as.name(nm), as.list(rhs[-1])))
        }
  
      }
  
      # Smoke the pipe (evaluate the call)
      res <- withVisible(eval(e, env))
      }
    
    # Return either result or lhs if tee == TRUE
    if (is.logical(tee) && tee) {
      env[[nm]] 
    } else {
      if (res$visible) res$value else invisible(res$value)
    }
  }

#' Pipe an object forward into a function call/expression.
#'
#' The \code{\%>\%} operator pipes the left-hand side into an expression on the
#' right-hand side. The expression can contain a \code{.} as placeholder to
#' indicate the position taken by the object in the pipeline. If not present,
#' it will be squeezed in as the first argument. If the right-hand side
#' expression is a function call that takes only one argument, one can omit
#' parentheses and the \code{.}. Only the outmost call is matched against the
#' dot, which means that e.g. formulas can still use a dot which will not be
#' matched. Nested functions will not be matched either.
#' 
#' @param lhs That which is to be piped
#' @param rhs the pipe to be stuffed with tobacco.
#' @rdname pipe
#' @export
#' @examples
#' \dontrun{
#' library(dplyr)
#' library(Lahman)
#'
#' Batting %>%
#'   group_by(playerID) %>%
#'   summarise(total = sum(G)) %>%
#'   arrange(desc(total)) %>%
#'   head(5)
#'
#'
#' iris %>%
#'   filter(Petal.Length > 5) %>%
#'   select(-Species) %>%
#'   colMeans
#'
#' iris %>%
#'   aggregate(. ~ Species, ., mean)
#'
#' rnorm(1000) %>% abs %>% sum
#' }
`%>%` <- pipe()