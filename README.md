# counties

Make it easy to get the best available demographic, health, income, and other US county data.

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
#>  2  1980 01003              74.1
#>  3  1980 01005              71.5
#>  4  1980 01007              71.6
#>  5  1980 01009              74.0
#>  6  1980 01011              69.9
#>  7  1980 01013              71.7
#>  8  1980 01015              72.3
#>  9  1980 01017              72.2
#> 10  1980 01019              72.3
# ... with 109,960 more rows
```

## Sources

- https://www2.census.gov/programs-surveys/popest/datasets/
- http://ghdx.healthdata.org/us-data
