magrittr -  Ceci n'est pas une pipe.
====================================

R package to bring forward-piping features ala F#'s |> operator.

Installation:
-------------

    library(devtools)
    install.packages("magrittr", "smbache")

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
     # single-dot is used in the formula.
     iris %>%
       aggregate(. ~ Species, .., mean)
       
     # If a function only takes one argument, you can omit the 
     # parentheses.
     rnorm(100) %>% abs %>% mean
       
       
       
    
