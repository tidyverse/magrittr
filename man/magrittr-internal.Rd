\name{pipe}
\alias{pipe}
\alias{primitive_formals}
\title{Function to create a pipe operator.}
\usage{
pipe(tee = FALSE)

primitive_formals(f)
}
\arguments{
  \item{tee}{Either a logical or a function.}

  \item{f}{A primitive function. This function will throw
  an error if \code{f} is not primitive, or does not have a
  formal argument list. Examples of the latter is
  \code{`while`} and \code{`<-`}.}
}
\value{
When tee is FALSE a standard pipe operator is returned.
When tee is TRUE, a tee operator is returned, i.e. an
operaotr for which the rhs is used for the side-effect and
the left-hand side is returned.  When tee is a function,
the return value is a pipe where the function is attached
as a side-effect, i.e. it works like a pipe, but also
evaluates the function with the left-hand side as argument.

a pairlist with formal arguments.
}
\description{
Function to create a pipe operator.

An alternative to \code{formals}
}
\details{
This is not exported.

This is not exported.
}

