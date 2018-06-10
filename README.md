
<!-- README.md is generated from README.Rmd. Please edit that file -->
counties
========

This package contains US county data by year for demographics, income, and health.

Installation
------------

``` r
# install.packages("devtools")
devtools::install_github("rwright88/counties")
```

Usage
-----

``` r
counties::demographics
#> # A tibble: 53,424 x 7
#>    county_fips  year population   asian black hispanic white
#>    <chr>       <int>      <int>   <dbl> <dbl>    <dbl> <dbl>
#>  1 01001        2000      44021 0.00454 0.170   0.0139 0.799
#>  2 01001        2001      44889 0.00530 0.170   0.0151 0.796
#>  3 01001        2002      45909 0.00588 0.171   0.0161 0.793
#>  4 01001        2003      46800 0.00613 0.172   0.0169 0.791
#>  5 01001        2004      48366 0.00657 0.172   0.0180 0.788
#>  6 01001        2005      49676 0.00709 0.172   0.0199 0.785
#>  7 01001        2006      51328 0.00715 0.175   0.0203 0.782
#>  8 01001        2007      52405 0.00754 0.176   0.0222 0.778
#>  9 01001        2008      53277 0.00788 0.177   0.0221 0.777
#> 10 01001        2009      54135 0.00837 0.178   0.0234 0.773
#> # ... with 53,414 more rows
```

``` r
counties::income
#> # A tibble: 53,410 x 3
#>    county_fips  year income_hh
#>    <chr>       <int>     <int>
#>  1 01001        2000     42463
#>  2 01001        2001     42183
#>  3 01001        2002     42841
#>  4 01001        2003     44241
#>  5 01001        2004     45379
#>  6 01001        2005     45019
#>  7 01001        2006     46491
#>  8 01001        2007     50375
#>  9 01001        2008     51622
#> 10 01001        2009     53081
#> # ... with 53,400 more rows
```

``` r
counties::life
#> # A tibble: 109,970 x 3
#>    county_fips  year life_expect
#>    <chr>       <int>       <dbl>
#>  1 01001        1980        72.0
#>  2 01001        1981        72.3
#>  3 01001        1982        72.6
#>  4 01001        1983        72.5
#>  5 01001        1984        72.6
#>  6 01001        1985        72.7
#>  7 01001        1986        72.7
#>  8 01001        1987        72.9
#>  9 01001        1988        72.9
#> 10 01001        1989        73.2
#> # ... with 109,960 more rows
```

Sources
-------

-   <https://www2.census.gov/programs-surveys/popest/datasets/>
-   <https://www2.census.gov/programs-surveys/saipe/datasets/>
-   <http://ghdx.healthdata.org/us-data>
