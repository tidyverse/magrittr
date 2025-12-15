# Apply a list of functions sequentially

This function applies the first function to `value`, then the next
function to the result of the previous function call, etc.

## Usage

``` r
freduce(value, function_list)
```

## Arguments

- value:

  initial value.

- function_list:

  a list of functions.

## Value

The result after applying each function in turn.
