
# magrittr 1.5.0.9000

## Fast and lean implementation of the pipe

The pipe has been rewritten in C.

- Minimal performance cost.
- Minimal impact on backtraces.
- No impact on reference counts.

As part of this rewrite we have slightly changed the behaviour of the
pipe so that the piped expressions are now evaluated in the current
environment. Previously, the pipe evaluated in its own private
environment where `.` was defined. This is technically a breaking
change, but this should only affect very specific corner cases and it
brings the behaviour of the pipe closer to other control flow
mechanisms like `if ()` or `for ()` which also evaluate in the current
environment. This also brings it closer to the probable semantics of
the native R pipe that is likely to be introduced in the next version
of R. The most visible consequences of this new behaviour are:

- `parent.frame()` now returns the same environment in piped and
  non-piped evaluation (#146, #171).

- `return()` returns from the enclosing function. It would previously
  return from the current pipe expression and continue evaluation from
  there.


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
