magrittr -  Ceci n'est pas une pipe.
====================================

[![Build Status](https://travis-ci.org/smbache/magrittr.png?branch=master)](https://travis-ci.org/smbache/magrittr)

This package provides pipe-forwarding mechanisms similar to (but not exactly 
like) e.g. F#'s pipe-forward operator. It allows writing code in a sometimes
much more clean and readable way, and avoids making a mess in situations of 
multiple nested function calls. It is particularly useful when manipulating
data frames etc. The package also contains a few useful functions which 
fit well into the syntax allowed by the package.

Installation:
-------------

    library(devtools)
    install_github("smbache/magrittr")

Help overview:
--------------

    help(package = magrittr)

Example of usage:
------

     # Use without placeholder.
     iris %>%
       where(Species == "virginica") %>%
       delete(Species) %>%
       colMeans
      
     # Another example  
     iris %>%
       select(len   = Sepal.Length, 
              width = Sepal.Width, 
              ratio = Sepal.Length/Sepal.Length) %>%
       head
       
     # This is equivalent to the first example. The dot can be used to specify
     # where the values are piped...
     iris %>%
       where(., Species == "virginica") %>%
       delete(., Species) %>%
       colMeans
       
        
     # This will work although a dot is in the formula. Only the "outmost" call is matched against the dot.
     iris %>%
       aggregate(. ~ Species, ., mean)
       
     # If a function only takes one argument, you can omit the 
     # parentheses.
     rnorm(100) %>% abs %>% mean
       
     # Of course, all the usual regular functions are compatible:
     iris %>%
       ofclass(numeric) %>%
       apply(2, max)
       
     iris %>% sapply(class)
     
     iris %>% head(10)
     
     # The dplyr batting example:
     library(dplyr)
     library(Lahman)
     
     Batting %>%
       group_by(playerID) %>%
       summarise(total = sum(G)) %>%
       arrange(desc(total)) %>%
       head(5)


List of utility functions in addition to the pipe operator:
--------------------------------------------------------------
  
  * select   (selects, creates, or renames columns of data.frame)
  * add      (add columns to a data.frame. Uses select where existing columns are automatically selected).
  * delete   (deletes columns from a data.frame)
  * where    (filters a data.frame based on logical condition(s))
  * orderby  (orders a data.frame)
  * ofclass  (selects columns which has one of the specified classes)
  * rows     (selects rows using numerical indices and/or amounts)  
