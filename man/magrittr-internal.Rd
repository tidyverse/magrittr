\name{pipe}
\alias{pipe}
\title{Function to create a pipe operator.}
\usage{
pipe(tee = FALSE)
}
\arguments{
  \item{tee}{Either a logical or a function.}
}
\value{
When tee is FALSE a standard pipe operator is returned.
When tee is TRUE, a tee operator is returned, i.e. an
operaotr for which the rhs is used for the side-effect and
the left-hand side is returned.  When tee is a function,
the return value is a pipe where the function is attached
as a side-effect, i.e. it works like a pipe, but also
evaluates the function with the left-hand side as argument.
}
\description{
Function to create a pipe operator.
}
\details{
This is not exported.
}

