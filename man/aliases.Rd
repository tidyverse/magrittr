\name{extract}
\alias{Extract}
\alias{divide}
\alias{extract}
\alias{int.divide}
\alias{minus}
\alias{multiply}
\alias{plus}
\alias{series}
\alias{times}
\title{Aliases}
\description{
magrittr provides a series of aliases which can be more
pleasant to use when composing chains using the %>%
operator.
}
\details{
Currently implemented aliases are \tabular{ll}{
\code{extract:} \tab \code{`[`} \cr \code{Extract:} \tab
\code{`[[`} \cr \code{series:} \tab \code{`$`} \cr
\code{plus:} \tab \code{`+`} \cr \code{minus:} \tab
\code{`-`} \cr \code{times:} \tab \code{`*`} \cr
\code{multiply:} \tab \code{`\%*\%`} \cr \code{divide:}
\tab \code{`/`} \cr \code{int.divide:} \tab \code{`\%/\%`}
\cr \code{`\%.\%`} \tab \code{`\%>\%`} \cr }
}
\examples{
\dontrun{
 iris \%>\%
   extract(, 1:4) \%>\%
   head

good.times <-
  Sys.Date() \%>\%
  as.POSIXct \%>\%
  seq(by = "15 mins", length.out = 100) \%>\%
  data.frame(timestamp = .)

good.times$quarter <-
  good.times \%>\%
  series(timestamp) \%>\%
  format("\%M") \%>\%
  as.numeric \%>\%
  int.divide(15) \%>\%
  plus(1)
}
}

