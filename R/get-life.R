#' Read life expectancy data.
#'
#' @param path A path to a file.
#'
#' @import readr
#' @return \code{tbl_df} with five columns: \code{measure_id}, \code{FIPS},
#'         \code{sex_id}, \code{year_id}, \code{val}
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
#' Get life expectancy data by year and county from the Global Health Data Exchange
#'
#' @references \url{http://ghdx.healthdata.org/us-data}
#' @return \code{tbl_df} with three columns: \code{year}, \code{county_fips},
#'         \code{life_expect}
#' @import dplyr purrr stringr
#' @export
#' @examples \dontrun{
#' get_life()
#' }
get_life <- function() {
  # this probably changes often
  file1 <- str_c(
    "http://ghdx.healthdata.org/sites/default/files/record-attached-files/",
    "IHME_USA_COUNTY_LE_MORTALITY_RISK_1980_2014_NATIONAL_STATES_DC_CSV.zip"
  )

  temp <- tempfile()
  utils::download.file(file1, temp, quiet = TRUE)
  files <- utils::unzip(temp, list = TRUE)[["Name"]]

  df <- map_dfr(files, ~ read_life(unz(temp, .))) %>%
    mutate(county_fips = str_pad(FIPS, width = 5, pad = "0")) %>%
    filter(
      measure_id == 26,
      str_sub(county_fips, 1, 2) != "00",
      sex_id == 3
    ) %>%
    select(
      year = year_id,
      county_fips,
      life_expect = val
    ) %>%
    arrange(year, county_fips)

  unlink(temp)

  df
}
