# Expand a Right-hand side Expression to Assign to "the dot".
#
# @param rhs The right-hand side expression.
# @return The expanded expression.
dot_assign <- function(rhs, pipe)
{
  if (is_tee_pipe(pipe)) {
    rhs
  } else {
    call("<-", quote(.), rhs)
  }
}

# Expand a Right-hand side Expression for Exposition.
#
# @param rhs The right-hand side expression.
# @return The exposision call expression.
exposition_call <- function(rhs)
{
  base_with <- call("::", quote(base), quote(with))
  as.call(list(base_with, quote(.), rhs))
}

# Expand "bare" Function/Symbol to Function Call Expression.
#
# @param f The bare symbol.
# @return logical - TRUE if the expression is a formula, FALSE otherwise.
function_call <- function(f)
{
  as.call(list(f, quote(.)))
}

# Check Whether an Expression a Call Including a Special Operator.
#
# There are a few operators where we handle precedence: namespace
# prefix operators `::` and `:::`, as well as the `$` operator, to
# allow e.g. certain method types.
#
# @param expr The expression to check.
# @return logical - TRUE if the expression represents a call to one
#   of the operators, FALSE otherwise.
has_special_operator <- function(expr)
{
  is.call(expr) &&
 (identical(expr[[1L]], quote(`::`))  ||
  identical(expr[[1L]], quote(`:::`)) ||
  identical(expr[[1L]], quote(`$`)))
}

# Check Whether an Expression is Wrapped in a (One-sided) formula.
#
# @param expr The expression to check.
# @return logical - TRUE if the expression is a formula, FALSE otherwise.
is_formularized <- function(expr)
{
  is.call(expr) &&
  length(expr) == 2L &&
  identical(expr[[1L]], quote(`~`))
}

# Check whether a pipe an exposition pipe.
#
# @param pipe A (quoted) pipe
# @return logical - TRUE if pipe is an exposition pipe, FALSE otherwise.
is_exposition_pipe <- function(pipe)
{
  identical(pipe, quote(`%$%`)) || identical(pipe, quote(`%T$%`))
}

# Determine whether an expression should be considered a function.
#
# @param a non-evaluated expression
# @retun logical - TRUE if expression is a considered a function, FALSE otherwise.
is_function <- function(expr)
{
  is.symbol(expr) || is.function(expr)
}

# Determine whether an expression is a magrittr lambda expression.
#
# @param a non-evaluated expression
# @retun logical - TRUE if expression is a lambda expression, FALSE otherwise.
is_lambda_expression <- function(expr)
{
  is.call(expr) && identical(expr[[1L]], quote(`{`))
}

# Determine whether an non-evaluated call is parenthesized
#
# @param a non-evaluated expression
# @retun logical - TRUE if expression is parenthesized, FALSE otherwise.
is_parenthesized <- function(expr)
{
  is.call(expr) && identical(expr[[1L]], quote(`(`))
}

# Check whether a symbol is a valid magrittr pipe.
#
# @param pipe A quoted symbol
# @return logical - TRUE if a valid magrittr pipe, FALSE otherwise.
is_pipe <- function(pipe)
{
  identical(pipe, quote(`%>%`))   ||
  identical(pipe, quote(`%T>%`))  ||
  identical(pipe, quote(`%$%`))   ||
  identical(pipe, quote(`%T$%`))
}

# Check whether a pipe is a tee.
#
# @param pipe A (quoted) pipe
# @return logical - TRUE if pipe is a tee, FALSE otherwise.
is_tee_pipe <- function(pipe)
{
  identical(pipe, quote(`%T>%`)) || identical(pipe, quote(`%T$%`))
}

# Make Function Body From a List of Expressions.
#
# @param expression_list A list of unevaluated expressions.
# @return A function body.
make_body <- function(expression_list)
{
  as.call(c(quote(`{`), expression_list))
}

# Make a Function of the "dot" Argument.
#
# @param body The function body.
# @param env The environment in which to create the function.
#
# @return A function body.
make_dot_function <- function(body, env)
{
  eval(call("function", as.pairlist(alist(.=)), body), env, env)
}

# Determine if an Expression Needs a "dot" Inserted.
#
# @param expr The expression to check.
#
# @return logical - TRUE if the expression needs a dot, FALSE otherwise.
needs_dot <- function(expr)
{
  !any(vapply(expr[-1L], identical, logical(1L), quote(.)))
}

# Standardize Right-hand Side Expression
#
# Several ways of writing the right-hand side expressions are possible.
# `standardize_rhs` standardizes them into the expression that goes in
# the final function.
#
# @param rhs The right-hand side expression.
# @param pipe The pipe operator from the pipe operation in which the
#   rhs occurs.
#
# @return A standardized right-hand side expression.
standardize_rhs <- function(rhs, pipe)
{
  if (is_exposition_pipe(pipe))
    exposition_call(rhs)
  else if (is_lambda_expression(rhs))
    rhs
  else if (is_function(rhs) || has_special_operator(rhs))
    function_call(rhs)
  else if (needs_dot(rhs))
    with_dot(rhs)
  else
    rhs
}

# Expand an Expression with a "dot".
#
# @param expr The expression to expand.
#
# @return The expanded expression.
with_dot <- function(expr)
{
  as.call(c(expr[[1L]], quote(.), as.list(expr[-1L])))
}
