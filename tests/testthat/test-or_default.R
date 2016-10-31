context("magrittr or default")

test_that("or_default works with NULLs.", {
  expect_that(NULL %||% 0, is_identical_to(0))
})

test_that("or_default works with NAs", {
  expect_that(NA %||% 0, is_identical_to(0))
})

test_that("or_default works with FALSE", {
  expect_false(FALSE %||% 0)
})

test_that("or_default does work with vectors of NA and returns equal lengths values", {
  input <- c(NA, NA, NA)
  expect_that(input %||% 0, is_identical_to(c(0, 0, 0)))
})