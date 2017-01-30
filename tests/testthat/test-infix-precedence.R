context('infix precedence')

test_that('%>% takes precedence over infix function', {
  `%<<<%` <- `<-`

  # without precedence would have expected the result of (x %>>>% 3030) is
  # passed to as.character
  expect_silent(x %<<<% 3030 %>% as.character)
  expect_equal(x, '3030')

  `%||%` <- function(a, b) if (is.null(a)) b else a
  
  # without precedence would have expected the result of (1 %||% FALSE) is
  # passed to as.null
  expect_equal(1 %||% FALSE %>% as.null, 1)
})
