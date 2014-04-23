\name{debug_pipe}
\alias{debug_pipe}
\title{Place a debug browser in a chain of commands.}
\usage{
debug_pipe(x)
}
\arguments{
  \item{x}{A value.}
}
\value{
returns the argument \code{x}.
}
\description{
When using magrittr's piping syntax, it can be useful to be
able to debug at certain steps in a chain. This is a simple
wrapper around \code{browser} for this purpose.
}
\examples{
iris \%>\%
  debug_pipe \%>\%
  head
}

