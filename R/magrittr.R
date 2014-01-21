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
#' The syntax \code{`\%.\%`} is an alias.
#'
#' @param tobacco That which is to be piped
#' @param pipe the pipe to be stuffed with tobacco.
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
#'   where(Petal.Length > 5) %>%
#'   delete(Species) %>%
#'   colMeans
#'   
#' iris %>%
#'   aggregate(. ~ Species, ., mean)
#'
#' rnorm(1000) %>% abs %>% sum
#' }
`%>%` <- function(tobacco, pipe)
{
  # Capture the call.
  cl <- match.call()
  
  # Is the rhs parentheses-less? 
  if (length(cl[[3]]) == 1) {
    
    # Construct a new expression with piped tobacco
    e <- call(as.character(cl[[3]]), cl[[2]])
    
  } else {
    
    # Find positions in the call which are not themselves a call.
    # this restricts the .-matching to the "first level". This enables using
    # dots in e.g. formulas.
    potential.dots <- 
      Filter(function(j) !is.call(cl[[3]][[j]]), 2:length(cl[[3]]))
    
    # Substitute the dot by lhs if present at the indices found above.
    e <- cl[[3]]
    for (j in potential.dots)
      e[[j]] <- do.call(substitute, list(e[[j]], list(. = cl[[2]])))
    
    # Check whether any substitutions were made,
    # in which case tobacco is piped as the first argument.
    if (identical(e, cl[[3]]))
      e <- as.call(c(cl[[3]][[1]], cl[[2]], lapply(cl[[3]], function(x) x)[-1]))
    
  }
  
  # Smoke the pipe (evaluate the call)
  eval(e, parent.frame(), parent.frame())
}

#' Aliases
#' 
#' magrittr provides a series of aliases which can be more pleasant to use
#' when composing chains using the %>% operator.
#' 
#' Currently implemented aliases are
#' \tabular{ll}{
#' \code{extract:}    \tab \code{`[`}      \cr
#' \code{Extract:}    \tab \code{`[[`}     \cr
#' \code{series:}     \tab \code{`$`}      \cr
#' \code{plus:}       \tab \code{`+`}      \cr
#' \code{minus:}      \tab \code{`-`}      \cr
#' \code{times:}      \tab \code{`*`}      \cr
#' \code{multiply:}   \tab \code{`\%*\%`}  \cr
#' \code{divide:}     \tab \code{`/`}      \cr
#' \code{int.divide:} \tab \code{`\%/\%`}  \cr
#' \code{`\%.\%`}     \tab \code{`\%>\%`}  \cr
#' }
#' 
#' @usage NULL
#' @export
#' @rdname aliases
#' @name extract
#' @examples
#' \dontrun{
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
#'   series(timestamp) %>%
#'   format("%M") %>%
#'   as.numeric %>%
#'   int.divide(15) %>%
#'   plus(1)
#' }
extract <- `[`

#' @rdname aliases
#' @usage NULL
#' @export
Extract <- `[[` 

#' @rdname aliases
#' @usage NULL
#' @export
series <- `$` 

#' @rdname aliases
#' @usage NULL
#' @export
plus <- `+`
  
#' @rdname aliases
#' @usage NULL
#' @export
minus <- `-`

#' @rdname aliases
#' @usage NULL
#' @export
times <- `*`

#' @rdname aliases
#' @usage NULL
#' @export
multiply <- `*`


#' @rdname aliases
#' @usage NULL
#' @export
divide <- `/`

#' @rdname aliases
#' @usage NULL
#' @export
int.divide <- `%/%`


#' @rdname pipe
#' @usage NULL
#' @export
`%.%` <- `%>%`