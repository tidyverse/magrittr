
test_that("freduce() supports long lists (kcf-jackson/sketch#5)", {
  fns <- rep(list(identity), 1000)
  expect_equal(freduce(1, fns), 1)
})
