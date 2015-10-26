# Compose Function From Pipes and RHSs
compose_pipeline <- function(pipes, rhss, env)
{
  last <- seq_along(rhss) == length(rhss)
  body_parts <- mapply(prepare_rhs, pipes, rhss, last, SIMPLIFY = FALSE)
  body <- as.call(c(quote(`{`), body_parts))
  eval(call("function", as.pairlist(alist(.=)), body), env, env)
}