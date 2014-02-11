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
`%>%` <- 
  function(lhs, rhs) 
  {
    
    # Capture unevaluated arguments
    lhs <- substitute(lhs)
    rhs <- substitute(rhs)
    
    # LHS will be evaluated and stored in a new environment. 
    env <- new.env(parent = parent.frame())
    
    # Deal with special case of anonymous functions and e.g. primitives:
    if (is.function(rhs))
      return(rhs(eval(lhs, env)))
    if (!  exists(paste(deparse(rhs), collapse = ""))
        && deparse(rhs[[1]]) == "function")
      return(eval(rhs, parent.frame(), parent.frame())
            (eval(lhs, parent.frame(), parent.frame())))
      
    if (!is.call(rhs) && !is.name(rhs)) {
      stop("RHS must be a function name or function call", call. = FALSE)
    }
        
    # Find an appropriate name to use for evaluation:
    #   deparse(lhs) is useful for preserving the call
    #   but is not always feasible, in which case __LHS is used.
    #   It is also necessary to restrict the size of the name 
    #   for a few special cases.
    nm.tmp <- paste(deparse(lhs), collapse = "") 
    nm  <- 
      if (object.size(nm.tmp) < 1e4 && (is.call(lhs) || is.name(lhs)))
        nm.tmp
      else 
        '__LHS'
    
    # carry out assignment.
    env[[nm]] <- eval(lhs, env)
    
    # Construct the final expression to evaluate from lhs and rhs. Scenarios:
    #  1) rhs is a function name and parens are omitted.
    #  2a) rhs has one or more dots that qualify as placeholder for lhs.
    #  2b) lhs is placed as first argument in rhs call.
    if (length(rhs) == 1) {
      # Is the rhs parentheses-less?
      # Construct a new expression with piped tobacco
      e <- call(as.character(rhs), as.name(nm))
    } else {
      # Find arguments that are just a single .
      dots <- c(F, vapply(rhs[-1], identical, quote(.), FUN.VALUE = FALSE))
      if (any(dots)) {
        # If found, replace with lhs
        rhs[dots] <- rep(list(as.name(nm)), sum(dots))
        e <- rhs
      } else {
        # Otherwise insert in first position
        e <- as.call(c(rhs[[1]], as.name(nm), as.list(rhs[-1])))
      } 
    }
    
    # Smoke the pipe (evaluate the call)
    eval(e, env)
  }

#' Aliases
#' 
#' magrittr provides a series of aliases which can be more pleasant to use
#' when composing chains using the \code{\%>\%} operator.
#' 
#' Currently implemented aliases are
#' \tabular{ll}{
#' \code{extract}            \tab \code{`[`}      \cr
#' \code{extract2}           \tab \code{`[[`}     \cr
#' \code{use_series}         \tab \code{`$`}      \cr
#' \code{add}                \tab \code{`+`}      \cr
#' \code{subtract}           \tab \code{`-`}      \cr
#' \code{myltiply_by}        \tab \code{`*`}      \cr
#' \code{raise_to_power}     \tab \code{`^`}      \cr
#' \code{multiply_by_matrix} \tab \code{`\%*\%`}  \cr
#' \code{divide_by}          \tab \code{`/`}      \cr
#' \code{divide_by_int}       \tab \code{`\%/\%`}  \cr
#' \code{mod}                \tab \code{`\%\%`}   \cr
#' \code{and}                \tab \code{`&`}      \cr
#' \code{or}                 \tab \code{`|`}      \cr
#' \code{`\%.\%`}             \tab \code{`\%>\%`}  \cr
#' }
#' 
#' @usage NULL
#' @export
#' @rdname aliases
#' @name extract
#' @examples
#'  iris %>% 
#'    extract(, 1:4) %>%
#'    head
#'  
#' good.times <- 
#'   Sys.Date() %>% 
#'   as.POSIXct %>%
#'   seq(by = "15 mins", length.out = 100) %>%
#'   data.frame(timestamp = .)
#'
#' good.times$quarter <- 
#'   good.times %>%
#'   use_series(timestamp) %>%
#'   format("%M") %>%
#'   as.numeric %>%
#'   divide_by_int(15) %>%
#'   add(1)
extract <- `[`

#' @rdname aliases
#' @usage NULL
#' @export
extract2 <- `[[` 

#' @rdname aliases
#' @usage NULL
#' @export
use_series <- `$` 

#' @rdname aliases
#' @usage NULL
#' @export
add <- `+`
  
#' @rdname aliases
#' @usage NULL
#' @export
subtract <- `-`

#' @rdname aliases
#' @usage NULL
#' @export
multiply_by <- `*`

#' @rdname aliases
#' @usage NULL
#' @export
multiply_by_matrix <- `%*%`


#' @rdname aliases
#' @usage NULL
#' @export
divide_by <- `/`

#' @rdname aliases
#' @usage NULL
#' @export
divide_by_int <- `%/%`

#' @rdname aliases
#' @usage NULL
#' @export
raise_to_power <- `^`

#' @rdname aliases
#' @usage NULL
#' @export
and <- `&`

#' @rdname aliases
#' @usage NULL
#' @export
or <- `|`

#' @rdname aliases
#' @usage NULL
#' @export
mod <- `%%`

#' @rdname pipe
#' @usage NULL
#' @export
`%.%` <- `%>%`