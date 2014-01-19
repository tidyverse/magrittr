\name{ofclass}
\alias{ofclass}
\title{Select columns of certain classes.}
\usage{
ofclass(data., ...)
}
\arguments{
  \item{data.}{The \code{data.frame} to filter.}

  \item{...}{classes to look for (unquoted)}
}
\value{
a \code{data.frame} with the selected classes
}
\description{
Given a \code{data.frame}, and a list of classes, a new
\code{data.frame} is returned with columns of these
classes. Can be useful for example to extract numeric
columns before passed to a function expecting numeric
input, e.g. colMeans.
}
\examples{
\dontrun{
 iris \%>\%
   ofclass(numeric) \%>\%
   colMeans

 # Maybe not what you'd expect...
 airquality \%>\%
   ofclass(numeric) \%>\%
   head

 # ... then try this...
 airquality \%>\%
   ofclass(integer, numeric) \%>\%
   head
}
}

