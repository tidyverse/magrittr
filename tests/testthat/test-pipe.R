
test_that("exposition operator wraps `with()`", {
  out <- mtcars %>% identity() %$% (head(cyl) / mean(am))
  expect_identical(out, head(mtcars$cyl) / mean(mtcars$am))
})

test_that("compound operator works with fancy pipes", {
  data <- mtcars
  data %<>% identity %$% (head(cyl) / mean(am))
  data
  expect_identical(data, head(mtcars$cyl) / mean(mtcars$am))
})

test_that("pipe expressions are evaluated in the current environment", {
  fn <- function(...) parent.frame()
  out <- NULL %>% identity() %>% fn()
  expect_identical(out, environment())

  fn <- function() {
    NULL %>% identity() %>% { return(TRUE) }
    FALSE
  }
  expect_true(fn())
})

test_that("`.` is restored", {
  1 %>% identity()
  expect_error(., "not found")

  . <- "foo"
  1 %>% identity()
  expect_identical(., "foo")
})
