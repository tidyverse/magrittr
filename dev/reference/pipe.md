# Pipe

Pipe an object forward into a function or call expression.

## Usage

``` r
lhs %>% rhs
```

## Arguments

- lhs:

  A value or the magrittr placeholder.

- rhs:

  A function call using the magrittr semantics.

## Details

### Using `%>%` with unary function calls

When functions require only one argument, `x %>% f` is equivalent to
`f(x)` (not exactly equivalent; see technical note below.)

### Placing `lhs` as the first argument in `rhs` call

The default behavior of `%>%` when multiple arguments are required in
the `rhs` call, is to place `lhs` as the first argument, i.e.
`x %>% f(y)` is equivalent to `f(x, y)`.

### Placing `lhs` elsewhere in `rhs` call

Often you will want `lhs` to the `rhs` call at another position than the
first. For this purpose you can use the dot (`.`) as placeholder. For
example, `y %>% f(x, .)` is equivalent to `f(x, y)` and
`z %>% f(x, y, arg = .)` is equivalent to `f(x, y, arg = z)`.

### Using the dot for secondary purposes

Often, some attribute or property of `lhs` is desired in the `rhs` call
in addition to the value of `lhs` itself, e.g. the number of rows or
columns. It is perfectly valid to use the dot placeholder several times
in the `rhs` call, but by design the behavior is slightly different when
using it inside nested function calls. In particular, if the placeholder
is only used in a nested function call, `lhs` will also be placed as the
first argument! The reason for this is that in most use-cases this
produces the most readable code. For example,
`iris %>% subset(1:nrow(.) %% 2 == 0)` is equivalent to
`iris %>% subset(., 1:nrow(.) %% 2 == 0)` but slightly more compact. It
is possible to overrule this behavior by enclosing the `rhs` in braces.
For example, `1:10 %>% {c(min(.), max(.))}` is equivalent to
`c(min(1:10), max(1:10))`.

### Using `%>%` with call- or function-producing `rhs`

It is possible to force evaluation of `rhs` before the piping of `lhs`
takes place. This is useful when `rhs` produces the relevant call or
function. To evaluate `rhs` first, enclose it in parentheses, i.e.
`a %>% (function(x) x^2)`, and `1:10 %>% (call("sum"))`. Another example
where this is relevant is for reference class methods which are accessed
using the `$` operator, where one would do `x %>% (rc$f)`, and not
`x %>% rc$f`.

### Using lambda expressions with `%>%`

Each `rhs` is essentially a one-expression body of a unary function.
Therefore defining lambdas in magrittr is very natural, and as the
definitions of regular functions: if more than a single expression is
needed one encloses the body in a pair of braces, `{ rhs }`. However,
note that within braces there are no "first-argument rule": it will be
exactly like writing a unary function where the argument name is "`.`"
(the dot).

### Using the dot-place holder as `lhs`

When the dot is used as `lhs`, the result will be a functional sequence,
i.e. a function which applies the entire chain of right-hand sides in
turn to its input. See the examples.

## Technical notes

The magrittr pipe operators use non-standard evaluation. They capture
their inputs and examines them to figure out how to proceed. First a
function is produced from all of the individual right-hand side
expressions, and then the result is obtained by applying this function
to the left-hand side. For most purposes, one can disregard the subtle
aspects of magrittr's evaluation, but some functions may capture their
calling environment, and thus using the operators will not be exactly
equivalent to the "standard call" without pipe-operators.

Another note is that special attention is advised when using
non-magrittr operators in a pipe-chain (`+, -, $,` etc.), as operator
precedence will impact how the chain is evaluated. In general it is
advised to use the aliases provided by magrittr.

## See also

