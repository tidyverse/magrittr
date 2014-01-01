\name{rows}
\alias{rows}
\title{Select certain rows by indices and/or amount.}
\usage{
rows(data., from = NULL, to = NULL, take = NULL)
}
\arguments{
  \item{data.}{The \code{data.frame} to filter.}

  \item{from}{the starting index. Can alternatively be a
  vector, in which case the other arguments are ignored. If
  NULL and \code{to} is specified, this will be taken to be
  1.}

  \item{to}{The end index. Should not be specified if
  \code{from} is a vector, or \code{take} != NULL. If
  \code{to} is NULL and \code{from} is a number, then this
  will be taken to be \code{nrow(data.)}}

  \item{take}{if one of from and to is specified this is
  the amount of rows to take.}
}
\value{
a \code{data.frame} with the selected rows.
}
\description{
Given a data.frame and indices (and possibly an amount of
rows) a data.frame with a subset of rows is returned.
}
\examples{
\dontrun{
 iris \%>\%
   rows(140)

 iris \%>\%
   rows(to = 10)

 iris \%>\%
   rows(140, take = 3)

 iris \%>\%
   rows(to = 140, take = 3)

 iris \%>\%
   rows(seq(1, 10, 2))

 iris \%>\%
   rows(20:30)
}
}

