#' Pipe an object forward into a function call.
#'
#' The \code{\%>\%} operator pipes the left-hand side into an expression on the 
#' right-hand side. The \code{\%<\%} operator does the reverse. The expression
#' can contain a \code{.} as placeholder to indicate the position taken
#' by the object in the pipeline. If not present, it will be squeezed in as the
#' first argument. If the right-hand side expression is a function call that 
#' takes only one argument, one can omit both parentheses
#' and the \code{.}. The \code{\%>>\%} and \code{\%<<\%} versions replaces the
#' \code{.} with \code{..} to allow for expressions with that includes 
#' a \code{.}, e.g. a formula.
#'
#' @param e1 the object to be piped forward
#' @param e2 an expression which expects an object from the pipe.
#' @rdname pipe
#' @export
#' @examples
#' \dontrun{
#' iris %>%
#'   where(Petal.Length > 5) %>%
#'   delete(Species) %>%
#'   colMeans
#'   
#' iris %>>%
#'   aggregate(. ~ Species, .., mean)
#'
#' rnorm(1000) %>% abs %>% sum
#' }
`%>%` <- 
  function(e1, e2)
  {
    cl <- match.call()
    if (length(cl[[3]]) == 1) {
      # Function reference without parentheses.
      e2(e1)
    } else {
      # Alter the right-hand side before evaluation.
      e  <- do.call(substitute, list(cl[[3]], list(. = cl[[2]])))
      if (e == cl[[3]]) { 
        # No dot was found - so squeeze in as first argument.
        j <- length(e)
        while (j > 1) {
          e[[j + 1]] <- e[[j]]
          if (!is.null(names(e)))
            # Make names (if present) follow values.
            names(e)[[j + 1]] <- names(e)[[j]]
          j <- j - 1
        }
        # place a dot, and try again.
        e[[2]] <- as.name(".")
        if (!is.null(names(e)))
          names(e)[[2]] <- ""
        e <- do.call(substitute, list(e, list(. = cl[[2]])))
      }
      # Evaluate the call.
      eval(e, parent.frame(), parent.frame())
    }
  }

#' @rdname pipe
#' @export
`%<%` <-
  function(e1, e2)
  {
    cl <- match.call()
    cl[[1]] <- `%>%`
    tmp <- cl[[2]]
    cl[[2]] <- cl[[3]]
    cl[[3]] <- tmp
    eval(cl, parent.frame(), parent.frame())
  }

#' @rdname pipe
#' @export
`%<<%` <-
  function(e1, e2)
  {
    cl <- match.call()
    cl[[1]] <- `%>>%`
    tmp <- cl[[2]]
    cl[[2]] <- cl[[3]]
    cl[[3]] <- tmp
    eval(cl, parent.frame(), parent.frame())
  }

#' @rdname pipe
#' @export
`%>>%` <-
  deparse(`%>%`) %>% 
  gsub("([^[:alpha:]])\\.", "\\1..", .) %>% 
  parse(text = .) %>%
  eval
  

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
    lst <-
      list(...) %>% substitute(.)[-1] %>% as.list
    
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
    lst  <- list(...) %>% substitute(.)[-1] %>% as.list
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
#'  airquality %>% 
#'    ofclass(numeric) %>% 
#'    head
#'    
#'  airquality %>%
#'    ofclass(integer) %>%
#'    head
#' }
ofclass <- 
  function(data., ...)
  {
    idx <-
      data. %>% 
      sapply(class) %in%  
        (substitute(list(...))[-1] %>%
         as.list %>% 
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