`%<>%`, `%T>%`,
[`%$%`](https://magrittr.tidyverse.org/dev/reference/exposition.md)

## Examples

``` r
# Basic use:
iris %>% head
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#> 1          5.1         3.5          1.4         0.2  setosa
#> 2          4.9         3.0          1.4         0.2  setosa
#> 3          4.7         3.2          1.3         0.2  setosa
#> 4          4.6         3.1          1.5         0.2  setosa
#> 5          5.0         3.6          1.4         0.2  setosa
#> 6          5.4         3.9          1.7         0.4  setosa

# Use with lhs as first argument
iris %>% head(10)
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#> 1           5.1         3.5          1.4         0.2  setosa
#> 2           4.9         3.0          1.4         0.2  setosa
#> 3           4.7         3.2          1.3         0.2  setosa
#> 4           4.6         3.1          1.5         0.2  setosa
#> 5           5.0         3.6          1.4         0.2  setosa
#> 6           5.4         3.9          1.7         0.4  setosa
#> 7           4.6         3.4          1.4         0.3  setosa
#> 8           5.0         3.4          1.5         0.2  setosa
#> 9           4.4         2.9          1.4         0.2  setosa
#> 10          4.9         3.1          1.5         0.1  setosa

# Using the dot place-holder
"Ceci n'est pas une pipe" %>% gsub("une", "un", .)
#> [1] "Ceci n'est pas un pipe"
  
# When dot is nested, lhs is still placed first:
sample(1:10) %>% paste0(LETTERS[.])
#>  [1] "1A"  "10J" "9I"  "4D"  "2B"  "3C"  "6F"  "5E"  "7G"  "8H" 

# This can be avoided:
rnorm(100) %>% {c(min(.), mean(.), max(.))} %>% floor
#> [1] -3  0  2

# Lambda expressions: 
iris %>%
{
  size <- sample(1:10, size = 1)
  rbind(head(., size), tail(., size))
}
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
#> 1            5.1         3.5          1.4         0.2    setosa
#> 2            4.9         3.0          1.4         0.2    setosa
#> 3            4.7         3.2          1.3         0.2    setosa
#> 4            4.6         3.1          1.5         0.2    setosa
#> 5            5.0         3.6          1.4         0.2    setosa
#> 6            5.4         3.9          1.7         0.4    setosa
#> 7            4.6         3.4          1.4         0.3    setosa
#> 144          6.8         3.2          5.9         2.3 virginica
#> 145          6.7         3.3          5.7         2.5 virginica
#> 146          6.7         3.0          5.2         2.3 virginica
#> 147          6.3         2.5          5.0         1.9 virginica
#> 148          6.5         3.0          5.2         2.0 virginica
#> 149          6.2         3.4          5.4         2.3 virginica
#> 150          5.9         3.0          5.1         1.8 virginica

# renaming in lambdas:
iris %>%
{
  my_data <- .
  size <- sample(1:10, size = 1)
  rbind(head(my_data, size), tail(my_data, size))
}
#>     Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
#> 1            5.1         3.5          1.4         0.2    setosa
#> 2            4.9         3.0          1.4         0.2    setosa
#> 3            4.7         3.2          1.3         0.2    setosa
#> 4            4.6         3.1          1.5         0.2    setosa
#> 5            5.0         3.6          1.4         0.2    setosa
#> 146          6.7         3.0          5.2         2.3 virginica
#> 147          6.3         2.5          5.0         1.9 virginica
#> 148          6.5         3.0          5.2         2.0 virginica
#> 149          6.2         3.4          5.4         2.3 virginica
#> 150          5.9         3.0          5.1         1.8 virginica

# Building unary functions with %>%
trig_fest <- . %>% tan %>% cos %>% sin

1:10 %>% trig_fest
#>  [1]  0.0133878 -0.5449592  0.8359477  0.3906486 -0.8257855  0.8180174
#>  [7]  0.6001744  0.7640323  0.7829771  0.7153150
trig_fest(1:10)
#>  [1]  0.0133878 -0.5449592  0.8359477  0.3906486 -0.8257855  0.8180174
#>  [7]  0.6001744  0.7640323  0.7829771  0.7153150
```
