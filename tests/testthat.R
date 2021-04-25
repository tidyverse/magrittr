if (require(testthat)) {
  library(magrittr)

  test_check("magrittr")
} else
  warning("'magrittr' requires 'testthat' for tests")
