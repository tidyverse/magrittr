\name{\%>\%}
\alias{\%<<\%}
\alias{\%<\%}
\alias{\%>>\%}
\alias{\%>\%}
\title{Pipe an object forward into a function call/expression.}
\usage{
e1 \%>\% e2

e1 \%<\% e2

e1 \%<<\% e2

e1 \%>>\% e2
}
\arguments{
  \item{e1}{the object to be piped forward}

  \item{e2}{an expression which expects an object from the
  pipe.}
}
\description{
The \code{\%>\%} operator pipes the left-hand side into an
expression on the right-hand side. The \code{\%<\%}
operator does the reverse. The expression can contain a
\code{.} as placeholder to indicate the position taken by
the object in the pipeline. If not present, it will be
squeezed in as the first argument. If the right-hand side
expression is a function call that takes only one argument,
one can omit both parentheses and the \code{.}. The
\code{\%>>\%} and \code{\%<<\%} versions replaces the
\code{.} with \code{..} to allow for expressions with that
includes a \code{.}, e.g. a formula.
}
\examples{
\dontrun{
iris \%>\%
  where(Petal.Length > 5) \%>\%
  delete(Species) \%>\%
  colMeans

iris \%>>\%
  aggregate(. ~ Species, .., mean)

rnorm(1000) \%>\% abs \%>\% sum
}
}

