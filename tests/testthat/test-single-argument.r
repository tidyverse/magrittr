context("%>%: one-argument function alternatives.")

test_that("%>% works as expected with and without parentheses and placeholder", {
  
  expect_that(1:100 %>% sin %>% abs,       is_identical_to(abs(sin(1:100))))
  expect_that(1:100 %>% sin() %>% abs(),   is_identical_to(abs(sin(1:100))))
  expect_that(1:100 %>% sin(.) %>% abs(.), is_identical_to(abs(sin(1:100))))
  
  expect_that(iris %>% head, is_identical_to(head(iris)))
  
  dnormsd <- function(sd) function(x) dnorm(x, sd = sd)
  some_x  <- rnorm(20)
  expect_that(some_x %>% dnormsd(5)(.), is_identical_to(dnormsd(5)(some_x)))
  expect_that(some_x %>% (dnormsd(5)), is_identical_to(dnormsd(5)(some_x)))
  
  expect_that(some_x %>% dnormsd(5), throws_error())
  expect_that(some_x %>% function(x) {x} %>% sin, throws_error())
})
