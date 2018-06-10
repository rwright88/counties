library(readr)
library(dplyr)
library(stringr)
library(purrr)

file1 <- str_c(
  "http://ghdx.healthdata.org/sites/default/files/record-attached-files/",
  "IHME_USA_COUNTY_LE_MORTALITY_RISK_1980_2014_NATIONAL_STATES_DC_CSV.zip"
)

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

temp <- tempfile()
download.file(file1, temp, quiet = TRUE)
files <- unzip(temp, list = TRUE)[["Name"]]

life <- map_dfr(files, ~ read_life(unz(temp, .))) %>%
  mutate(county_fips = str_pad(FIPS, width = 5, pad = "0")) %>%
  filter(
    measure_id == 26,
    str_sub(county_fips, 1, 2) != "00",
    sex_id == 3
  ) %>%
  select(
    county_fips,
    year = year_id,
    life_expect = val
  ) %>%
  arrange(county_fips, year)

unlink(temp)

devtools::use_data(life, overwrite = TRUE)
