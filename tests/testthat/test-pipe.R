
test_that("add_dot() adds dot if needed", {
  expect_identical(add_dot(quote(list(a = 2))), quote(list(., a = 2)))
  expect_identical(add_dot(quote(list(a = 2, .))), quote(list(a = 2, .)))
  expect_identical(add_dot(quote(list(., a = 2))), quote(list(., a = 2)))
})
