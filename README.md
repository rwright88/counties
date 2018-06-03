# counties

The goal of counties is to make it easy to create a US county dataset of the best available demographic, health, income, and other data.

## Installation

``` r
devtools::install_github("rwright88/counties")
```

## Usage

``` r
library(counties)

get_life()
#> # A tibble: 111,720 x 3
#>     year county_fips life_expect
#>    <int> <chr>             <dbl>
#>  1  1980 01001              72.0
#>  2  1981 01001              72.3
#>  3  1982 01001              72.6
#>  4  1983 01001              72.5
#>  5  1984 01001              72.6
#>  6  1985 01001              72.7
#>  7  1986 01001              72.7
#>  8  1987 01001              72.9
#>  9  1988 01001              72.9
#> 10  1989 01001              73.2
#> # ... with 111,710 more rows
```

## Sources

- http://ghdx.healthdata.org/us-data
