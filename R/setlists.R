#' Metadata for setlists in the spRingsteen dataset.
#'
#' Metadata for the setlists of concerts played by Bruce Springsteen
#' both solo and with numerous bands from the years 1973 to 2021.
#'
#' @format A data frame with 52,100 rows and 4 variables:
#' \describe{
#'  \item{gig_key}{Key associated with the concert which the setlist is from.}
#'  \item{song_key}{Key associated with the song played.}
#'  \item{song}{Name of the song played.}
#'  \item{song_number}{Order of appearance for the song in the setlist.}
#'  }
#'
#' @examples
#' library(dplyr)
#' # what are the top five most played songs?
#'
#' setlists %>%
#'   count(song, sort = TRUE) %>%
#'   slice(1:5)
#'
#' # what is the average show length?
#'
#' setlists %>%
#'   count(gig_key) %>%
#'   summarise(ave_length = mean(n))
#'
#' @source \url{http://brucebase.wikidot.com/}
"setlists"
