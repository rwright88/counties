#' Read life expectancy data.
#'
#' @param path A path to a file.
#'
#' @import readr
#' @return A data frame.
read_life <- function(path) {
  read_csv(
    path,
    col_types = cols_only(
      measure_id = col_integer(),
      FIPS = col_character(),
      sex_id = col_integer(),
      year_id = col_integer(),
      val = col_double()
    )
  )
}

#' Get life expectancy data
#'
#' @param path A path to a directory of files.
#'
#' @return A data frame.
#' @import dplyr purrr stringr
#' @export
get_life <- function(path) {
  files <- list.files(path, pattern = "*.CSV", full.names = TRUE)

  map_dfr(files, read_life) %>%
    mutate(county_fips = str_pad(FIPS, width = 5, pad = "0")) %>%
    filter(
      measure_id == 26,
      county_fips != "00001",
      sex_id == 3
    ) %>%
    select(
      year = year_id,
      county_fips,
      life_expect = val
    )
}
