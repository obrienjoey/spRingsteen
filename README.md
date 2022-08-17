<!-- README.md is generated from README.Rmd. Please edit that file -->



# spRingsteen <img src="man/figures/logo.png" align="right" width="120" />

<!-- badges: start -->
[![R-CMD-check](https://github.com/obrienjoey/spRingsteen/workflows/R-CMD-check/badge.svg)](https://github.com/obrienjoey/spRingsteen/actions)
[![CRAN status](https://www.r-pkg.org/badges/version/spRingsteen)](https://CRAN.R-project.org/package=spRingsteen)
<!-- badges: end -->

The spRingsteen package provides a number of dataframes describing the songs,
albums, tours, and setlists of Bruce Springsteen's career. The data (collected from [Brucebase](http://brucebase.wikidot.com/)) is provided
in a tidy form which is easily analyzed in `R`. The scripts which are used to scrape the data in their entirety, alongside a SQLite representation of the data may be viewed at a second repository [`springsteen_db`](https://github.com/obrienjoey/springsteen_db).

## Installation

You can install the released version of spRingsteen from [CRAN](https://cran.r-project.org/package=spRingsteen) with:

``` r
install.packages("spRingsteen")
```

Alternatively, you can install the development version of spRingsteen from GitHub like so:

``` r
remotes::install_github("obrienjoey/spRingsteen")
```

## Data refresh

While the **spRingsteen** [CRAN version](https://cran.r-project.org/package=spRingsteen) is updated every few months, the [Github (Dev) version](https://github.com/obrienjoey/spRingsteen) is updated on a daily basis. The `update_data` function enables to overcome this gap and keep the installed version with the most recent data available on the Github version:

``` r
library(spRingsteen)
update_data()
```

**Note:** must restart the R session to have the updates available

## Usage

### Concerts

The package includes datasets around the career of Bruce Springsteen. For example,
the touring history of him and his numerous bands is stored in `concerts`:


```r
library(spRingsteen)
library(dplyr)

concerts
#> # A tibble: 2,930 x 6
#>    gig_key                                       date       location        state city  country
#>    <chr>                                         <date>     <chr>           <chr> <chr> <chr>  
#>  1 /gig:1973-01-03-main-point-bryn-mawr-pa-early 1973-01-03 THE MAIN POINT~ PA    <NA>  USA    
#>  2 /gig:1973-01-03-main-point-bryn-mawr-pa-late  1973-01-03 THE MAIN POINT~ PA    <NA>  USA    
#>  3 /gig:1973-01-04-main-point-bryn-mawr-pa-early 1973-01-04 THE MAIN POINT~ PA    <NA>  USA    
#>  4 /gig:1973-01-04-main-point-bryn-mawr-pa-late  1973-01-04 THE MAIN POINT~ PA    <NA>  USA    
#>  5 /gig:1973-01-05-main-point-bryn-mawr-pa-early 1973-01-05 THE MAIN POINT~ PA    <NA>  USA    
#>  6 /gig:1973-01-05-main-point-bryn-mawr-pa-late  1973-01-05 THE MAIN POINT~ PA    <NA>  USA    
#>  7 /gig:1973-01-06-main-point-bryn-mawr-pa-early 1973-01-06 THE MAIN POINT~ PA    <NA>  USA    
#>  8 /gig:1973-01-06-main-point-bryn-mawr-pa-late  1973-01-06 THE MAIN POINT~ PA    <NA>  USA    
#>  9 /gig:1973-01-08-paul-s-mall-boston-ma-early   1973-01-08 PAUL'S MALL, B~ MA    <NA>  USA    
#> 10 /gig:1973-01-08-paul-s-mall-boston-ma-late    1973-01-08 PAUL'S MALL, B~ MA    <NA>  USA    
#> # ... with 2,920 more rows

# how many concerts have occurred in each country?

concerts %>% 
  count(country, sort = TRUE)
#> # A tibble: 39 x 2
#>    country       n
#>    <chr>     <int>
#>  1 USA        2261
#>  2 Canada       96
#>  3 England      88
#>  4 Australia    56
#>  5 Germany      52
#>  6 Spain        51
#>  7 Italy        50
#>  8 France       43
#>  9 Sweden       37
#> 10 Ireland      26
#> # ... with 29 more rows
```

### Setlists

It also has information of the setlists performed in these shows which are 
stored in `setlists`.


```r
setlists
#> # A tibble: 52,100 x 4
#>    gig_key                                       song_key                     song  song_number
#>    <chr>                                         <chr>                        <chr>       <int>
#>  1 /gig:1973-01-03-main-point-bryn-mawr-pa-early /song:it-s-hard-to-be-a-sai~ It's~           1
#>  2 /gig:1973-01-03-main-point-bryn-mawr-pa-early /song:santa-ana              Sant~           2
#>  3 /gig:1973-01-03-main-point-bryn-mawr-pa-early /song:secret-to-the-blues    Secr~           3
#>  4 /gig:1973-01-03-main-point-bryn-mawr-pa-early /song:new-york-song          New ~           4
#>  5 /gig:1973-01-08-paul-s-mall-boston-ma-early   /song:growin-up              Grow~           1
#>  6 /gig:1973-01-09-wbcn-studio-boston-ma         /song:satin-doll             Sati~           1
#>  7 /gig:1973-01-09-wbcn-studio-boston-ma         /song:bishop-danced          Bish~           2
#>  8 /gig:1973-01-09-wbcn-studio-boston-ma         /song:wild-billy-s-circus-s~ Circ~           3
#>  9 /gig:1973-01-09-wbcn-studio-boston-ma         /song:song-for-orphans       Song~           4
#> 10 /gig:1973-01-09-wbcn-studio-boston-ma         /song:does-this-bus-stop-at~ Does~           5
#> # ... with 52,090 more rows

# what song has been played most by Springsteen?

setlists %>%
  count(song, sort = TRUE)
#> # A tibble: 994 x 2
#>    song                            n
#>    <chr>                       <int>
#>  1 Born To Run                  1710
#>  2 Thunder Road                 1440
#>  3 The Promised Land            1387
#>  4 Badlands                     1195
#>  5 Tenth Avenue Freeze-Out      1107
#>  6 Dancing In The Dark          1050
#>  7 Born In The U.s.a.           1011
#>  8 The Rising                    881
#>  9 Rosalita (Come Out Tonight)   812
#> 10 Hungry Heart                  737
#> # ... with 984 more rows

# which song has most frequently opened a show?

setlists %>%
  filter(song_number == 1) %>%
  count(song, sort = TRUE) %>%
  slice(1)
#> # A tibble: 1 x 2
#>   song           n
#>   <chr>      <int>
#> 1 Growin' Up   272
```

### Songs

Further details of the songs themselves are available in `songs`, including
the album of appearance and also the full lyrics in some cases. This allows for 
some text mining or sentiment analysis using a package like tidytext.


```r
library(tidytext)
#> Warning: package 'tidytext' was built under R version 4.1.3

# what word appears most frequently in the **Born in the U.S.A** album?

songs %>% 
  filter(album == "Born In The U.S.A.") %>% 
  select(title, lyrics) %>% 
  unnest_tokens(word, lyrics) %>% 
  count(word, sort = TRUE) %>% 
  anti_join(stop_words, by = 'word')
#> # A tibble: 513 x 2
#>    word        n
#>    <chr>   <int>
#>  1 la        158
#>  2 yeah       47
#>  3 alright    41
#>  4 sha        40
#>  5 glory      37
#>  6 days       35
#>  7 u.s.a      32
#>  8 born       30
#>  9 hoo        27
#> 10 baby       26
#> # ... with 503 more rows
```

### Tours

Lastly, the `tour` table contains the tours associated with each concert.


```r
tours %>% 
  count(tour, sort = TRUE)
#> # A tibble: 24 x 2
#>    tour                                                   n
#>    <chr>                                              <int>
#>  1 Non-tour Shows                                       575
#>  2 Springsteen On Broadway                              268
#>  3 The River Tour                                       213
#>  4 The Wild, The Innocent & The E Street Shuffle Tour   197
#>  5 Born In The U.S.A. Tour                              156
#>  6 Greetings From Asbury Park Tour                      147
#>  7 Wrecking Ball Tour                                   134
#>  8 The Reunion Tour                                     132
#>  9 The Ghost Of Tom Joad Tour                           128
#> 10 The Rising Tour                                      120
#> # ... with 14 more rows
```

Of course the real advantage of this package is in combining the different
dataframes in order to infer useful information:


```r
# what was the most played song on each tour?
setlists %>% 
  left_join(tours, by = 'gig_key') %>%
  count(song, tour) %>%
  group_by(tour) %>%
  filter(n == max(n)) %>%
  arrange(desc(tour))
#> # A tibble: 95 x 3
#> # Groups:   tour [25]
#>    song                       tour                            n
#>    <chr>                      <chr>                       <int>
#>  1 Death To My Hometown       Wrecking Ball Tour            134
#>  2 Leap Of Faith              World Tour 1992-93            103
#>  3 American Land              Working On A Dream Tour        83
#>  4 Born To Run                Working On A Dream Tour        83
#>  5 The Promised Land          Vote For Change                22
#>  6 Adam Raised A Cain         Tunnel Of Love Express Tour    67
#>  7 All That Heaven Will Allow Tunnel Of Love Express Tour    67
#>  8 Born In The U.s.a.         Tunnel Of Love Express Tour    67
#>  9 Born To Run                Tunnel Of Love Express Tour    67
#> 10 Brilliant Disguise         Tunnel Of Love Express Tour    67
#> # ... with 85 more rows
```
