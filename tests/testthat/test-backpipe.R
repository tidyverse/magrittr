context("magrittr backpipe")

test_that("backpipe operator works as intended.", {

  expect_equal( letters %>% paste0( 1:26 ), paste0(1:26) %<% letters )
  expect_equal( letters %>% paste0( 1:26 ), paste0( ., 1:26) %<% letters )
  expect_equal( 1:26 %>% paste0( letters ), paste0( 1:26, .) %<% letters )

})
