\name{partialize}
\alias{partialise}
\alias{partialize}
\title{Partialize a function call.}
\usage{
partialize(expr)
}
\arguments{
  \item{expr}{A partial function call.}
}
\description{
Specify a partial function based on an existing function
with a subset of the available parameters. Evaluation is
lazy and the prespecified aruments are evaluated when the
function is used as if they were set together with the
remaining arguments.

#'
}
\examples{
partial.lm <-
  partialize(lm(Sepal.Length ~ ., iris, na.action = na.fail)) \%>\%
  print

partial.lm(Species != "versicolor")

partial.plot <-
  partialize(plot(pch = 19, cex = 0.5, main = "Partialized Plot")) \%>\%
  print

partial.plot(runif(25), rnorm(25))
}

