context("deprecation warnings.")

test_that("deprecation warnings are given when old syntaxes are used.", {

  # deprecated due to rhs not in parens
#   expect_warning(1:10 %>% lambda(x ~ x^2),  "deprecated")
#   expect_warning(1:10 %>% lambda(x -> x^2), "deprecated")
#   expect_warning(1:10 %>% l(x ~ x^2),       "deprecated")
#   expect_warning(1:10 %>% l(x -> x^2),      "deprecated")
 # expect_warning(1:10 %>% function(x) x^2,  "deprecated")

  # deprecated due to old lambda syntax involving ->
#   expect_warning(1:10 %>% (lambda(x -> x^2)), "syntax has changed")
#   expect_warning(1:10 %>% (l(x -> x^2)),      "syntax has changed")

})
