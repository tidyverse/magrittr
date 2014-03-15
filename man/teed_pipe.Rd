\name{teed_pipe}
\alias{teed_pipe}
\title{Create a pipe operator with a fixed side-effect.}
\usage{
teed_pipe(fun)
}
\arguments{
  \item{fun}{a function which will be evaluated with
  left-hand side of a pipe expression as argument.}
}
\value{
a pipe operator with the attached side effect.
}
\description{
This is useful e.g. for logging each step in a pipeline.
}
\examples{
# Define a logging function
logger <- function(x)
  cat(as.character(Sys.time()), ":", nrow(x), "\\n")

# mask \%>\% with a version using the logger.
`\%>\%` <- teed_pipe(logger)

# Test it:
iris \%>\%
   subset(Species == "setosa") \%>\%
   subset(Sepal.Length > 5) \%>\%
   tail(10)

# Restore the original pipe:
rm(`\%>\%`)
}

