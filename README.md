magrittr -  Ceci n'est pas un pipe.
====================================

[![Build Status](https://travis-ci.org/smbache/magrittr.png?branch=dev)](https://travis-ci.org/smbache/magrittr)


# Introduction

This is an experimental redesign of `magrittr` built on the principle of functional sequences.

For most practical purposes, it works as usual:

    value %>%
      fun1(arg1) %>%
      fun2(arg2, .) %>%
      fun3

The tee operator is there:

    value %T>%
      plot %>%          # usually doesn't return anything
      some_function     # receives value

And the compound assignment operator:

	iris$Sepal.Length %<>% multiply_by(2)

The main difference is that the entire right-hand side is "compiled" into a functional
sequence (a function which applies the individual right-hand sides sequentially). When the 
left-hand side is a value, the result of applying this function is returned. 
One can also use the `magrittr` placeholder,
the `.` as left-hand side, in which case functional sequences itself is returned:

    fun <- . %>% cos %>% sin %>% sum(na.rm = TRUE)

The function list can be extracted as

    functions(fun)

For easy inspection these have their own `print` method:

    > fun
    Functional sequence with the following components:

     1. cos(.)
     2. sin(.)
     3. sum(., na.rm = TRUE)

    Use 'functions' to extract the individual functions.

The one-time "compilation" of the functional sequence is also useful in repetitive 
situations:

    loong_vector %>% lapply(. %>% a %>% b %>% c %>% d)

In this case the expressions `a--d` only has to be determined once.

# Relevant other differences
* There is currently no `lambda` function in this version.
* `magrittr` does not try to maintain a `call` as previously.

 