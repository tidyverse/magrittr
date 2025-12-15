# Assignment pipe

Pipe an object forward into a function or call expression and update the
`lhs` object with the resulting value.

## Usage

``` r
lhs %<>% rhs
```

## Arguments

- lhs:

  An object which serves both as the initial value and as target.

- rhs:

  a function call using the magrittr semantics.

## Details

The assignment pipe, `%<>%`, is used to update a value by first piping
it into one or more `rhs` expressions, and then assigning the result.
For example, `some_object %<>% foo %>% bar` is equivalent to
`some_object <- some_object %>% foo %>% bar`. It must be the first
pipe-operator in a chain, but otherwise it works like `%>%`.

## See also

`%>%`, `%T>%`,
[`%$%`](https://magrittr.tidyverse.org/dev/reference/exposition.md)

## Examples

``` r
iris$Sepal.Length %<>% sqrt

x <- rnorm(100)

x %<>% abs %>% sort

is_weekend <- function(day)
{
   # day could be e.g. character a valid representation
   day %<>% as.Date
   
   result <- day %>% format("%u") %>% as.numeric %>% is_greater_than(5)
   
   if (result)
     message(day %>% paste("is a weekend!"))
   else
     message(day %>% paste("is not a weekend!"))
   
   invisible(result)
}
```
