\name{\%>\%}
\alias{\%>\%}
\title{Pipe an object forward into a function call/expression.}
\usage{
lhs \%>\% rhs
}
\arguments{
  \item{lhs}{That which is to be piped}

  \item{rhs}{the pipe to be stuffed with tobacco.}
}
\description{
The \code{\%>\%} operator pipes the left-hand side into an
expression on the right-hand side. The expression can
contain a \code{.} as placeholder to indicate the position
taken by the object in the pipeline. If not present, it
will be squeezed in as the first argument. If the
right-hand side expression is a function call that takes
only one argument, one can omit parentheses and the
\code{.}. Only the outmost call is matched against the dot,
which means that e.g. formulas can still use a dot which
will not be matched. Nested functions will not be matched
either.
}
\examples{
\dontrun{
library(dplyr)
library(Lahman)

Batting \%>\%
  group_by(playerID) \%>\%
  summarise(total = sum(G)) \%>\%
  arrange(desc(total)) \%>\%
  head(5)


iris \%>\%
  filter(Petal.Length > 5) \%>\%
  select(-Species) \%>\%
  colMeans

iris \%>\%
  aggregate(. ~ Species, ., mean)

rnorm(1000) \%>\% abs \%>\% sum
}
}

