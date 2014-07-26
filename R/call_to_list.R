# internal utility function to split a call into
# components separated by split, e.g. quote(`%>%`)
call_to_list <- function(cl, split)
{
  if (is.call(cl) && identical(cl[[1]], split)) {
    lapply(as.list(cl)[-1], call_to_list, split = split)
  } else {
    cl
  }
}
