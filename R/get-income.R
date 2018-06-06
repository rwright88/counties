#' Read income data.
#'
#' @param path A path to a file.
#'
#' @import readr dplyr stringr
#' @return \code{tbl_df} with 3 columns: \code{state}, \code{county},
#'         \code{income_hh}, \code{year}
read_income <- function(path) {
  # for now, name of file must contain year of data
  read_fwf(
    path,
    col_positions = fwf_cols(
      state = c(1, 2),
      county = c(4, 6),
      income_hh = c(134, 139)
    ),
    col_types = "cci",
    na = c("NA", "", ".")
  ) %>%
    mutate(year = str_extract(path, "\\d{4}"))
}

#' Get income data
#'
#' Get income data by year and county from the US Census Bureau. Income is
#' median household income in nominal dollars.
#'
#' @references \url{https://www2.census.gov/programs-surveys/saipe/datasets/}
#' @return \code{tbl_df} with seven columns: \code{year}, \code{income_hh}
#' @import dplyr stringr
#' @export
#' @examples \dontrun{
#' get_pop()
#' }
get_income <- function() {
  # scrape pages to get files
  url <- "https://www2.census.gov/programs-surveys/saipe/datasets/"
  # urls <- read_html(url) %>%
  #   html_nodes("a") %>%
  #   html_attr("href") %>%
  #   .[str_detect(., "^\\d{4}/")] %>%
  #   .[!is.na(.)] %>%
  #   str_c(url, .)

  files <- str_c(url, c(
    "2015/2015-state-and-county/est15all.txt",
    "2016/2016-state-and-county/est16all.txt"
  ))

  map_dfr(files, read_income) %>%
    mutate(county_fips = str_c(
      str_pad(state, 2, pad = "0"),
      str_pad(county, 3, pad = "0"))
    ) %>%
    filter(str_sub(county_fips, 3, 5) != "000") %>%
    select(year, county_fips, income_hh) %>%
    arrange(year, county_fips)
}
