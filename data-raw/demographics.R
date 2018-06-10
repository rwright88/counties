library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(purrr)
library(rvest)

# files =====

url_2000 <- str_c(
  "https://www2.census.gov/programs-surveys/popest/datasets/",
  "2000-2010/intercensal/county/"
)

file_2010 <- str_c(
  "https://www2.census.gov/programs-surveys/popest/datasets/",
  "2010-2016/counties/asrh/cc-est2016-alldata.csv"
)

# functions to read files =====

read_2000 <- function(file) {
  col_spec <- str_flatten(c(rep("c", 5), rep("i", 45)))
  read_csv(
    file,
    col_types = col_spec
  )
}

read_2010 <- function(file) {
  col_spec <- str_flatten(c(rep("c", 5), rep("i", 75)))
  read_csv(
    file,
    col_types = col_spec
  )
}

# functions to recode variables =====

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

# function to calculate demographics =====

calc_demo <- function(df) {
  pop_race <- df %>%
    group_by(county_fips, year, race) %>%
    summarise(population = sum(population)) %>%
    ungroup()

  pop_total <- pop_race %>%
    group_by(county_fips, year) %>%
    summarise(population = sum(population)) %>%
    ungroup()

  ratios <- pop_race %>%
    group_by(county_fips, year) %>%
    mutate(ratio = population / sum(population)) %>%
    ungroup() %>%
    select(-population) %>%
    spread(race, ratio) %>%
    select(-other)

  demographics <- pop_total %>%
    left_join(ratios, by = c("county_fips", "year")) %>%
    arrange(county_fips, year)

  demographics
}

# create 2000-2009 demographics =====

files <- read_html(url_2000) %>%
  html_nodes("a") %>%
  html_attr("href") %>%
  .[str_detect(., "co-est00int-all") & !is.na(.) & str_detect(., "csv")] %>%
  str_c(url_2000, .)

raw_2000 <- map_dfr(files, read_2000) %>%
  rename_all(str_to_lower) %>%
  filter(year %in% 2:11, agegrp == 99) %>%
  select(state:year, nhwa_male:nhtom_female, h_male, h_female) %>%
  gather("race_sex", "population", nhwa_male:h_female) %>%
  mutate(
    county_fips = str_c(state, county),
    year = year + 1998L,
    race = rec_race(race_sex)
  ) %>%
  select(county_fips, year, race, population)

demo_2000 <- calc_demo(raw_2000)

# create 2010+ demographics =====

raw_2010 <- read_2010(file_2010) %>%
  rename_all(str_to_lower) %>%
  filter(year >= 3, agegrp == 0) %>%
  select(state:year, nhwa_male:nhtom_female, h_male, h_female) %>%
  gather("race_sex", "population", nhwa_male:h_female) %>%
  mutate(
    county_fips = str_c(state, county),
    year = year + 2007L,
    race = rec_race(race_sex)
  ) %>%
  select(county_fips, year, race, population)

demo_2010 <- calc_demo(raw_2010)

# combine and save =====

demographics <- bind_rows(demo_2000, demo_2010) %>%
  arrange(county_fips, year)

devtools::use_data(demographics, overwrite = TRUE)
