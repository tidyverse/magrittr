# Build the Pipeline from the Matched Call.
#
# @param matched_call The matched pipeline call.
# @param env The environment in which to evaluate expressions.
# @return A list including the pipeline, and the left-hand side expression.
build <- function(matched_call, env)
{
  tokens <- tokenize(matched_call, env)

  lhs   <- tokens[[1]]
  rhss  <- tokens[-1][c(FALSE, TRUE)]
  pipes <- tokens[-1][c(TRUE, FALSE)]

  n <- length(rhss)
  standardized_rhss <- Map(standardize_rhs, rhss, pipes)
  butlast <- Map(dot_assign, standardized_rhss[-n], pipes[-n])

  if (is_tee_pipe(pipes[[n]])) {
    last <- call("{", standardized_rhss[[n]], quote(.))
  } else {
    last <- standardized_rhss[[n]]
  }

  body <- make_body(c(butlast, last))

  pipeline <- make_dot_function(body, env)

  list(pipeline = pipeline, lhs = lhs)
}
