# Aliases

magrittr provides a series of aliases which can be more pleasant to use
when composing chains using the `%>%` operator.

## Details

Currently implemented aliases are

|                           |                      |
|---------------------------|----------------------|
| `extract`                 | `` `[` ``            |
| `extract2`                | `` `[[` ``           |
| `inset`                   | `` `[<-` ``          |
| `inset2`                  | `` `[[<-` ``         |
| `use_series`              | `` `$` ``            |
| `add`                     | `` `+` ``            |
| `subtract`                | `` `-` ``            |
| `multiply_by`             | `` `*` ``            |
| `raise_to_power`          | `` `^` ``            |
| `multiply_by_matrix`      | `` `%*%` ``          |
| `divide_by`               | `` `/` ``            |
| `divide_by_int`           | `` `%/%` ``          |
| `mod`                     | `` `%%` ``           |
| `is_in`                   | `` `%in%` ``         |
| `and`                     | `` `&` ``            |
| `or`                      | `` `|` ``            |
| `equals`                  | `` `==` ``           |
| `is_greater_than`         | `` `>` ``            |
| `is_weakly_greater_than`  | `` `>=` ``           |
| `is_less_than`            | `` `<` ``            |
| `is_weakly_less_than`     | `` `<=` ``           |
| `not` (`` `n'est pas` ``) | `` `!` ``            |
| `set_colnames`            | `` `colnames<-` ``   |
| `set_rownames`            | `` `rownames<-` ``   |
| `set_names`               | `` `names<-` ``      |
| `set_class`               | `` `class<-` ``      |
| `set_attributes`          | `` `attributes<-` `` |
| `set_attr `               | `` `attr<-` ``       |

## Examples

``` r
 iris %>%
   extract(, 1:4) %>%
   head
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width
#> 1          5.1         3.5          1.4         0.2
#> 2          4.9         3.0          1.4         0.2
#> 3          4.7         3.2          1.3         0.2
#> 4          4.6         3.1          1.5         0.2
#> 5          5.0         3.6          1.4         0.2
#> 6          5.4         3.9          1.7         0.4

good.times <-
  Sys.Date() %>%
  as.POSIXct %>%
  seq(by = "15 mins", length.out = 100) %>%
  data.frame(timestamp = .)

good.times$quarter <-
  good.times %>%
  use_series(timestamp) %>%
  format("%M") %>%
  as.numeric %>%
  divide_by_int(15) %>%
  add(1)
```
