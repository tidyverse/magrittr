unroll_function_list <- function(function_list, env) {
  bodies <- lapply(function_list, body)
  assignments <- lapply(bodies[-length(bodies)], function(b) call("<-", quote(.), b))
  chain_body <- as.call(c(quote(`{`), assignments, bodies[length(bodies)]))
  nice_pipe <- as.function(c(alist(.=), chain_body))
  environment(nice_pipe) <- env
  nice_pipe
}

#' @export
as.function.fseq <- function(fseq) {
  unclass(fseq)
}
