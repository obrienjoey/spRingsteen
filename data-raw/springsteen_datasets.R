library(readr)
library(tidyr)
library(dplyr)
library(stringr)

# Download the dataset from github repo which contains sqllite database
# and spreadsheets which are updated daily to incorporate new setlists.
# https://github.com/obrienjoey/springsteen_db/tree/main/csv

# there are four datasets each of which are loaded now

# CONCERTS

concerts <-
  readr::read_csv('https://raw.githubusercontent.com/obrienjoey/springsteen_db/main/csv/concerts.csv') %>%
    rename(gig_key = gig_url) %>%
    mutate(state = case_when(nchar(sub('.*\\, ', '', location)) == 2 ~ sub('.*\\, ', '', location),
                             TRUE ~ ''),
           city = case_when(nchar(sub('.*\\, ', '', location)) != 2 ~ stringr::str_to_title(sub('.*\\, ', '', location)),
                            TRUE ~ ''),
           location = case_when(sub('.*\\, ', '', location) %in% state.abb ~ paste0(location, ', USA'),
                                nchar(sub('.*\\, ', '', location)) == 2 ~ paste0(location, ', Canada'),
                                TRUE ~ location),
           country = sub('.*\\, ', '', location),
           country = ifelse(country == 'USA', country, stringr::str_to_title(country)),
           date = as.Date(date, format = '%Y-%M-%d')) %>%
  mutate(across(where(is.character), ~ if_else(.x == '', NA_character_ ,.x)))

# SETLISTS

setlists <-
  readr::read_csv('https://raw.githubusercontent.com/obrienjoey/springsteen_db/main/csv/setlists.csv') %>%
  rename(gig_key = gig_url,
         song_key = links,
         song = songs) %>%
  mutate(song_number = as.integer(song_number),
         song = stringr::str_to_title(song))

# TOURS

tours <-
  readr::read_csv('https://raw.githubusercontent.com/obrienjoey/springsteen_db/main/csv/tours.csv') %>%
    rename(gig_key = gig_url) %>%
    filter(gig_key %in% concerts$gig_key)

# SONGS

songs <-
  readr::read_csv('https://raw.githubusercontent.com/obrienjoey/springsteen_db/main/csv/songs.csv') %>%
    rename(song_key = links,
           title = titles)


usethis::use_data(concerts, overwrite = TRUE)
usethis::use_data(setlists, overwrite = TRUE)
usethis::use_data(tours, overwrite = TRUE)
usethis::use_data(songs, overwrite = TRUE)
