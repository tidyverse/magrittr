\name{orderby}
\alias{orderby}
\title{Order a \code{data.frame} by expressions of the columns.}
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
This function uses the \code{order} function, so any
expression which works with \code{order} will work with
\code{orderby}.
}
\examples{
\dontrun{
 iris \%>\%
   orderby(Species, Sepal.Length)

 mtcars \%>\%
   where(mpg > 18) \%>\%
   orderby(cyl, -hp)
}
}

