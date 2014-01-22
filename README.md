magrittr -  Ceci n'est pas une pipe.
====================================

[![Build Status](https://travis-ci.org/smbache/magrittr.png?branch=master)](https://travis-ci.org/smbache/magrittr)

Make your code smokin' with magrittr's pipe operator.
The pipe-forwarding mechanism provided are similar to (but not exactly 
like) e.g. F#'s pipe-forward operator. It allows you to write code in a 
much more clean and readable way, and you will avoid making a mess 
in situations of multiple nested function calls. 
It is particularly useful when manipulating data frames etc. 
The package also contains a few useful aliases that make other R operators
fit well into the syntax advocated by the package.

Installation:
-------------

    library(devtools)
    install_github("smbache/magrittr", ref = "bruyere")

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
       series(timestamp) %>%
       format("%M") %>%
       as.numeric %>%
       int.divide(15) %>%
       plus(1)

List of aliases provided:
--------------------------------------------------------------

    extract:     `[`
    Extract:	   `[[`
    series:	     `$`
    plus:	       `+`
    minus:       `-`
    times:	     `*`
    multiply:	   `%*%`
    divide:	     `/`
    int.divide:	 `%/%`
    `%.%`:       `%>%`
