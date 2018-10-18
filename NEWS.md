# magrittr 1.5.0.9000

# magrittr 1.5

## New features

### Functional sequences.
A pipeline, or a "functional sequence", need not be applied
to a left-hand side value instantly. Instead it can serve as
a function definition. A pipeline where the left-most left-hand
side is the magrittr placeholder (the dot `.`) will thus create a
function, which applies each right-hand side in sequence to its
argument, e.g. `f <- . %>% abs %>% mean(na.rm = TRUE)`.

### New operators
Three new operators are introduced for some special cases

* Assignment pipe: `%<>%`
* Tee pipe: `%T>%`
* Exposition pipe: `%$%`

For more information see the documentation, e.g. `?%T>%`.

### Lambdas
Lambdas can now be made by enclosing several statements in curly braces,
and is a unary function of the dot argument.

For more information and examples, see the updated vignette, and help files.
