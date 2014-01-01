\name{where}
\alias{where}
\title{Filter a \code{data.frame} based on conditions (row-wise).}
\usage{
where(unrestricted, restriction)
}
\arguments{
  \item{unrestricted}{The \code{data.frame} to filter.}

  \item{restriction}{The restriction to apply.}
}
\value{
a \code{data.frame} with rows for which the restriction
evaluates to \code{TRUE}.
}
\description{
Equivalent to using the \code{data.frame[restriction ,]}
syntax.
}
\examples{
\dontrun{
 iris \%>\%
   where(Species == "virginica") \%>\%
   delete(Species) \%>\%
   colMeans
}
}

