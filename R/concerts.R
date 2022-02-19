#' Metadata for concerts in the spRingsteen dataset.
#'
#' Metadata for concerts played by Bruce Springsteen both solo and
#' with numerous bands from the years 1973 to 2021. Can be joined with
#' \code{\link{setlists}} using \code{gig_key}.
#'
#' @format A data frame with 2,930 rows and 6 variables:
#' \describe{
#'  \item{gig_key}{primrary key of the data frame.}
#'  \item{date}{date of the concert.}
#'  \item{location}{full location of concert including venue name.}
#'  \item{state}{state concert was performed in (if in USA).}
#'  \item{city}{city concert was performed in (if not in USA).}
#'  \item{country}{country concert was performed in.}
#'  }
#'
#' @examples
#'
#' library(dplyr)
#' # What countries have been played in the most?
#'
#' concerts %>%
#'   count(country, sort = TRUE)
#'
#' # What decade did most shows take place in?
#'
#' library(lubridate)
#'
#' concerts %>%
#'   select(date) %>%
#'   mutate(decade = (year(date) %/% 10) * 10) %>%
#'   count(decade)
#'
#' @seealso \url{http://brucebase.wikidot.com/}
"concerts"
