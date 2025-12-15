# magrittr - Ceci n'est pas un pipe

The magrittr package offers a set of operators which promote semantics
that will improve your code by

- structuring sequences of data operations left-to-right (as opposed to
  from the inside and out),

- avoiding nested function calls,

- minimizing the need for local variables and function definitions, and

- making it easy to add steps anywhere in the sequence of operations.

The operators pipe their left-hand side values forward into expressions
that appear on the right-hand side, i.e. one can replace `f(x)` with
`x %>% f`, where `%>%` is the (main) pipe-operator.

## Details

Consider the example below. Four operations are performed to arrive at
the desired data set, and they are written in a natural order: the same
as the order of execution. Also, no temporary variables are needed. If
yet another operation is required, it is straight-forward to add to the
sequence of operations whereever it may be needed.

For a more detailed introduction see the vignette
([`vignette("magrittr")`](https://magrittr.tidyverse.org/dev/articles/magrittr.md))
or the documentation pages for the available operators:  

|                                                                     |                  |
|---------------------------------------------------------------------|------------------|
| `%>%`                                                               | pipe.            |
| `%T>%`                                                              | tee pipe.        |
| `%<>%`                                                              | assignment pipe. |
| [`%$%`](https://magrittr.tidyverse.org/dev/reference/exposition.md) | exposition pipe. |

## See also

Useful links:

- <https://magrittr.tidyverse.org>

- <https://github.com/tidyverse/magrittr>

- Report bugs at <https://github.com/tidyverse/magrittr/issues>

## Author

**Maintainer**: Lionel Henry <lionel@posit.co>

Authors:

- Stefan Milton Bache <stefan@stefanbache.dk> (Original author and
  creator of magrittr) \[copyright holder\]

- Hadley Wickham <hadley@posit.co>

Other contributors:

- Posit Software, PBC ([ROR](https://ror.org/03wc8by49)) \[copyright
  holder, funder\]

## Examples

``` r
if (FALSE) { # \dontrun{

the_data <-
  read.csv('/path/to/data/file.csv') %>%
  subset(variable_a > x) %>%
  transform(variable_c = variable_a/variable_b) %>%
  head(100)
} # }
```
