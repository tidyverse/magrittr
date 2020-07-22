
test_that("exposition operator wraps `with()`", {
  out <- mtcars %>% identity() %$% (head(cyl) / mean(am))
  expect_identical(out, head(mtcars$cyl) / mean(mtcars$am))
})
