magrittr -  Ceci n'est pas une pipe.
====================================

This package provides pipe-forwarding mechanisms similar to (but not exactly 
like) e.g. F#'s pipe-forward operator. It allows writing code in a sometimes
much more clean and readable way, and avoids making a mess in situations of 
multiple nested function calls. It is particularly useful when manipulating
data frames etc. The package also contains a few useful functions which 
fit well into the syntax allowed by the package.

Installation:
-------------

    library(devtools)
    install.packages("magrittr", "smbache")

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
       select(len = Sepal.Length, width = Sepal.Width, ratio = Sepal.Length/Sepal.Length) %>%
       head
       
     # This is equivalent to the first example. The dot can be used to specify
     # where the values are piped...
     iris %>%
       where(., Species == "virginica") %>%
       delete(., Species) %>%
       colMeans
       
        
     # Here, the double dot serves as placeholder, because the 
     # single-dot is used in the formula. To do this, we use
     # the %>>% operator.
     iris %>>%
       aggregate(. ~ Species, .., mean)
       
     # If a function only takes one argument, you can omit the 
     # parentheses.
     rnorm(100) %>% abs %>% mean
       

List of utility functions in addition to the pipe operator(s):
--------------------------------------------------------------
  
  * select   (selects, creates, or renames columns of data.frame)
  * delete   (deletes columns from a data.frame)
  * where    (filters a data.frame based on logical condition(s))
  * orderby  (orders a data.frame)
  * ofclass  (selects columns which has one of the specified classes)
  * rows     (selects rows using numerical indices and/or amounts)  
