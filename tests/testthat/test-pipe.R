
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
