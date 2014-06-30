magrittr -  Ceci n'est pas un pipe.
====================================

[![Build Status](https://travis-ci.org/smbache/magrittr.png?branch=dev)](https://travis-ci.org/smbache/magrittr)

Make your code smokin' with magrittr's pipe operator.
The pipe-forwarding mechanism provided is similar to (but not exactly 
like) e.g. F#'s pipe-forward operator. It allows you to write code in a 
much more clean and readable way, and you will avoid making a mess 
in situations of multiple nested function calls. 
It is particularly useful when manipulating data frames etc. 
The package also contains a few useful features and aliases that
fit well into the syntax advocated by the package.
To learn more, see the included vignette.

This branch is a development version with the following differences from the current
CRAN release:

* a lambda syntax as an alternative to the usual anonymous function definitions. 
  These are of the form `lambda(x ~ x^2 + 2*x)` or shorter: `l(x ~ x^2 + 2*x)`.
  Note this is different from other branches using `->` syntax, but that will 
  give rise to R CMD check to fail. While the latter had a nice math syntax 
  analogue, the `~` syntax is more R-like.

* A compound assignment operator, `:=`. This is short-hand for modifying a 
  value and assigning its original name to it, i.e. `a := b` is equivalent to `a <- a %>% b`.

  **NB**. *Since `:=` is used extensively elsewhere, another alternative approach is being tested, 
  currently using the operator name `%<>%`. Since precedence of this kind of operator is different, 
  it works fundamentally different, but usage should be the same.*

* a tee operator, `%T>%`, which is like `%>%` but which only uses the right-hand side
  for its side-effect, i.e. `x %T>% f` will evaluate `f(x)` and return `x`.

* Using anonymous functions not enclosed in parentheses have been 
  deprecated for consistency, i.e. `a %>% function(x) ...` will give a warning. 
  The "new" way is `a %>% (function(x) ...)`. Using parens will evaluate the right-hand
  side before piping, and can also be useful for functions generating a call.

* Using "`.`" in nested calls in the right-hand side is now possible, but nested dots 
  do not act like first-level dots: they do not count for deciding whether lhs is placed 
  first, i.e. `1:10 %>% rep(I(.))` is equivalent to `1:10 %>% rep(., I(.))`.
  Furthermore, magrittr will not try to book-keep the call at nested levels. As an 
  example, `1:10 %>% plot(., col = .)` will have "`1:10`" as label, while
  `1:10 %>% plot(I(.), col = .)` has "`I(.)`" as label. The primary use of nested `.` is
  to use some attribute, say number of rows or columns, without having to make a lambda.
  Lastly, note that formulas using `.` still work.

* Tests for the above have been added to the test suite.



Installation:
-------------

    library(devtools)
    install_github("smbache/magrittr")

Alternatively, you can install the current CRAN release:

    install.packages("magrittr")
    

Help overview:
--------------

    help(package = magrittr)

Examples of usage:
------

    # In many of the following examples we make use of the dplyr package
    # which provides many useful data manipulating functions.
    library(dplyr)

    # Use without placeholder.
    iris %>%
      filter(Species == "virginica") %>%
      select(-Species) %>%
      colMeans
      
    # Another example  
    iris %>%
      mutate(len   = Sepal.Length, 
             width = Sepal.Width, 
             ratio = Sepal.Length/Sepal.Length) %>%
      select(len, width, ratio) %>%
      head
       
    # This is equivalent to the first example. The dot can be used to specify
    # where the values are piped...
    iris %>%
      filter(., Species == "virginica") %>%
      select(., -Species) %>%
      colMeans
       
    # The batting example:
    library(Lahman)
     
    Batting %>%
      group_by(playerID) %>%
      summarise(total = sum(G)) %>%
      arrange(desc(total)) %>%
      head(5)
        
    # This will work although a dot is in the formula. 
    # Only the "outmost" call is matched against the dot.
    iris %>%
      aggregate(. ~ Species, ., mean)
       
    # If a function only takes one argument, you can omit the 
    # parentheses.
    rnorm(100) %>% abs %>% mean
       
    # Of course, all the usual regular functions are compatible:
    iris %>%
      select(-Species) %>%
      apply(2, max)
    
    iris %>% head(10)

    # Example involving a few aliased operators:
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

    # Calls are preserved when possible:
    fit <- 
      iris %>%
      lm(Sepal.Length ~ ., .)
       
    new.fit <- 
      fit %>%
      update(. ~ . - Species)

    # lambda expression
	1:10 %>% lambda(x ~ x^2 + 2*x)

	# short-hand notation
    1:10 %>% l(x ~ x^2 + 2*x)

	# For longer expressions:
    iris %>% l(x ~ {
       fit <- lm(Sepal.Length ~ ., x)
	   fit %>% residuals %>% abs %>% mean
    })

    # Lambdas also work in other contexts:
	Filter(l(x ~ x[x > 0]), rnorm(100))
    
    1:10 %>% 
      sapply(l(i ~ if (i %% 2) i^2 else NULL))  %>% 
      unlist
      
	# regular anonymous functions, and call-generating functions can
    # be used too:
    1:10 %>%
      (function(x) x^2)

    x <- 4:6
	1:10 %>% (call("sum", x))


    # Tee operator returns the left-hand side, after applying the
    # right-hand side:
	rnorm(100) %T>%
	  plot(type = "l", col = "firebrick") %>%
      abs %>%
      sum

    # Compound assignment
    tmp <- iris

    tmp :=
      subset(Species == "setosa") %>%
      set_names(LETTERS[1:5])

    tmp$A := add(2)

    x <- 1:10

    x :=
      replace(1:5, 0) %>%
      divide_by(2)

List of aliases provided:
--------------------------------------------------------------

    extract:                `[`
    extract2:              `[[`
    use_series:             `$`
    add:                    `+`
    subtract:               `-`
    multiply_by:            `*`
    multiply_by_matrix:   `%*%`
    raise_to_power          `^`
    divide_by:              `/`
    divide_by_int:        `%/%`
    mod:                  `\%%`
    and:                    `&`
    or:                     `|`
    equals                 `==`
    is_greater_than         `>`    
    is_weakly_greater_than `>=`
    is_less_than            `<`
    is_weakly_less_than    `<=`
    not                     `!`
    set_colnames   `colnames<-`
    set_rownames   `rownames<-`
    set_names         `names<-`
    l                   lambda
