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
#'   where(Petal.Length > 5) %>%
#'   delete(Species) %>%
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
  
  # Capture unevaluated argumetns
  lhs <- substitute(lhs)
  rhs <- substitute(rhs)
  
  if (!is.call(rhs) && !is.name(rhs)) {
    stop("RHS must be a function name or function call", call. = FALSE)
  }
    
  # Evaluate LHS and store result in new environment. Use unusual name
  # to avoid potential name clashes
  env <- new.env(parent = parent.frame())
  env$`__LHS` <- eval(lhs, env)
    
  # Is the rhs parentheses-less? 
  if (length(rhs) == 1) {
    
    # Construct a new expression with piped tobacco
    e <- call(as.character(rhs), quote(`__LHS`))
    
  } else {
    
    # Find arguments that are just a single .
    dots <- c(F, vapply(rhs[-1], identical, quote(.), FUN.VALUE = logical(1)))
    
    if (any(dots)) {
      # If found, replace with `__LHS`
      e <- rhs
      e[dots] <- rep(list(quote(`__LHS`)), sum(dots))
    } else {
      # Otherwise insert in first position
      e <- as.call(c(rhs[[1]], quote(`__LHS`), as.list(rhs[-1])))
    } 
  }
  
  # Smoke the pipe (evaluate the call)
  eval(e, env)
}

#' Select columns from \code{data.frame}, define new columns, or rename columns.
#'
#' @param from The \code{data.frame} to select from.
#' @param ... The columns to select, define, or rename.
#' @return a \code{data.frame} with the specified columns.
#' @export
#' @examples
#' \dontrun{
#'  iris %>% 
#'    select(
#'      width = Sepal.Width, 
#'      len   = Sepal.Length,
#'      ratio = Sepal.Width/Sepal.Length) %>% 
#'    head
#' }
select <- 
  function(from, ...)
  {
    lst <- as.list(substitute(list(...))[-1])
      
    nms  <- 
      if (lst %>% names %>% is.null)
        lst %>% as.character
    else 
      ifelse(names(lst) == "", 
             yes = lst %>% as.character,
             no  = lst %>% names)
    
    ev   <- 
      function(e) 
        eval(e, from, parent.frame())
    
    cols <- do.call(data.frame, lapply(lst, ev))
    colnames(cols) <- nms
    
    cols
  }

#' Add columns to \code{data.frame}.
#'
#' @param to The \code{data.frame} to add to.
#' @param ... The columns to add, can be expressions of existing columns.
#' @return a \code{data.frame} with original and new columns.
#' @export
#' @examples
#' \dontrun{
#'  iris %>% 
#'    add(
#'      width = Sepal.Width, 
#'      len   = Sepal.Length,
#'      ratio = Sepal.Width/Sepal.Length) %>% 
#'    head
#' }
add <-
  function(to, ...)
  {
    cl <- match.call()
    lst <- as.list(substitute(list(...))[-1])
    existing <- 
      to %>% colnames %>% sapply(as.name)
    lst <- c(existing, lst)
    do.call(select, c(lhs, lst), envir = parent.frame())
  }

#' Delete columns from \code{data.frame}.
#'
#' @param from The \code{data.frame} to delete from.
#' @param ... The columns to delete
#' @return a \code{data.frame} with the specified columns removed.
#' @export
#' @examples
#' \dontrun{
#'  iris %>% 
#'    delete(Species) %>% 
#'    colMeans
#' }
delete <-
  function(from, ...) {
    lst  <- as.list(substitute(list(...))[-1])
    nms  <- lst %>% as.character
    keep <- !colnames(from) %in% nms
    from[, keep]
  }

#' Order a \code{data.frame} by expressions of the columns.
#'
#' This function uses the \code{order} function, so any expression which 
#' works with \code{order} will work with \code{orderby}.
#'
#' @param unordered The data.frame to order.
#' @param ... expressions to order by (as in \code{\link{order}}).
#' @return an ordered data.frame.
#' @export
#' @examples
#' \dontrun{
#'  iris %>% 
#'    orderby(Species, Sepal.Length)
#'    
#'  mtcars %>%
#'    where(mpg > 18) %>%
#'    orderby(cyl, -hp)
#' }
orderby <-
  function(unordered, ...) {
    idx <-
      substitute(order(...)) %>% 
      eval(unordered, parent.frame())
    unordered[idx, , drop = FALSE]
  }

