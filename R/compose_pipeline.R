# Compose Function From Pipes and RHSs
compose_pipeline <- function(pipes, rhss, env)
{
  body_parts <- mapply(prepare_rhs, pipes, rhss, SIMPLIFY = FALSE)
  body <- as.call(c(quote(`{`), body_parts, quote(.)))
  eval(call("function", as.pairlist(alist(.=)), body), env, env)
}