\name{magrittr-package}
\alias{magrittr-package}
\alias{magrittr}
\docType{package}
\title{
magrittr - ceci n'est pas une pipe!
}
\description{
This package provides pipe-forwarding mechanisms similar to (but not exactly 
like) e.g. F#'s pipe-forward operator. It allows writing code in a sometimes
much more clean and readable way, and avoids making a mess in situations of 
multiple nested function calls. It is particularly useful when manipulating
data frames etc. The package also contains a few useful functions which 
fit well into the syntax allowed by the package.
}
\details{
\tabular{ll}{
Package: \tab magrittr\cr
Type: \tab Package\cr
Version: \tab 0.1.4\cr
Date: \tab 2014-01-01\cr
License: GPL\cr
}

The main feature is provided by the operator \code{\%>\%}. It takes a value
(e.g. a data.frame) on the left and a function expression on the right, see the
examples. One can use
a single dot, \code{`.`},  as a placeholder for the value on the left.
}

\author{
Stefan Milton Bache and Hadley Wickham

Maintainer: <stefan@stefanbache.dk>
}
\references{
This package is inspired by the pipe-forward mechanism in the .NET language
F# (Luca Bolognese has made an awesome video introduction to this language
which is highly recommended).
}

\keyword{ package }
\seealso{
  \code{\link{\%>\%}}
}
\examples{
  iris \%>\% summary
}
