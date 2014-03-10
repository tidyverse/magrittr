\name{fun}
\alias{fun}
\title{Shorthand notation for anonymous functions
in magrittr pipelines.}
\usage{
fun(value, body, arg = NULL)
}
\arguments{
  \item{value}{the value to be fed into the function}

  \item{body}{the body of the anonymous function}

  \item{arg}{the name used to reference \code{value} in the
  function. Defaults to x.}
}
\description{
It is suggested to use this for anonymous functions when
composing chains with magrittr. It is shorter and has a
signature designed for the purpose (i.e. it takes a value
as the first argument to be fed into the function), and it
avoids the high precedence of the \code{function} keyword.
}
\examples{
iris \%>\%
  fun({ rbind(x \%>\% head, x \%>\% tail) })

iris \%>\%
  fun({ rbind(z \%>\% head, z \%>\% tail) }, z)

1:10 \%>\%
  sin \%>\%
  fun({d <- abs(x) > 0.5; x*d})
}

