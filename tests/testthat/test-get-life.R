context("test-get-life.R")

test_that("get_life returns a data frame", {
  df <- get_life()
  expect_is(df, class = "data.frame")
})
