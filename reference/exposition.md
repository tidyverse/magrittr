# Exposition pipe

Expose the names in `lhs` to the `rhs` expression. This is useful when
functions do not have a built-in data argument.

## Usage

``` r
lhs %$% rhs
```

## Arguments

- lhs:

  A list, environment, or a data.frame.

- rhs:

  An expression where the names in lhs is available.

## Details

Some functions, e.g. `lm` and `aggregate`, have a data argument, which
allows the direct use of names inside the data as part of the call. This
operator exposes the contents of the left-hand side object to the
expression on the right to give a similar benefit, see the examples.

## See also

`%>%`, `%<>%`, `%T>%`

## Examples

``` r
iris %>%
  subset(Sepal.Length > mean(Sepal.Length)) %$%
  cor(Sepal.Length, Sepal.Width)
#> [1] 0.3361992
  
data.frame(z = rnorm(100)) %$% 
  ts.plot(z)

  
```
