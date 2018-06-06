context("test-get-income.R")

test_that("get_income returns a data frame", {
  df <- get_income()
  expect_is(df, class = "data.frame")
})
