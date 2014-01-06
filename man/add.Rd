\name{add}
\alias{add}
\title{Add columns to \code{data.frame}.}
\usage{
add(to, ...)
}
\arguments{
  \item{to}{The \code{data.frame} to add to.}

  \item{...}{The columns to add, can be expressions of
  existing columns.}
}
\value{
a \code{data.frame} with original and new columns.
}
\description{
Add columns to \code{data.frame}.
}
\examples{
\dontrun{
 iris \%>\%
   add(
     width = Sepal.Width,
     len   = Sepal.Length,
     ratio = Sepal.Width/Sepal.Length) \%>\%
   head
}
}

