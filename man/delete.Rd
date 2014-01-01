\name{delete}
\alias{delete}
\title{Delete columns from \code{data.frame}.}
\usage{
delete(from, ...)
}
\arguments{
  \item{from}{The \code{data.frame} to delete from.}

  \item{...}{The columns to delete}
}
\value{
a \code{data.frame} with the specified columns removed.
}
\description{
Delete columns from \code{data.frame}.
}
\examples{
\dontrun{
 iris \%>\%
   delete(Species) \%>\%
   colMeans
}
}

