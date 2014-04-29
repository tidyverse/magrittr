context("magrittr lambdas")


test_that("lambdas work", {

  x <- rnorm(100)

  expect_that(
    x %>% (lambda(y -> y[y > 0])), is_identical_to(
    x %>% (function(y) { y[y > 0] })(.)
  ))

  expect_that(
    iris %>% (lambda(x -> rbind(x %>% head, x %>% tail))), is_identical_to(
    rbind(head(iris), tail(iris))
  ))

  expect_that(
    sapply(1:100, (lambda(x -> x^2))), is_identical_to(
    sapply(1:100, function(x) x^2)
  ))

  expect_that(
    sapply(1:100, (lambda(z -> {
      set.seed(1)
      u <- runif(length(z))
      z[u > 0.5]
    }))), is_identical_to(
    sapply(1:100, function(z) {
      set.seed(1)
      u <- runif(length(z))
      z[u > 0.5]
    })
  ))

  expect_that(
    Filter((l(z -> z[z > 0])), x), is_identical_to(
    Filter(function(z) z[z > 0], x)
  ))

})

test_that("lambda throws informative error with incorrect input", {
  expect_error(lambda(10), "Malformed expression")
  expect_error(lambda(a), "Malformed expression")
  expect_error(lambda(function() 1), "Malformed expression")

  expect_error(lambda(1 -> 10), "Malformed expression")
  expect_error(lambda(f(1, 2) -> 10), "Malformed expression")
})
