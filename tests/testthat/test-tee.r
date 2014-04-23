context("magrittr tee")

test_that("tee related functionality works.", {

  dim_message <- function(data.)
    message(sprintf("Data has dimension %d x %d", NROW(data.), NCOL(data.)))

  expect_that(iris %T>% dim_message, shows_message(dim_message(iris)))
  expect_that(iris %T>% dim_message, is_identical_to(iris))

  max_length_check <- function(data.)
    message(sprintf("Maximum value for Sepal.Length is %2.1f.",
            data.$Sepal.Length %>% max))

  # verbose pipe
  `%v>%` <- pipe_with(max_length_check)
  expect_that(iris %v>% head(30) %v>% head(20) %v>% head(10),
      shows_message("Maximum value for Sepal.Length is [0-9]+\\.[0-9]\\.",
          all = TRUE))

  lhs_trace <- local({
    count <- 0
    function(x) {
      count <<- count + 1
      cl <- match.call()
      cat(sprintf("%d: lhs = %s\n", count, deparse(cl[[2]])))
    }
  })

  `%c>%` <- pipe_with(lhs_trace)
  expect_that(capture.output(1:10 %c>% sin %c>% cos %c>% abs)[1:3],
              is_identical_to(c(
                "1: lhs = 1:10",
                "2: lhs = 1:10 %c>% sin",
                "3: lhs = 1:10 %c>% sin %c>% cos"
              )))

})
