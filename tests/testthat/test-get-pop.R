context("test-get-pop.R")

test_that("get_pop returns a data frame", {
  df <- get_pop()
  expect_is(df, class = "data.frame")
})
