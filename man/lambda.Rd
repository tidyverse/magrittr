\name{lambda}
\alias{l}
\alias{lambda}
\title{Shorthand notation for anonymous/lambda functions
in magrittr pipelines.}
\usage{
lambda(expr)

l(expr)
}
\arguments{
  \item{expr}{A special kind of expression for the
  anonymous function.  The syntax is \code{symbol ->
  expression}, see the examples.}
}
\value{
a function.
}
\description{
It is suggested to use this for anonymous functions when
composing chains with magrittr. It is shorter and has a
signature designed for the purpose (i.e. it takes a value
as the first argument to be fed into the function), and it
avoids the high precedence of the \code{function} keyword.
}
\details{
\code{lambda} has a special syntax, where the expression is
defined as \code{symbol -> expression}. The alias \code{l}
is shorthand for \code{lambda}.
}
\examples{
lambda(x -> x^2 + 2*x)

sapply(1:10, lambda(x -> x^2))

Filter((lambda(x -> x > 0)), rnorm(100))

iris \%>\%
  (lambda(dfr -> rbind(dfr \%>\% head, dfr \%>\% tail)))

1:10 \%>\%
  sin \%>\%
  (lambda(x -> {
    d <- abs(x) > 0.5
    x*d
  }))
}

