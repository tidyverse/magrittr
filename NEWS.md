
# magrittr 1.5.0.9000

## Fast and lean implementation of the pipe

The pipe has been rewritten in C with the following goals in mind:

- Minimal performance cost.
- Minimal impact on backtraces.
- No impact on reference counts.

As part of this rewrite we have changed the behaviour of the pipe to
make it closer to the implementation that will likely be included in a
future version of R. The pipe now evaluates piped expressions lazily (#120).
The main consequence of this change is that warnings and errors can
now be handled by trailing pipe calls:

```{r}
stop("foo") %>% try()
warning("bar") %>% suppressWarnings()
```


## Bug fixes

* Piped arguments are now persistent. They can be evaluated after the
  pipeline has returned, which fixes subtle issues with function
  factories (#159, #195).


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
