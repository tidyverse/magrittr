# Extract function(s) from a functional sequence.

Functional sequences can be subset using single or double brackets. A
single-bracket subset results in a new functional sequence, and a
double-bracket subset results in a single function.

## Usage

``` r
# S3 method for class 'fseq'
x[[...]]

# S3 method for class 'fseq'
x[...]
```

## Arguments

- x:

  A functional sequence

- ...:

  index/indices. For double brackets, the index must be of length 1.

## Value

A function or functional sequence.
