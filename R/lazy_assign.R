let <- function(s, e)
{
  sym <- substitute(s)
  
  number <- as.integer(gsub("._", "", as.character(sym), fixed = TRUE)) 
  previous <- paste0("._", number - 1)
  
  removal <- substitute(on.exit(rm(previous, envir = env)), 
                        list(previous = previous, env = parent.frame()))
  
  expr <- `if`(number > 1, call("{", removal, substitute(e)), substitute(e)) 
  subs <- list(s = as.character(sym), e = expr)
  cl <- substitute(delayedAssign(s, e, environment(), environment()), subs)
  
  eval.parent(cl)
}

