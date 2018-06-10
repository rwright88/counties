library(readr)
library(dplyr)
library(tidyr)
library(stringr)

read_pop <- function(file) {
  read_csv(
    file,
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

rec_race <- function(x) {
  case_when(
    str_detect(x, "nhwa") ~ "white",
    str_detect(x, "nhba") ~ "black",
    str_detect(x, "h_") ~ "hispanic",
    str_detect(x, "nhaa") ~ "asian",
    str_detect(x, "nhia|nhna|nhtom") ~ "other",
    TRUE ~ NA_character_
  )
}

file_2010 <- str_c(
  "https://www2.census.gov/programs-surveys/popest/datasets/",
  "2010-2016/counties/asrh/cc-est2016-alldata.csv"
)

raw <- read_pop(file_2010) %>%
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

pop_total <- pop_race %>%
  group_by(year, county_fips) %>%
  summarise(population = sum(population)) %>%
  ungroup()

ratios <- pop_race %>%
  group_by(year, county_fips) %>%
  mutate(ratio = population / sum(population)) %>%
  ungroup() %>%
  select(-population) %>%
  spread(race, ratio) %>%
  select(-other)

demographics <- pop_total %>%
  left_join(ratios, by = c("year", "county_fips"))

devtools::use_data(demographics, overwrite = TRUE)
