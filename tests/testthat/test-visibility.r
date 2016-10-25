context("visibility")


test_that("visibility status is preserved", {
  expect_true(withVisible(5 %>% seq_len)$visible)
  expect_false(withVisible(5 %>% seq_len %>% invisible)$visible)
})

test_that("visibility status for fseq", {
  a <- . %>% seq_len
  b <- . %>% seq_len %>% invisible
  expect_true(withVisible(a(5))$visible)
  expect_false(withVisible(b(5))$visible)
})
