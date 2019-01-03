context("tee pipe")

test_that("Tee pipe related functionality works.", {

  dim_message <- function(data.)
    message(sprintf("Data has dimension %d x %d", NROW(data.), NCOL(data.)))

  expect_that(iris %T>% dim_message, shows_message(dim_message(iris)))
  expect_that(iris %T>% dim_message, is_identical_to(iris))

})
