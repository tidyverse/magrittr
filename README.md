magrittr -  Ceci n'est pas un pipe.
====================================

[![Build Status](https://travis-ci.org/smbache/magrittr.png?branch=master)](https://travis-ci.org/smbache/magrittr)

Make your code smokin' with magrittr's pipe operator.
The pipe-forwarding mechanism provided is similar to (but not exactly 
like) e.g. F#'s pipe-forward operator or the classical unix pipe. 
It allows you to write code in a much more clean and readable way,
and you will avoid making a mess in situations of multiple nested function calls. 
It is particularly useful when manipulating data frames etc. 
The package also contains a few useful aliases that make other R operators
fit well into the syntax advocated by the package.

In addition to the pipe operator, magrittr also contains a tee-like 
operator, `%T>%`, which can be used in pipelines to add side-effects at certain
steps in the chain, for example logging. It is also possible to make 
make a pipe-operator with a fixed side-effect at *each* step in pipeline.

Finally, there is a shortcut for anonymous functions/lambda
expressions using `lambda` (or the alias `l`). This is designed to have
a signature which is very convenient to use with `%>%`.

To learn more, see the included vignette and/or see the examples below.


Installation:
-------------

    library(devtools)
    install_github("smbache/magrittr")

Alternatively, you can install from CRAN:

    install.packages("magrittr")
    

Help overview:
--------------

    help(package = magrittr)

Example of usage:
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
        
     # Examples using anonymous functions:
     iris %>% 
       function(x) { 
         rbind(x %>% head, x %>% tail)
       }
      
     iris %>% 
       lambda({ rbind(x %>% head, x %>% tail) })
     
     iris %>% 
       l({ rbind(x %>% head, x %>% tail)})
        
        
     # Examples of the tee operator and teed_pipe.
     
     1:10 %T>% plot(type = "l") %>% multiply_by(2)
     
     # Define a logging function
     logger <- function(x)
        cat(as.character(Sys.time()), ":", nrow(x), "\n")

     # mask %>% with a version using the logger.
     `%>%` <- teed_pipe(logger)

     # Test it:
     iris %>%
        subset(Species == "setosa") %>%
        subset(Sepal.Length > 5) %>%
        tail(10)

     # Restore the original pipe:
     rm(`%>%`)

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
    `l`:                 lambda
