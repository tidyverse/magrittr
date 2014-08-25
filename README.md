magrittr -  Ceci n'est pas un pipe.
====================================

[![Build Status](https://travis-ci.org/smbache/magrittr.png?branch=dev)](https://travis-ci.org/smbache/magrittr)


# Installation

    devtools::install_github("smbache/magrittr", ref = "dev")

# Introduction

This is an experimental redesign of `magrittr` which is more centered on 
the principle of functional sequences (and generally faster than the original 
implementation). One should be familiar with
the general purpose and use of `magrittr` to make the most of the description 
below, which is still somewhat unstructured.

For most practical purposes, it works **as usual**:

    value %>%
      fun1(arg1) %>%
      fun2(arg2, .) %>%
      fun3

The **tee operator** is there:

    value %T>%
      plot %>%          # usually doesn't return anything, here returns lhs from before
      some_function     # receives value

And the **compound assignment pipe operator**:

	iris$Sepal.Length %<>% multiply_by(2)

    # equivalent to
    iris$Sepal.Length <- iris$Sepal.Length %>% multiply_by(2)

The **main difference** is that the entire right-hand side is "compiled" into a functional
sequence (a function which applies the individual right-hand sides sequentially). When the 
left-hand side is a value, the result of applying this function is returned; when it is the
`magrittr` placeholder (`.`) the **functional sequences itself is returned**:

    fun <- . %>% cos %>% sin %>% sum(na.rm = TRUE)

This can be used either normally, `fun(1:10)`, or using the pipe, `1:10 %>% fun`.
It is therefore a useful shortcut to constructing single argument functions.

This **"one-time compilation"** of the functional sequence is also useful in repetitive 
situations:

    loong_vector %>% lapply(. %>% a %>% b %>% c %>% d)

In this case the expressions `a--d` only has to be processed once.

# Lambdas

Since every "right-hand side" (RHS) in a pipe expression is treated as a function
of a single parameter (`.`), a RHS is essentially just the function body with 
the special rule that when no dot (`.`) appears at the outer-most level in the 
call (i.e. it only appears in nested function calls, or not at all) then it is
inserted as the first argument. In other words, it is a short-hand for writing the
body in full. It is therefore only natural that one could write more advanced 
function bodies enclosed in `{}`, which is now possible (and takes the role of
`lambda`, which is not included):

    rnorm(100) %>% { if (mean(.) > 0) "good times" else "bad times" }

This can also be used to "overrule" first-argument piping in some rare occations
where this is useful, say `rnorm(100) %>% {c(min(.), max(.)}`.

The expression inside `{}` can be as if one had written `(function(.) { ... })`.
Sometimes is more expressive to rename the dot argument, so there is a shorthand for this:

	rnorm(100) %>% 
	  {x; if (mean(x) > 0) "good times" else "bad times"}

Simply use a bare symbol as the first expression inside, and this will be 
interpreted as `symbol <- .`. The example above is of course equivalent to

	rnorm(100) %>% {x 
	  if (mean(x) > 0) "good times" else "bad times"
	}

# Debugging

There is also added more debugging functionality, which makes it easier to debug
certain steps in the chain:

    fun <- . %>% expr(arg) %>% more %>% and_finally

    # debug first and third function
    debug_fseq(fun, 1, 3)

 	# ... test and undebug them again:
	undebug_fseq(fun)

# Extracting subsets of functional sequences

It is also possible to extract the function list using `functions`: 

    functions(fun)

and one can also construct functional subsequences using the `[` operator, e.g. `fun[1:2]`. 
The result here will be a new functional sequence (i.e. not a list of functions, but
a single function, which applies the function list sequentially.)

When using a part of a functional sequence in a chain it needs to be parenthesized
as other function-generating calls:

    value %>%
      (fun[1:2])

# Inspecting functional sequences.

For easy inspection these have their own `print` method:

    > fun
    Functional sequence with the following components:

     1. cos(.)
     2. sin(.)
     3. sum(., na.rm = TRUE)

    Use 'functions' to extract the individual functions.
