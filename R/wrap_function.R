# Wrap an expression in a function
# 
# This function takes the "body" part of a function and wraps it in
# a function. The return value depends on whether the function is created
# for its side effect with the tee operator.
#
# @param body an expression which will serve as function body in single-argument
#    function with an argument names \code{.} (a dot)
# @param pipe a quoted magrittr pipe, which determines how the function is made.
#
# @details Currently, the only distinction made is whether the pipe is a tee
#   or not.
#
# @return a function of a single argument, named \code{.}.
wrap_function <- function(body, pipe)
{
	if (is_tee(pipe))
		eval(call("function", as.pairlist(alist(.=)), call("{", body, quote(.))))
	else
		eval(call("function", as.pairlist(alist(.=)), body))
}