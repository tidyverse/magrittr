\name{where}
\alias{where}
\title{Filter a data.frame based on conditions.
Equivalent to using the \code{data.frame[restriction ,]} syntax.}
\usage{
where(unrestricted, restriction)
}
\arguments{
  \item{unrestricted}{The data.frame to filter.}

  \item{restriction}{The restriction to apply.}
}
\value{
a data.frame with rows for which the restriction evaluates
to TRUE.
}
\description{
Filter a data.frame based on conditions. Equivalent to
using the \code{data.frame[restriction ,]} syntax.
}
\examples{
\dontrun{
 iris \%>\%
   where(Species == "virginica") \%>\%
   delete(Species) \%>\%
   colMeans
}
}

