
#' Investigate a pipe, after an error
#'
#' \code{tamper} is a function that can be used as an error callback,
#' similarly to \code{utils::recover}. Tamper is pipe-friendly: it will
#' show you the exact place of the error in the pipe.
#'
#' @section Example:
#'
#' After running the following code: \preformatted{options(error = tamper)
#'
#' f <- function(data) {
#'    data \%>\%
#'      (function(x) force(x)) \%>\%
#'      multiply_by(10) \%>\%
#'      add(10) \%>\%
#'      add("oh no!") \%>\%
#'      subtract(5) \%>\%
#'      divide_by(5)
#' }
#'
#'  1:10 \%>\%
#'    multiply_by(2) \%>\%
#'    f() \%>\%
#'    add(1:10)
#' }
#' you will see: \preformatted{Error in add(., "oh no!") : non-numeric argument to binary operator
#'
#' Enter a pipe stage number, 1 to switch mode, or 0 to exit
#'
#' 1: Show full stack frames
#'
#' 2:    data \%>\%
#' 3:      (function (x)
#'          force(x))(.) \%>\%
#' 4:      multiply_by(., 10) \%>\%
#' 5:      add(., 10) \%>\%
#' 6: ->   add(., "oh no!") \%>\%
#' 7:      subtract(., 5) \%>\%
#' 8:      divide_by(., 5)
#'
#' Selection:
#' }
#'
#' The problematic pipe stage is marked with an arrow. By pressing 1 (and
#' ENTER) you can switch to a regular stack trace. If you want to save
#' the temporary result from the pipe, choose the number at the arrow.
#' This is the last pipe stage that has started before the error. Then
#' you can save the value of the dot argument to the global environment:
#' \preformatted{assign("last_value", value, envir = .GlobalEnv) }
#'
#' @export

tamper <- function() {

  if (.isMethodsDispatchOn()) {
    ## turn off tracing
    tState <- tracingState(FALSE)
    on.exit(tracingState(tState))
  }

  calls <- sys.calls()
  from <- 0L
  no_calls <- length(calls)

  freduce_calls <- get_pipe_stages(calls)
  pipe_call <- get_last_pipe_call(calls)
  freduce_calls <- freduce_calls[ freduce_calls > pipe_call ]
  if (is.na(pipe_call)) {
    ## tracing is handled in recover(), so put it back
    tracingState(tState)
    return(recover())
  }

  ## find an interesting environment to start from
  ## options(error = tamper) produces a call to this function as an object
  calls <- calls[- length(calls)]
  no_calls <- no_calls - 1L

  ## look for a call inserted by trace() (and don't show frames below)
  ## this level.
  for (i in rev(seq_len(no_calls))) {
    calli <- calls[[i]]
    fname <- calli[[1L]]
    ## deparse can use more than one line
    if (!is.na(match(deparse(fname)[1L],
                     c("methods::.doTrace", ".doTrace")))) {
      from <- i - 1L
      break
    }
  }

  ## if no trace, look for the first frame from the bottom that is not
  ## stop, recover or tamper
  if (from == 0L) {
    for (i in rev(seq_len(no_calls))) {
      calli <- calls[[i]]
      fname <- calli[[1L]]
      if (!is.name(fname) ||
          is.na(match(as.character(fname),
                      c("tamper", "recover", "stop", "Stop")))) {
        from <- i
        break
      }
    }
  }

  ## We return here if there are no frames.
  if (from <= 0L) {
    cat(gettext("No suitable frames for tamper()\n"))
    return()
  }

  if (! interactive()) {
    try({
      dump.frames()
      cat(gettext("tamper called non-interactively; frames dumped, use debugger() to view\n"))
    })
    return(NULL)

  } else if (identical(getOption("show.error.messages"), FALSE)) {
    ## from try(silent=TRUE)?
    return(NULL)
  }

  ## ---------------------------------------------------------------
  ## This is the main stuff

  ## Get the pieces of the pipe, convert to character for printing
  chr_chain_parts <- chain_parts_to_chr(
    get("chain_parts", envir = sys.frame(pipe_call))
  )

  ## Get the bad pipe stage
  bad_stage <- get_bad_stage(freduce_calls)

  ## Nice printout of pipe stages
  chr_stages <- format_pipe_stages(chr_chain_parts, bad_stage)

  ## Interactive menu
  pipe_stack <- TRUE
  titles <- c("\nEnter a frame number, 1 to switch mode, or 0 to exit  ",
              "\nEnter a pipe stage number, 1 to switch mode, or 0 to exit  ")
  other_text <- c("Show pipe stages\n", "Show full stack frames\n")

  stacks <- list(calls, chr_stages)

  repeat {

    which <- menu(
      c(other_text[pipe_stack + 1], stacks[[pipe_stack + 1]]),
      title = titles[pipe_stack + 1])

    if (which == 1) {
      pipe_stack <- ! pipe_stack

    } else if (pipe_stack && which == 2) {
      eval(substitute(browser(skipCalls = skip),
                      list(skip = 7 - pipe_call)),
           envir = sys.frame(pipe_call))

    } else if (which > 1 && pipe_stack) {
      which <- which - 2
      eval(substitute(browser(skipCalls = skip),
                      list(skip = 7 - freduce_calls[which])),
           envir = sys.frame(freduce_calls[which]))

    } else if (which > 1 && ! pipe_stack) {
      which <- which - 1
      eval(substitute(browser(skipCalls = skip),
                      list(skip = 7-which)), envir = sys.frame(which))

    } else {
      break
    }
  }

  ## ---------------------------------------------------------------

}

