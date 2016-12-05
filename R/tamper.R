
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
#' When in non-interactive mode, \code{tamper} calls
#' \code{\link{dump_pipes}}.
#'
#' @export
#' @family pipe debuggers

tamper <- function() {

  if (.isMethodsDispatchOn()) {
    ## turn off tracing
    tState <- tracingState(FALSE)
    on.exit(tracingState(tState))
  }

  if (! interactive()) {
    try({
      dump_pipes()
      cat(gettext("tamper called non-interactively; frames dumped, use debugger() to view\n"))
    })
    return(NULL)

  } else if (identical(getOption("show.error.messages"), FALSE)) {
    ## from try(silent=TRUE)?
    return(NULL)
  }

  dump <- get_pipe_calls(sys.calls(), sys.frames())

  if (is.na(dump$pipe_call)) {
    ## tracing is handled in recover(), so put it back
    tracingState(tState)
    return(recover())
  }

  ## We return here if there are no frames.
  if (dump$from <= 0L) {
    cat(gettext("No suitable frames for tamper()\n"))
    return()
  }

  pipe_menu(dump)

}

pipe_menu <- function(dump) {

  ## Interactive menu
  pipe_stack <- TRUE
  titles <- c("\nEnter a frame number, 1 to switch mode, or 0 to exit  ",
              "\nEnter a pipe stage number, 1 to switch mode, or 0 to exit  ")
  other_text <- c("Show pipe stages\n", "Show full stack frames\n")

  stacks <- list(dump$calls, dump$chr_stages)

  repeat {

    which <- menu(
      c(other_text[pipe_stack + 1], stacks[[pipe_stack + 1]]),
      title = titles[pipe_stack + 1])

    if (which == 1) {
      pipe_stack <- ! pipe_stack

    } else if (pipe_stack && which == 2) {
      eval(substitute(browser(skipCalls = skip),
                      list(skip = 7 - dump$pipe_call)),
           envir = sys.frame(dump$pipe_call))

    } else if (which > 1 && pipe_stack) {
      which <- which - 2
      eval(substitute(browser(skipCalls = skip),
                      list(skip = 7 - dump$freduce_calls[which])),
           envir = sys.frame(dump$freduce_calls[which]))

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
