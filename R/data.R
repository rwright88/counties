#' Demographics
#'
#' Demographics and population data by county and year from the US Census
#' Bureau. Population is the population estimate as of July 1 of that year.
#'
#' @format A data frame with seven variables:
#' \describe{
#' \item{\code{county_fips}}{FIPS county code}
#' \item{\code{year}}{Year}
#' \item{\code{population}}{Population estimate as of July 1}
#' \item{\code{asian}}{Distribution of population that is Asian}
#' \item{\code{black}}{Distribution of population that is Black}
#' \item{\code{hispanic}}{Distribution of population that is Hispanic}
#' \item{\code{white}}{Distribution of population that is White}
#' }
#'
#' For further details, see \url{https://www2.census.gov/programs-surveys/popest/datasets/}
#'
"demographics"

#' Income
#'
#' Income data by county and year from the US Census Bureau. Income is median
#' household income in nominal dollars.
#'
#' @format A data frame with three variables:
#' \describe{
#' \item{\code{county_fips}}{FIPS county code}
#' \item{\code{year}}{Year}
#' \item{\code{income_hh}}{Median household income}
#' }
#'
#' For further details, see \url{https://www2.census.gov/programs-surveys/saipe/datasets/}
#'
"income"

#' Life expectancy
#'
#' life expectancy data by county and year from the Global Health Data Exchange.
#'
#' @format A data frame with three variables:
#' \describe{
#' \item{\code{county_fips}}{FIPS county code}
#' \item{\code{year}}{Year}
#' \item{\code{life_expect}}{Life expectancy at birth}
#' }
#'
#' For further details, see \url{http://ghdx.healthdata.org/us-data}
#'
"life"
