# Prepare RHS According to Pipe
prepare_rhs <- function(pipe, rhs, last)
{
  if (is_tee(pipe)) {
    if (!last) {
      rhs 
    } else {
      call("{", rhs, quote(.))
    }
  } else if (is_dollar(pipe)) {
    if (!last) {
      substitute(. <- with(., b), list(b = rhs))
    } else {
      substitute(with(., b), list(b = rhs))
    }
  } else {
    if (!last) {
      call("<-", quote(.), rhs) 
    } else {
      rhs
    }
  }
}