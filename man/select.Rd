\name{select}
\alias{select}
\title{Select columns from \code{data.frame}, define new columns, or rename columns.}
\usage{
select(from, ...)
}
\arguments{
  \item{from}{The \code{data.frame} to select from.}

  \item{...}{The columns to select, define, or rename.}
}
\value{
a \code{data.frame} with the specified columns.
}
\description{
Select columns from \code{data.frame}, define new columns,
or rename columns.
}
\examples{
\dontrun{
 iris \%>\%
   select(
     width = Sepal.Width,
     len   = Sepal.Length,
     ratio = Sepal.Width/Sepal.Length) \%>\%
   head
}
}

