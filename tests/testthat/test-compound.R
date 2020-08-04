context("assignment pipe")

test_that("Assignment pipe works", {

  x <- y <- 1:10
  x[1:5] <- sin(cos(x[1:5]))
  y[1:5] %<>% cos %>% sin

  expect_that(x, is_identical_to(y))


  somedata <- iris
  somedata$Sepal.Length %<>% add(10)
  iris$Sepal.Length <- iris$Sepal.Length + 10

  expect_that(somedata, is_identical_to(iris))

  z <- 1:10
  z %<>% add(2) %T>% plot
  expect_that(z, is_identical_to(as.numeric(3:12)))

})

test_that("can't assign to non-assignment expression", {
  msg <- conditionMessage(tryCatch(error = identity, identity(1) <- NULL))
  expect_error(
    1 %>% identity() %<>% identity(),
    msg
  )
})
