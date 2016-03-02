# Compose Function From Pipes and RHSs
compose_pipeline <- function(pipes, rhss, env)
{
  idx        <- seq_len(length(rhss))

  body_parts <- mapply(prepare_rhs, pipes, rhss, idx, idx == length(idx), SIMPLIFY = FALSE)
  body       <- as.call(c(quote(`{`), body_parts))
  
  pipeline <- eval(call("function", as.pairlist(alist(.=)), body), env, env)
  environment(pipeline)[["let"]] <- let
  
  pipeline
}