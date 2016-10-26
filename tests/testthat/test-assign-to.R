context("Assign to")

test_that("Assigns to current environment",{
  assign_to(mtcars, mtcars1)
  expect_true(exists("mtcars1"))
  mtcars %>% assign_to(mtcars2)
  expect_true(exists("mtcars2"))
})

f <- function(dat, where = NULL) {
  assign_to(dat, dat1)
  dat %>% assign_to(dat2)
  assign_to(dat, dat3, where = where)
  dat %>% assign_to(dat4, where = where)
  c(exists("dat1"),
    exists("dat2"),
    exists("dat3", where = where),
    exists("dat4", where = where))
}

test_that("Assigns to local environment within functions", {
  x <- f(mtcars, where = environment())
  expect_true(all(x))
  expect_false(any(c(exists("dat1"), exists("dat2"))))
  expect_true(all(c(exists("dat3"), exists("dat4"))))
})

test_that("Nested calls work", {
  assign_to(f(mtcars, where = environment()), assign_to_tests)
  expect_true(all(assign_to_tests))
  expect_false(any(c(exists("dat1"), exists("dat2"))))
  expect_true(all(c(exists("dat3"), exists("dat4"))))
  rm(list=c("dat3","dat4"))
  
  f(mtcars, where = environment()) %>% assign_to(assign_to_tests)
  expect_true(all(assign_to_tests))
  expect_false(any(c(exists("dat1"), exists("dat2"))))
  expect_true(all(c(exists("dat3"), exists("dat4"))))
})

test_that("where option works",{
  assign_to(mtcars, mtcars_global, where = globalenv())
  expect_false(exists("mtcars_global", inherits = FALSE))
  expect_true(exists("mtcars_global", where = globalenv()))
})
