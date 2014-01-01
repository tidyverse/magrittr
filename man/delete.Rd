\name{delete}
\alias{delete}
\title{Delete columns from data.frame.}
\usage{
delete(from, ...)
}
\arguments{
  \item{from}{The dataset to delete from.}

  \item{...}{The columns to delete}
}
\value{
a data.frame with the specified columns removed.
}
\description{
Delete columns from data.frame.
}
\examples{
\dontrun{
 iris \%>\%
   delete(Species) \%>\%
   colMeans
}
}

