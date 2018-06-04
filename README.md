# counties

The goal of counties is to make it easy to create a US county dataset of the best available demographic, health, income, and other data.

## Installation

``` r
devtools::install_github("rwright88/counties")
```

## Usage

``` r
library(counties)

get_pop()
#> # A tibble: 21,994 x 7
#>     year county_fips population    asian  black   hispa white
#>    <int> <chr>            <int>    <dbl>  <dbl>   <dbl> <dbl>
#>  1  2010 01001            54742 0.00890  0.176  0.0239  0.772
#>  2  2010 01003           183199 0.00744  0.0932 0.0441  0.836
#>  3  2010 01005            27348 0.00439  0.468  0.0491  0.468
#>  4  2010 01007            22861 0.000875 0.219  0.0178  0.751
#>  5  2010 01009            57376 0.00216  0.0128 0.0814  0.888
#>  6  2010 01011            10892 0.00184  0.700  0.0720  0.218
#>  7  2010 01013            20938 0.00845  0.432  0.00927 0.540
#>  8  2010 01015           118468 0.00715  0.204  0.0330  0.737
#>  9  2010 01017            34101 0.00548  0.386  0.0159  0.581
#> 10  2010 01019            25977 0.00200  0.0463 0.0124  0.921
# ... with 21,984 more rows

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

- https://www2.census.gov/programs-surveys/popest/datasets/
- http://ghdx.healthdata.org/us-data
