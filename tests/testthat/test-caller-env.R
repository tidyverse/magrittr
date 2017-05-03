context("caller env")

test_that("pipeline evaluation frame features a caller env marker", {
  nms1 <- mtcars %>% { ls(environment()) }
  nms2 <- mtcars %>% identity() %>% { ls(environment()) }
  expect_true("__magrittr_caller_env" %in% nms1)
  expect_true("__magrittr_caller_env" %in% nms2)

  fn <- function(.) parent.frame()
  nms3 <- mtcars %>% { } %>% identity() %>% fn() %>% ls()
  expect_true("__magrittr_caller_env" %in% nms3)
})
