#' Read population data.
#'
#' @param path A path to a file.
#'
#' @import readr
#' @return \code{tbl_df} with 18 columns: \code{STATE}, \code{COUNTY},
#'         \code{YEAR}, \code{AGEGRP}, \code{NHWA_MALE}, \code{NHWA_MALE},
#'         \code{NHWA_FEMALE}, \code{NHBA_MALE}, \code{NHBA_FEMALE},
#'         \code{NHIA_MALE}, \code{NHIA_FEMALE}, \code{NHAA_MALE},
#'         \code{NHAA_FEMALE}, \code{NHNA_MALE}, \code{NHNA_FEMALE},
#'         \code{NHTOM_MALE}, \code{NHTOM_FEMALE}, \code{H_MALE},
#'         \code{H_FEMALE}
read_pop <- function(path) {
  read_csv(
    path,
    col_types = cols_only(
      STATE = col_character(),
      COUNTY = col_character(),
      YEAR = col_integer(),
      AGEGRP = col_integer(),
      NHWA_MALE = col_integer(),
      NHWA_FEMALE = col_integer(),
      NHBA_MALE = col_integer(),
      NHBA_FEMALE = col_integer(),
      NHIA_MALE = col_integer(),
      NHIA_FEMALE = col_integer(),
      NHAA_MALE = col_integer(),
      NHAA_FEMALE = col_integer(),
      NHNA_MALE = col_integer(),
      NHNA_FEMALE = col_integer(),
      NHTOM_MALE = col_integer(),
      NHTOM_FEMALE = col_integer(),
      H_MALE = col_integer(),
      H_FEMALE = col_integer()
    )
  )
}

#' Recode race variables from population data.
#'
#' @param x Race variables.
#'
#' @return A vector the same size as \code{x}.
rec_race <- function(x) {
  case_when(
    str_detect(x, "nhwa")  ~ "white",
    str_detect(x, "nhba")  ~ "black",
    str_detect(x, "h_")    ~ "hispa",
    str_detect(x, "nhaa")  ~ "asian",
    str_detect(x, "nhia|nhna|nhtom") ~ "other",
    TRUE ~ NA_character_
  )
}

#' Get population data
#'
#' Get population and demograhpic data by year and county from the US Census
#' Bureau. Population is the population estimate as of July 1 of that year.
#'
#' @references \url{https://www2.census.gov/programs-surveys/popest/datasets/}
#' @return \code{tbl_df} with seven columns: \code{year}, \code{county_fips},
#'         \code{population}, \code{asian}, \code{black}, \code{hispa},
#'         \code{white}
#' @import dplyr tidyr stringr
#' @export
#' @examples \dontrun{
#' get_pop()
#' }
get_pop <- function() {
  file1 <- str_c(
    "https://www2.census.gov/programs-surveys/popest/datasets/",
    "2010-2016/counties/asrh/cc-est2016-alldata.csv"
  )

  raw <- read_pop(file1) %>%
    rename_all(str_to_lower) %>%
    filter(year >= 3, agegrp == 0) %>%
    select(state:year, nhwa_male:nhtom_female, h_male, h_female) %>%
    gather("race_sex", "population", nhwa_male:h_female) %>%
    mutate(
      year = year + 2007L,
      county_fips = str_c(state, county),
      race = rec_race(race_sex)
    ) %>%
    select(year, county_fips, race, population)

  pop_race <- raw %>%
    group_by(year, county_fips, race) %>%
    summarise(population = sum(population)) %>%
    ungroup()

  population <- pop_race %>%
    group_by(year, county_fips) %>%
    summarise(population = sum(population)) %>%
    ungroup()

  ratio <- pop_race %>%
    group_by(year, county_fips) %>%
    mutate(ratio = population / sum(population)) %>%
    ungroup() %>%
    select(-population) %>%
    spread(race, ratio) %>%
    select(-other)

  population %>%
    left_join(ratio, by = c("year", "county_fips"))
}
