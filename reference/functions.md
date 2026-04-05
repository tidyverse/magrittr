# Extract the function list from a functional sequence.

This can be used to extract the list of functions inside a functional
sequence created with a chain like `. %>% foo %>% bar`.

## Usage

``` r
functions(fseq)
```

## Arguments

- fseq:

  A functional sequence ala magrittr.

## Value

a list of functions
