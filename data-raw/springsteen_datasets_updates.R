library(tidyr)
library(dplyr)

update_spRingsteen_data <- function(){

  flag <- FALSE

  # check if there are concert updates
  concerts_current <- spRingsteen::concerts

  concerts <- readr::read_csv("https://raw.githubusercontent.com/obrienjoey/springsteen_db/master/csv/concerts.csv") %>%
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

  if(identical(concerts_current, concerts)){
    print('no concert updates')
  } else{
    usethis::use_data(concerts, overwrite = TRUE)
    flag <- TRUE
  }

  # check if there are setlist updates
  setlists_current <- spRingsteen::setlists

  setlists <- readr::read_csv('https://raw.githubusercontent.com/obrienjoey/springsteen_db/main/csv/setlists.csv') %>%
    rename(gig_key = gig_url,
           song_key = links,
           song = songs) %>%
    mutate(song_number = as.integer(song_number),
           song = stringr::str_to_title(song))

  if(identical(setlists_current, setlists)){
    print('no setlist updates')
  } else{
    usethis::use_data(setlists, overwrite = TRUE)
    flag <- TRUE
  }

  # check if there are song updates
  songs_current <- spRingsteen::songs

  songs <- readr::read_csv('https://raw.githubusercontent.com/obrienjoey/springsteen_db/main/csv/songs.csv') %>%
    rename(song_key = links,
           title = titles)

  if(identical(songs_current, songs)){
    print('no song updates')
  } else{
    usethis::use_data(songs, overwrite = TRUE)
    flag <- TRUE
  }

  # check if there are tour updates
  tours_current <- spRingsteen::tours

  tours <- readr::read_csv('https://raw.githubusercontent.com/obrienjoey/springsteen_db/main/csv/tours.csv') %>%
    rename(gig_key = gig_url) %>%
    filter(gig_key %in% concerts$gig_key)

  if(identical(tours_current, tours)){
    print('no tour updates')
  } else{
    usethis::use_data(tours, overwrite = TRUE)
    flag <- TRUE
  }

  return(print("Done..."))

}
