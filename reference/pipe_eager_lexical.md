# Lazy and eager pipes

Assign these pipe variants to an infix symbol like `%>%`.

## Usage

``` r
pipe_eager_lexical(lhs, rhs)

pipe_lazy_masking(lhs, rhs)

pipe_nested(lhs, rhs)
```

## Arguments

- lhs:

  A value or the magrittr placeholder.

- rhs:

  A function call using the magrittr semantics.
