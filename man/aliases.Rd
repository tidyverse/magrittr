\name{extract}
\alias{add}
\alias{and}
\alias{divide_by}
\alias{divide_by_int}
\alias{equals}
\alias{extract}
\alias{extract2}
\alias{is_greater_than}
\alias{is_less_than}
\alias{is_weakly_greater_than}
\alias{is_weakly_less_than}
\alias{mod}
\alias{multiply_by}
\alias{multiply_by_matrix}
\alias{or}
\alias{raise_to_power}
\alias{subtract}
\alias{use_series}
\title{Aliases}
\description{
magrittr provides a series of aliases which can be more
pleasant to use when composing chains using the
\code{\%>\%} operator.
}
\details{
Currently implemented aliases are \tabular{ll}{
\code{extract} \tab \code{`[`} \cr \code{extract2} \tab
\code{`[[`} \cr \code{use_series} \tab \code{`$`} \cr
\code{add} \tab \code{`+`} \cr \code{subtract} \tab
\code{`-`} \cr \code{myltiply_by} \tab \code{`*`} \cr
\code{raise_to_power} \tab \code{`^`} \cr
\code{multiply_by_matrix} \tab \code{`\%*\%`} \cr
\code{divide_by} \tab \code{`/`} \cr \code{divide_by_int}
\tab \code{`\%/\%`} \cr \code{mod} \tab \code{`\%\%`} \cr
\code{and} \tab \code{`&`} \cr \code{or} \tab \code{`|`}
\cr \code{equals} \tab \code{`==`} \cr
\code{is_greater_than} \tab \code{`>`} \cr
\code{is_weakly_greater_than} \tab \code{`>=`} \cr
\code{is_less_than} \tab \code{`<`} \cr
\code{is_weakly_less_than} \tab \code{`<=`} \cr }
}
\examples{
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
  use_series(timestamp) \%>\%
  format("\%M") \%>\%
  as.numeric \%>\%
  divide_by_int(15) \%>\%
  add(1)
}

