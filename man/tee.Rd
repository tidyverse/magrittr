\name{\%T>\%}
\alias{\%T>\%}
\title{Pipe a result into an expression for its side-effect.}
\usage{
lhs \%T>\% rhs
}
\arguments{
  \item{lhs}{That which is to be piped}

  \item{rhs}{a function call used for its side effect.}
}
\value{
lhs
}
\description{
Like \code{\%>\%} where the right-hand side is used for its
side-effect. The left-hand side is then passed along for
further processing. This can be useful, e.g. for logging
certain steps in a chain.
}
\examples{
1:10 \%T>\%
   lambda(x -> cat("LHS:", x, "\\n")) \%>\%
   multiply_by(2)
}