#' Filter a \code{data.frame} based on conditions (row-wise).
#' 
#' Equivalent to using the \code{data.frame[restriction ,]} syntax.
#'
#' @param unrestricted The \code{data.frame} to filter.
#' @param restriction The restriction to apply.
#' @return a \code{data.frame} with rows for which the restriction evaluates 
#'         to \code{TRUE}.
#' @export
#' @examples
#' \dontrun{
#'  iris %>% 
#'    where(Species == "virginica") %>% 
#'    delete(Species) %>%
#'    colMeans
#' }
where <-
  function(unrestricted, restriction) {
    idx <- 
      substitute(restriction) %>% 
      eval(unrestricted, parent.frame())
    if (! all(idx %>% is.logical))
      stop("The expression is not valid.", call.=FALSE)
    unrestricted[idx, ]
  }

#' Select columns of certain classes.
#' 
#' Given a \code{data.frame}, and a list of classes, a new \code{data.frame} is returned
#' with columns of these classes. Can be useful for example to extract numeric
#' columns before passed to a function expecting numeric input, e.g. colMeans.
#'
#' @param data. The \code{data.frame} to filter.
#' @param ... classes to look for (unquoted)
#' @return a \code{data.frame} with the selected classes
#' @export
#' @examples
#' \dontrun{
#'  iris %>%
#'    ofclass(numeric) %>%
#'    colMeans
#' 
#'  # Maybe not what you'd expect...
#'  airquality %>% 
#'    ofclass(numeric) %>% 
#'    head
#'    
#'  # ... then try this...
#'  airquality %>%
#'    ofclass(integer, numeric) %>%
#'    head
#' }
ofclass <- 
  function(data., ...)
  {
    idx <-
      data. %>% 
      sapply(class) %in% 
        (as.list(substitute(list(...))[-1]) %>%
         as.character)
    data.[, idx]
  }

#' Select certain rows by indices and/or amount.
#' 
#' Given a data.frame and indices (and possibly an amount of rows) a
#' data.frame with a subset of rows is returned.
#'
#' @param data. The \code{data.frame} to filter.
#' @param from the starting index. Can alternatively be a vector, in which case
#'        the other arguments are ignored. If NULL and \code{to} is specified, this
#'        will be taken to be 1.
#' @param to The end index. Should not be specified if \code{from} is a vector, or
#'        \code{take} != NULL. If \code{to} is NULL and \code{from} is a number, 
#'        then this will be taken to be \code{nrow(data.)}
#' @param take if one of from and to is specified this is the amount of rows to
#'        take.
#' @return a \code{data.frame} with the selected rows.
#' @export
#' @examples
#' \dontrun{
#'  iris %>%
#'    rows(140)
#'    
#'  iris %>%
#'    rows(to = 10)
#' 
#'  iris %>%
#'    rows(140, take = 3)
#'    
#'  iris %>%
#'    rows(to = 140, take = 3)
#'  
#'  iris %>%
#'    rows(seq(1, 10, 2))
#'    
#'  iris %>%
#'    rows(20:30)
#' }
rows <- 
  function(data., from = NULL, to = NULL, take = NULL)
  {
    if (length(from) > 1) {
      data.[from, ]
    } else if (!is.null(from) & is.null(to) & is.null(take)) {
      data.[from:nrow(data.), ]
    } else if (is.null(from) & !is.null(to) & !is.null(take)) {
      data.[(to - take + 1):to, ]
    } else if (is.null(from) & !is.null(to)) {
      data.[1:to, ]
    } else if (!is.null(to)) {
      data.[from:to, ]
    } else {
      data.[from:(from + take - 1), ]
    }
  }