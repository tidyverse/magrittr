context("partial functions")


test_that("partialized functions work", {

  two_by_two <- partialize(matrix(nrow = 2, ncol = 2))
  expect_that(two_by_two(1:4), is_identical_to(matrix(1:4, 2, 2)))

  by_row <- partialize(two_by_two(byrow = TRUE))
  expect_that(by_row(1:4), is_identical_to(matrix(1:4, 2, 2, TRUE)))

  expect_that(partialize(c(1, 2, 3))(4, 5), is_equivalent_to(1:5))

  sum_rm <- partialize(sum(na.rm = TRUE))
  expect_that(sum_rm(c(1, 2, NA, 3)), is_equivalent_to(sum(1:3)))

})

test_that("partialize throws informative error with incorrect input", {
  expect_error(partialize(lm), "expr must be a \\(partial function\\) call")
  expect_error(partialize(nosuchfunction(1)),
               "Error in eval\\(expr, envir, enclos\\)")
})
