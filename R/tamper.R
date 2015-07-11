
## Much of this is from utils::recover, so yes, R-core is in Authors. :)
##
## TODO: what if a piping function calls another piping function?
## Or more of them? Or these call more piping functions?
##
## TODO: see how this could work in RStudio, which already redefines
## options(error), a guess

tamper <- function() {

  if (! requireNamespace("pryr", quietly = TRUE)) {
    warning("pryr is not available, defaulting to `recover()`")
    return(recover())
  }

  if (.isMethodsDispatchOn()) {
    ## turn off tracing
    tState <- tracingState(FALSE)
    on.exit(tracingState(tState))
  }

  calls <- sys.calls()
  from <- 0L
  no_calls <- length(calls)

  freduce_calls <- get_pipe_calls(calls)
  if (! length(freduce_calls)) {
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

  ## We return here if there are no frames. This can't really happen,
  ## because we have at least a pipe stage
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
    get("chain_parts", envir = sys.frame(1))
  )

  ## Get the bad pipe stage
  bad_stage <- get_bad_stage(freduce_calls)

  ## Nice printout of pipe stages
  chr_stages <- format_pipe_stages(chr_chain_parts, bad_stage)

  ## Interactive menu
  pipe_stack <- TRUE
  titles <- c("\nEnter a frame number, 1 to switch mode, or 0 to exit  ",
              "\nEnter a pipe stage number, 1 to switch mode, or 0 to exit  ")
  other_text <- c("Show pipe stages\n\n",
                  paste("Show full stack frames\n\n", " ",
                        chr_chain_parts$lhs, chr_chain_parts$pipes[1])
                  )

  stacks <- list(calls, chr_stages)

  repeat {

    which <- menu(
      c(other_text[pipe_stack + 1], stacks[[pipe_stack + 1]]),
      title = titles[pipe_stack + 1])

    if (which == 1) {
      pipe_stack <- ! pipe_stack

    } else if (which > 1 && pipe_stack) {
      which <- which - 1
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

get_pipe_calls <- function(calls) {

  freduce_calls <- integer()
  for (i in seq_along(calls)) {
    calli <- calls[[i]]
    if (! is.name(calli[[1L]])) next
    func <- as.character(calli[[1L]])
    if (func == "freduce") {
      freduce_calls <- c(freduce_calls, i)
    }
  }
  freduce_calls
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

  ## Need to do this to allow debugging code that uses pryr itself
  ## and has is_promise or promise_info
  `_is_promise` <- pryr::is_promise
  `_promise_info` <- pryr::promise_info

  ## Checks which stacks are below the error in reality
  ## If the `value` promise is not evaled we are below
  is_below_error <- substitute(
    `_is_promise`(value) && ! `_promise_info`(value)$evaled
  )

  ## TODO: can an error happen before the first pipe stage? Probably.
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
  markers <- rep("  ", no_pipes - 1)
  markers[bad_stage] <- "->"

  paste(
    markers,
    chr_chain_parts$rhss,
    c(chr_chain_parts$pipes[-1], "")
  )
}
