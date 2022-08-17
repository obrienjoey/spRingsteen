#' Update the Package Datasets
#' @export
#' @description Checks if new data is available on the package dev version (Github).
#' In case new data is available the function will enable the user the update the datasets
#'
#' @importFrom rlang .data
#'
#' @examples
#' \dontrun{
#'
#' data_update()
#'
#' }
update_data <- function(){
  flag <- FALSE
  `%>%` <- magrittr::`%>%`
  # check if there are concert updates
  concerts_current <- spRingsteen::concerts

  concerts_git <- readr::read_csv("https://raw.githubusercontent.com/obrienjoey/springsteen_db/master/csv/concerts.csv") %>%
    dplyr::rename(gig_key = .data$gig_url) %>%
    dplyr::mutate(state = dplyr::case_when(nchar(sub('.*\\, ', '', .data$location)) == 2 ~ sub('.*\\, ', '', .data$location),
                                           TRUE ~ ''),
           city = dplyr::case_when(nchar(sub('.*\\, ', '', .data$location)) != 2 ~ stringr::str_to_title(sub('.*\\, ', '', .data$location)),
                                   TRUE ~ ''),
           location = dplyr::case_when(sub('.*\\, ', '', .data$location) %in% state.abb ~ paste0(.data$location, ', USA'),
                                       nchar(sub('.*\\, ', '', .data$location)) == 2 ~ paste0(.data$location, ', Canada'),
                                       TRUE ~ .data$location),
           country = sub('.*\\, ', '', .data$location),
           country = dplyr::if_else(.data$country == 'USA', .data$country, stringr::str_to_title(.data$country)),
           date = as.Date(date, format = '%Y-%M-%d')) %>%
    dplyr::mutate(dplyr::across(tidyselect::vars_select_helpers$where(is.character), ~ dplyr::if_else(.x == '', NA_character_ ,.x)))

  if(!(base::identical(concerts_current, concerts_git))){
    flag <- TRUE
  }

  # check if there are setlist updates
  setlists_current <- spRingsteen::setlists

  setlists_git <- readr::read_csv('https://raw.githubusercontent.com/obrienjoey/springsteen_db/main/csv/setlists.csv') %>%
    dplyr::rename(gig_key = .data$gig_url,
                  song_key = .data$links,
                  song = .data$songs) %>%
    dplyr::mutate(song_number = as.integer(.data$song_number),
                  song = stringr::str_to_title(.data$song))

  if(!(base::identical(setlists_current, setlists_git))){
    flag <- TRUE
  }

  # check if there are song updates
  songs_current <- spRingsteen::songs

  songs_git <- readr::read_csv('https://raw.githubusercontent.com/obrienjoey/springsteen_db/main/csv/songs.csv') %>%
    dplyr::rename(song_key = .data$links,
                  title = .data$titles)

  if(!(base::identical(songs_current, songs_git))){
    flag <- TRUE
  }

  # check if there are tour updates
  tours_current <- spRingsteen::tours

  tours_git <- readr::read_csv('https://raw.githubusercontent.com/obrienjoey/springsteen_db/main/csv/tours.csv') %>%
    dplyr::rename(gig_key = .data$gig_url) %>%
    dplyr::filter(.data$gig_key %in% concerts_git$gig_key)

  if(!(base::identical(tours_current, tours_git))){
    flag <- TRUE
  }

  if(flag){
    q <- base::tolower(base::readline("Updates are available on the spRingsteen Dev version, do you want to update? n/Y"))

    if(q == "y" | q == "yes"){

      base::tryCatch(
        expr = {
          devtools::install_github("obrienjoey/spRingsteen")

          base::message("The data was refreshed, please restart your session to have the new data available")
        },
        error = function(e){
          base::message('Caught an error!')
          print(e)
        },
        warning = function(w){
          base::message('Caught an warning!')
          print(w)
        }

      )
    }
  } else {
    base::message("No updates are available")
  }
}
