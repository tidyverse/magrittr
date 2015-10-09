#' @export
as.function.fseq <- function(fseq) {
  bodies <- lapply(functions(fseq), body)
  assignments <- lapply(bodies, function(b) call("<-", quote(.), b))
  chain_body <- as.call(c(quote(`{`), assignments, quote(.)))
  nice_pipe <- as.function(c(alist(.=), chain_body))
  environment(nice_pipe) <- parent.env(environment(fseq))
  nice_pipe
}
