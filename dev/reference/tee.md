# Tee pipe

Pipe a value forward into a function- or call expression and return the
original value instead of the result. This is useful when an expression
is used for its side-effect, say plotting or printing.

## Usage

``` r
lhs %T>% rhs
```

## Arguments

- lhs:

  A value or the magrittr placeholder.

- rhs:

  A function call using the magrittr semantics.

## Details

The tee pipe works like `%>%`, except the return value is `lhs` itself,
and not the result of `rhs` function/expression.

## See also

`%>%`, `%<>%`,
[`%$%`](https://magrittr.tidyverse.org/dev/reference/exposition.md)

## Examples

``` r
rnorm(200) %>%
matrix(ncol = 2) %T>%
plot %>% # plot usually does not return anything. 
colSums

#> [1] -17.133206   5.507542
```
