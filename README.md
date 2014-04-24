magrittr -  Ceci n'est pas un pipe.
====================================

[![Build Status](https://travis-ci.org/smbache/magrittr.png?branch=master)](https://travis-ci.org/smbache/magrittr)

Make your code smokin' with magrittr's pipe operator.
The pipe-forwarding mechanism provided is similar to (but not exactly 
like) e.g. F#'s pipe-forward operator. It allows you to write code in a 
much more clean and readable way, and you will avoid making a mess 
in situations of multiple nested function calls. 
It is particularly useful when manipulating data frames etc. 
The package also contains a few useful features and aliases that
fit well into the syntax advocated by the package.
To learn more, see the included vignette.

**Update:** new examples including a new lambda syntax and a tee operator.

Installation:
-------------

    library(devtools)
    install_github("smbache/magrittr")

Alternatively, you can install from CRAN:

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
	1:10 %>% lambda(x -> x^2 + 2*x)

	# short-hand notation
    1:10 %>% l(x -> x^2 + 2*x)

	# For longer expressions:
    iris %>% l(x -> {
       fit <- lm(Sepal.Length ~ ., x)
	   fit %>% residuals %>% abs %>% mean
    })

    # Lambdas also work in other contexts:
	Filter(l(x -> x[x > 0]), rnorm(100))
    
    1:10 %>% 
      sapply(l(i -> if (i %% 2) i^2 else NULL))  %>% 
      unlist
      
    # Tee operator returns the left-hand side, after applying the
    # right-hand side:
	rnorm(100) %T>%
	  plot(type = "l", col = "firebrick") %>%
      abs %>%
      sum
     
    # Create your own pipe with side-effects. In this example 
    # we create a pipe with a "logging" function that traces
    # the left-hand sides of a chain. First, the logger:
	lhs_trace <- local({
      count <- 0
      function(x) {
        count <<- count + 1
        cl <- match.call()
        cat(sprintf("%d: lhs = %s\n", count, deparse(cl[[2]])))
      }
    })
	
	# Then attach it to a new pipe
    `%L>%` <- pipe_with(lhs_trace)

    # Try it out.
    1:10 %L>% sin %L>% cos %L>% abs

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