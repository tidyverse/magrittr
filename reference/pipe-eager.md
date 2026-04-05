# Eager pipe

Whereas `%>%` is lazy and only evaluates the piped expressions when
needed, `%!>%` is eager and evaluates the piped input at each step. This
produces more intuitive behaviour when functions are called for their
side effects, such as displaying a message.

Note that you can also solve this by making your function strict. Call
[`force()`](https://rdrr.io/r/base/force.html) on the first argument in
your function to force sequential evaluation, even with the lazy `%>%`
pipe. See the examples section.

## Usage

``` r
lhs %!>% rhs
```

## Arguments

- lhs:

  A value or the magrittr placeholder.

- rhs:

  A function call using the magrittr semantics.

## Examples

``` r
f <- function(x) {
  message("foo")
  x
}
g <- function(x) {
  message("bar")
  x
}
h <- function(x) {
  message("baz")
  invisible(x)
}

# The following lazy pipe sequence is equivalent to `h(g(f()))`.
# Given R's lazy evaluation behaviour,`f()` and `g()` are lazily
# evaluated when `h()` is already running. This causes the messages
# to appear in reverse order:
NULL %>% f() %>% g() %>% h()
#> baz
#> bar
#> foo

# Use the eager pipe to fix this:
NULL %!>% f() %!>% g() %!>% h()
#> foo
#> bar
#> baz

# Or fix this by calling `force()` on the function arguments
f <- function(x) {
  force(x)
  message("foo")
  x
}
g <- function(x) {
  force(x)
  message("bar")
  x
}
h <- function(x) {
  force(x)
  message("baz")
  invisible(x)
}

# With strict functions, the arguments are evaluated sequentially
NULL %>% f() %>% g() %>% h()
#> foo
#> bar
#> baz

# Instead of forcing, you can also check the type of your functions.
# Type-checking also has the effect of making your function lazy.
```
