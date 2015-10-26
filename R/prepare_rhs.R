# Prepare RHS According to Pipe
prepare_rhs <- function(pipe, rhs)
{
  if (is_tee(pipe)) {
    rhs
  } else if (is_dollar(pipe)) {
    substitute(. <- with(., b), list(b = rhs))
  } else {
    call("<-", quote(.), rhs) 
  }
}