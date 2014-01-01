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
  

#' Select columns from data.frame, define new columns, or rename columns.
#'
#' @param from The data set to select from.
#' @param ... The columns to select, define, or rename.
#' @return a data.frame with the specified columns.
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

#' Delete columns from data.frame.
#'
#' @param from The dataset to delete from.
#' @param ... The columns to delete
#' @return a data.frame with the specified columns removed.
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

#' Order a data frame by expressions of the columns.
#'
#' @param unordered The data.frame to order.
#' @param ... expressions to order by (as in \code{\link{order}}).
#' @return an ordered data.frame.
#' @export
#' @examples
#' \dontrun{
#'  iris %>% 
#'    orderby(Species, Sepal.Length)
#' }
orderby <-
  function(unordered, ...) {
    idx <-
      substitute(order(...)) %>% 
      eval(unordered, parent.frame())
    unordered[idx, , drop = FALSE]
  }

#' Filter a data.frame based on conditions.
#' Equivalent to using the \code{data.frame[restriction ,]} syntax.
#'
#' @param unrestricted The data.frame to filter.
#' @param restriction The restriction to apply.
#' @return a data.frame with rows for which the restriction evaluates to TRUE.
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

