#' Data for all songs in the spRingsteen dataset.
#'
#' Data describing all songs which have been played by Bruce Springsteen both
#' solo and with numerous bands from the year 1973 to present day. Can be joined with
#' \code{\link{setlists}} using \code{song_key}.
#'
#' @format A data frame with 4 variables:
#' \describe{
#'  \item{song_key}{Primary key of the data frame.}
#'  \item{title}{Title of the song.}
#'  \item{lyrics}{Lyrics of the song if available in the database.}
#'  \item{album}{Name of the album on which the song appears if available in the
#'  database.}
#'  }
#'
#' @examples
#' library(dplyr)
#' # What are the most common albums?
#'
#' songs %>%
#'   filter(!is.na(album)) %>%
#'   count(album, sort = TRUE)
#'
#' # What word occurs most frequently in the lyrics from the album 'Born To Run'
#' library(tidytext)
#'
#' songs %>%
#'  filter(album == 'Born To Run') %>%
#'  select(title, lyrics) %>%
#'  unnest_tokens(word, lyrics) %>%
#'  count(word, sort = TRUE) %>%
#'  anti_join(stop_words, by = 'word')
#'
#' @source \url{http://brucebase.wikidot.com/}
"songs"
