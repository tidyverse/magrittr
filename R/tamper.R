
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

  calls <- sys.calls()
  from <- 0L
  n <- length(calls)

  if (.isMethodsDispatchOn()) {
    ## turn off tracing
    tState <- tracingState(FALSE)
    on.exit(tracingState(tState))
  }

  ## If we are not in a pipe, then just pass to recover()
  ## We don't need to go backwards, but why not?
  freduce_calls <- integer()
  for (i in rev(seq_len(n))) {
    calli <- calls[[i]]
    if (! is.name(calli[[1L]])) next
    func <- as.character(calli[[1L]])
    if (func == "freduce") {
      freduce_calls <- c(freduce_calls, i)
    }
  }
  if (! length(freduce_calls)) {
    ## tracing is handled in recover(), so put it back
    tracingState(tState)
    return(recover())
  }

  ## find an interesting environment to start from
  ## options(error = tamper) produces a call to this function as an object
  calls <- calls[-n]
  n <- n - 1L

  ## look for a call inserted by trace() (and don't show frames below)
  ## this level.
  for (i in rev(seq_len(n))) {
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
    for (i in rev(seq_len(n))) {
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

  ## We return here is there are no frames. This can't really happen,
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
  chain_parts <- get("chain_parts", envir = sys.frame(1))
  no_pipes <- length(chain_parts$pipes)
  chr_chain_parts <- list(
    lhs = paste(deparse(chain_parts$lhs), collapse = "\n    "),
    pipes = vapply(chain_parts$pipes, as.character, ""),
    rhss = vapply(lapply(chain_parts$rhss, deparse),
      paste, "", collapse = "\n    ")
  )

  ## ---------------------------------------------------------------
  ## We might be more down from the actual error in the pipe chain,
  ## because of promises. For example if `value` is a promise all
  ## along the chain, then we are at the last stage.
  ##
  ## We have no_pipes stages in total, and we have
  ## length(freduce_calls) stages in the stack, these
  ## correspond to the first length(freduce) stages.
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
  bad_stack_freduce <- 1
  while (bad_stack_freduce <= length(freduce_calls) &&
           eval(is_below_error,
                envir = sys.frame(freduce_calls[bad_stack_freduce]))) {
    bad_stack_freduce <- bad_stack_freduce + 1
  }
  bad_stack <- freduce_calls[bad_stack_freduce]
  bad_stage <- length(freduce_calls) - bad_stack_freduce + 1

  ## Printout, with the bad stage marked
  markers <- rep(" ", no_pipes)
  markers[bad_stage] <- "*"
  with(
    chr_chain_parts,
    cat(sep = "",
        lhs, " ",
        pipes[[1]], "\n",
        paste(markers, rhss[-no_pipes], pipes[-1], "\n"),
        "  ", rhss[[no_pipes]], "\n"
        )
  )

  repeat {

    which <- menu(
      calls,
      title="\nEnter a frame number, or 0 to exit  ")
    if (which) {
      eval(substitute(browser(skipCalls = skip),
                      list(skip = 7-which)), envir = sys.frame(which))
    } else {
      break
    }
  }

  ## ---------------------------------------------------------------

}
