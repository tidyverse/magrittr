\name{orderby}
\alias{orderby}
\title{Order a data frame by expressions of the columns.}
\usage{
orderby(unordered, ...)
}
\arguments{
  \item{unordered}{The data.frame to order.}

  \item{...}{expressions to order by (as in
  \code{\link{order}}).}
}
\value{
an ordered data.frame.
}
\description{
Order a data frame by expressions of the columns.
}
\examples{
\dontrun{
 iris \%>\%
   orderby(Species, Sepal.Length)
}
}

