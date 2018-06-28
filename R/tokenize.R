# Tokenize A Pipeline Expression.
#
# @param expr The expression to tokenize.
# @param env The environment in which to evaluate parenthesized expressions.
# @return A list of length 1 + 2*number-of-rhs-expressions. The first element
#   is the left-hand side, then every other is a pipe operator, and the rest
#   are right-hand side expressions.
tokenize <- function(expr, env)
{
  if (is_parenthesized(expr))
    expr <- eval(expr, env, env)

  if (is_formularized(expr))
    expr <- expr[[2L]]

  if (is.call(expr) && length(expr) == 3L && is_pipe(expr[[1L]])) {
    c(tokenize(expr[[2L]], env), expr[[1L]],
      tokenize(expr[[3L]], env))
  } else {
    list(expr)
  }
}
