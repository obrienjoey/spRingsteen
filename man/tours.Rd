% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tours.R
\docType{data}
\name{tours}
\alias{tours}
\title{Tour information for concerts in the spRingsteen dataset.}
\format{
A data frame with 2 variables:
\describe{
 \item{gig_key}{Primary key of the data frame.}
 \item{tour}{Tour associated with the concert. Note some concerts have more
 than one tour associated with them.}
 }
}
\source{
\url{http://brucebase.wikidot.com/}
}
\usage{
tours
}
\description{
Data describing the tours associated with concerts played by Bruce
Springsteen both solo and with numerous bands from the years 1973 to present day.
Note that concerts prior to 1973 and non-tour, e.g., practice shows,
promotion shows, have been removed. Furthermore some of the shows are
associated with more than one tour as such some of the entries from
\code{\link{concerts}} appear twice. Can be joined with \code{\link{setlists}}
or \code{\link{concerts}} using \code{gig_key}.
}
\examples{
library(dplyr)
# How many shows were on each tour?

tours \%>\%
  count(tour, sort = TRUE)

}
\keyword{datasets}