is_freduce_call <- function(x) identical(x[[1L]], quote(freduce))

get_pipe_stages <- function(calls) {
  which(vapply(calls, is_freduce_call, logical(1)))
}

is_pipe_call <- function(x) is_pipe(x[[1L]])

get_last_pipe_call <- function(calls) {
  res <- tail(which(vapply(calls, is_pipe_call, logical(1))), 1)
  if (length(res)) res else NA_integer_
}

chain_parts_to_chr <- function(chain_parts) {
  no_pipes <- length(chain_parts$pipes)
  list(
    lhs = paste(deparse(chain_parts$lhs), collapse = "\n    "),
    pipes = vapply(chain_parts$pipes, as.character, ""),
    rhss = vapply(lapply(chain_parts$rhss, deparse),
      paste, "", collapse = "\n         ")
  )
}

get_bad_stage <- function(freduce_calls) {

  ## ---------------------------------------------------------------
  ## We might be more down from the actual error in the pipe chain,
  ## because of promises. For example if `value` is a promise all
  ## along the chain, then we are at the last stage.
  ##
  ## We have no_pipes stages in total, and we have
  ## length(freduce_calls) stages in the stack, these
  ## correspond to the first length(freduce_calls) stages.
  ##
  ##        |--------|--------|--------|--------|--------|
  ## pipes: |   1    |   2    |   3    |   4    |    5   |
  ## stack: |   1    |   2    |   3    |
  ##
  ## Now we find which stage the error corresponds to. We need
  ## to go up in the stack, until we find `value` evaluated.

  ## Checks which stacks are below the error in reality.
  ## If the `value` promise is not evaled, then we are below.
  is_below_error <- substitute(
    inherits(try(value, silent = TRUE), "try-error")
  )

  bad_stage <- length(freduce_calls)
  while (bad_stage > 0 &&
           eval(is_below_error,
                envir = sys.frame(freduce_calls[bad_stage]))) {
    bad_stage <- bad_stage - 1
  }

  bad_stage
}

format_pipe_stages <- function(chr_chain_parts, bad_stage) {
  no_pipes <- length(chr_chain_parts$rhss)
  markers <- rep("  ", no_pipes + 1)
  markers[bad_stage + 1] <- "->"

  paste(
    markers,
    c(chr_chain_parts$lhs, paste0("  ", chr_chain_parts$rhss)),
    c(chr_chain_parts$pipes, "")
  )
}
