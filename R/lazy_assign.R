let <- function(s, e)
{
  subs <- list(s = as.character(substitute(s)), e = substitute(e))
  eval.parent(substitute(delayedAssign(s, e, environment(), environment()),
                         subs))
}