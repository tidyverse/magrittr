context("functional sequences")


test_that("fseq functions work", {
  a <- . %>% cos %>% sin %>% tan
  
  b <- function(x) tan(sin(cos(x)))

  expect_that(a(1:10), is_identical_to(b(1:10)))
})

test_that("fseq functions can be extracted", {
  a <- . %>% cos %>% sin %>% tan
  
  fn <- functions(a)
  expect_equal(length(fn), 3L)
  expect_equal(fn[[1L]], function(.) cos(.))
  expect_equal(fn[[2L]], function(.) sin(.))
  expect_equal(fn[[3L]], function(.) tan(.))
})

test_that("fseq associativity", {
  a <- . %>% cos %>% sin %>% tan
  
  expect_equal(a(1:10), a[3](a[2](a[1](1:10))))
  expect_equal(a(1:10), a[3](a[2](a[[1]](1:10))))
  expect_equal(a(1:10), a[3](a[[2]](a[1](1:10))))
  expect_equal(a(1:10), a[3](a[[2]](a[[1]](1:10))))
  expect_equal(a(1:10), a[[3]](a[2](a[1](1:10))))
  expect_equal(a(1:10), a[[3]](a[2](a[[1]](1:10))))
  expect_equal(a(1:10), a[[3]](a[[2]](a[1](1:10))))
  expect_equal(a(1:10), a[[3]](a[[2]](a[[1]](1:10))))
  expect_equal(a(1:10), a[3](a[1:2](1:10)))
  expect_equal(a(1:10), a[[3]](a[1:2](1:10)))
  expect_equal(a(1:10), a[2:3](a[1](1:10)))
  expect_equal(a(1:10), a[2:3](a[[1]](1:10)))
  expect_equal(a(1:10), a[1:3](1:10))
})

test_that("as.function", {
  a <- . %>% cos %>% sin %>% tan
  
  b <- as.function(a)
  
  expect_identical(a(1:10), b(1:10))
  expect_identical(environment(a), environment(b))
  expect_identical(formals(a), formals(b))
  expect_null(attributes(b))
})
