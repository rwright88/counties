#' Read life expectancy data.
#'
#' @param path A path to a file.
#'
#' @return A data frame.
read_life <- function(path) {
  readr::read_csv(
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

#' Clean life expectancy data
#'
#' @param path A path to a directory of files.
#'
#' @return A data frame.
#' @export
get_life <- function(path) {
  files <- list.files(path, pattern = "*.CSV", full.names = TRUE)

  purrr::map_dfr(files, read_life) %>%
    dplyr::mutate(county_fips = stringr::str_pad(FIPS, width = 5, pad = "0")) %>%
    dplyr::filter(
      measure_id == 26,
      county_fips != "00001",
      sex_id == 3
    ) %>%
    dplyr::select(
      year = year_id,
      county_fips,
      life_expect = val
    )
}
