
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
