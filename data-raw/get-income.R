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
    mutate(year = as.integer(str_extract(path, "\\d{4}")))
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
  url <- "https://www2.census.gov/programs-surveys/saipe/datasets/"
  files <- str_c(url, c(
    "2000/2000-state-and-county/est00all.dat",
    "2001/2001-state-and-county/est01all.dat",
    "2002/2002-state-and-county/est02all.dat",
    "2003/2003-state-and-county/est03all.dat",
    "2004/2004-state-and-county/est04all.txt",
    "2005/2005-state-and-county/est05all.txt",
    "2006/2006-state-and-county/est06all.txt",
    "2007/2007-state-and-county/est07all.txt",
    "2008/2008-state-and-county/est08all.txt",
    "2009/2009-state-and-county/est09all.txt",
    "2010/2010-state-and-county/est10all.txt",
    "2011/2011-state-and-county/est11all.txt",
    "2012/2012-state-and-county/est12all.txt",
    "2013/2013-state-and-county/est13all.txt",
    "2014/2014-state-and-county/est14all.txt",
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

income <- get_income()

devtools::use_data(income)
