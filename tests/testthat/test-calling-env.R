context("calling environment")

called_fun <- function(...) calling_env()

test_that("Calling env is retrieved correctly within pipe chain", {
  calling_fun <- function() {
    actual_calling_env <- environment()
    alleged_calling_env <- mtcars %>% identical() %>% called_fun()

    expect_identical(alleged_calling_env, actual_calling_env)
  }

  calling_fun()
})

test_that("Calling env is retrieved correctly outside pipe chain", {
  calling_fun <- function() {
    actual_calling_env <- environment()
    alleged_calling_env <- called_fun()

    expect_identical(alleged_calling_env, actual_calling_env)
  }

  calling_fun()
})
