
context("Tampering")

test_that("We can detect if we are in a pipe", {

  skip(message = "not ready yet for a real test")

  old_handler <- getOption("error")
  on.exit(options(error = old_handler))
  options(error = tamper)

  1:10 %>%
    (function(x) force(x)) %>%
    multiply_by(10) %>%
    add(10) %>%
    add("oh no!") %>%
    subtract(5) %>%
    divide_by(5)

})

test_that("What if the pipe is in a function", {

  skip(message = "not ready yet for a real test")

  old_handler <- getOption("error")
  on.exit(options(error = old_handler))
  options(error = tamper)

  f <- function(data) {
    data %>%
      (function(x) force(x)) %>%
      multiply_by(10) %>%
      add(10) %>%
      add("oh no!") %>%
      subtract(5) %>%
      divide_by(5)
  }

  f(1:10)

})

test_that("Pipes within pipes are OK", {

  skip(message = "not ready yet for a real test")

  old_handler <- getOption("error")
  on.exit(options(error = old_handler))
  options(error = tamper)

  f <- function(data) {
    data %>%
      (function(x) force(x)) %>%
      multiply_by(10) %>%
      add(10) %>%
      add("oh no!") %>%
      subtract(5) %>%
      divide_by(5)
  }

  1:10 %>%
    multiply_by(2) %>%
    f() %>%
    add(1:10)

})

test_that("Error in the lhs is OK", {

  skip(message = "not ready yet for a real test")

  old_handler <- getOption("error")
  on.exit(options(error = old_handler))
  options(error = tamper)

  (1 + "foo") %>%
    multiply_by(2) %>%
    add(1) %>%
    print()

})
