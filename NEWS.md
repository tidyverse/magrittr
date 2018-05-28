# magrittr 2.0.0
TODO: document changes.

* Aliases are removed. They are simple to implement where needed, and polluting the
  namespace with very common names is not ideal. This will let people use `library`
  with more confidence.
* Pipeline functions are no longer of class "fseq" and the related S3 functionality
  has been removed. This functionality was rarely seen used in practice, and the
  added complexity is not considered justified.

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

* Compound assignment pipe: `%<>%`
* Tee pipe: `%T>%`
* Exposition pipe: `%$%`

For more information see the documentation, e.g. `?%T>%`.

### Lambdas
Lambdas can now be made by enclosing several statements in curly braces,
and is a unary function of the dot argument.

For more information and examples, see the updated vignette, and help files.

