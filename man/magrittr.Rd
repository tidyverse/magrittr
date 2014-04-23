\docType{package}
\name{magrittr}
\alias{magrittr}
\alias{magrittr-package}
\title{magrittr - a forward-pipe operator for R}
\description{
This package provides pipe-forwarding mechanisms similar to
(but not exactly like) e.g. F#'s pipe-forward operator. It
allows writing code in a sometimes much more clean and
readable way, and avoids making a mess in situations of
multiple nested function calls. It is particularly useful
when manipulating data frames etc. The package also
contains useful functions which fit well into the syntax
allowed by the package. For a brief introduction, see
\code{vignette("magrittr")}.
}
\details{
\tabular{ll}{ Package: \tab magrittr\cr Type: \tab
Package\cr Version: \tab 1.1.0\cr Date: \tab 2014-01-01\cr
License: \tab MIT\cr } The main feature is provided by the
operator \code{\%>\%}. It takes a value (e.g. a data.frame)
on the left and a function expression on the right, see the
examples. One can use a single dot, \code{`.`}, as a
placeholder for the value on the left.
}
\author{
Stefan Milton Bache and Hadley Wickham.

Maintainer: Stefan Holst Milton Bache
<stefan[at]stefanbache.dk>
}

