# datamaps

<details>

* Version: 0.0.3
* Source code: https://github.com/cran/datamaps
* URL: http://datamaps.john-coene.com
* BugReports: https://github.com/JohnCoene/datamaps/issues
* Date/Publication: 2018-05-14 20:20:29 UTC
* Number of recursive dependencies: 48

Run `cloud_details(, "datamaps")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    
    > ### Name: add_arcs
    > ### Title: Add arcs
    > ### Aliases: add_arcs
    > 
    > ### ** Examples
    > 
    > states <- data.frame(ori.lon = c(-97.03720, -87.90446),
    +     ori.lat = c(32.89595, 41.97960),
    +     des.lon = c(-106.60919, -97.66987),
    +     des.lat = c(35.04022, 30.19453),
    +     strokeColor = c("blue", "red"),
    +     arcSharpness = c(2, 1))
    > 
    > states %>%
    +     datamaps(scope = "USA", default = "lightgray") %>%
    +     add_arcs(ori.lon, ori.lat, des.lon, des.lat, strokeColor)
    Error in eval(substitute(origin.lon), data) : 
      invalid 'envir' argument of type 'closure'
    Calls: %>% -> add_arcs -> eval
    Execution halted
    ```

# rcrtan

<details>

* Version: 0.1.1
* Source code: https://github.com/cran/rcrtan
* URL: https://github.com/gtlaflair/rcrtan
* BugReports: https://github.com/gtlaflair/rcrtan/issues
* Date/Publication: 2018-12-19 08:20:03 UTC
* Number of recursive dependencies: 39

Run `cloud_details(, "rcrtan")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘rcrtan-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: crt_iteman
    > ### Title: Calculate criterion-referenced item discrimination indices
    > ### Aliases: crt_iteman
    > 
    > ### ** Examples
    > 
    > crt_iteman(bh_depend, 2:31, 21, scale = 'raw')
    Error in data %>% { : no function to return from, jumping to top level
    Calls: crt_iteman -> %>%
    Execution halted
    ```

# reproducible

<details>

* Version: 1.2.1
* Source code: https://github.com/cran/reproducible
* URL: https://reproducible.predictiveecology.org, https://github.com/PredictiveEcology/reproducible
* BugReports: https://github.com/PredictiveEcology/reproducible/issues
* Date/Publication: 2020-08-18 07:20:36 UTC
* Number of recursive dependencies: 105

Run `cloud_details(, "reproducible")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > ### Name: Cache
    > ### Title: Cache method that accommodates environments, S4 methods,
    > ###   Rasters, & nested caching
    > ### Aliases: Cache Cache,ANY-method
    > 
    > ### ** Examples
    > 
    > tmpDir <- file.path(tempdir())
    > 
    > # Basic use
    > ranNumsA <- Cache(rnorm, 10, 16, cacheRepo = tmpDir)
    > 
    > # All same
    > ranNumsB <- Cache(rnorm, 10, 16, cacheRepo = tmpDir) # recovers cached copy
      ...(Object to retrieve (f11fb1a2880f8060.rds))
         loaded cached result from previous rnorm call, 
    > ranNumsC <- Cache(cacheRepo = tmpDir) %C% rnorm(10, 16)  # recovers cached copy
    Error in get(x, envir = ns, inherits = FALSE) : 
      object 'split_chain' not found
    Calls: %C% -> getFromNamespace -> get
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘test-all.R’
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      ── Skipped tests  ──────────────────────────────────────────────────────────────
      ● No Drive token is not TRUE (5)
      ● On CRAN (58)
      ● empty test (6)
      ● test cloudCache inside Cache -- Not fully written test (1)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      ERROR (test-cache.R:550:3): test pipe for Cache
      Warning (test-copy.R:8:3): test Copy
      Warning (test-prepInputs.R:1803:3): rasters aren't properly resampled
      Warning (test-prepInputs.R:1818:3): rasters aren't properly resampled
      
      [ FAIL 1 | WARN 3 | SKIP 70 | PASS 354 ]
      Error: Test failures
      Execution halted
    ```

# ripe

<details>

* Version: 0.1.0
* Source code: https://github.com/cran/ripe
* URL: https://github.com/yonicd/ripe
* BugReports: https://github.com/yonicd/ripe/issues
* Date/Publication: 2019-12-06 10:10:02 UTC
* Number of recursive dependencies: 58

Run `cloud_details(, "ripe")` for more info

</details>

## Newly broken

*   checking whether package ‘ripe’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/tmp/workdir/ripe/new/ripe.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘ripe’ ...
** package ‘ripe’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
Error in get("is_pipe", asNamespace("magrittr")) : 
  object 'is_pipe' not found
Error: unable to load R code in package ‘ripe’
Execution halted
ERROR: lazy loading failed for package ‘ripe’
* removing ‘/tmp/workdir/ripe/new/ripe.Rcheck/ripe’

```
### CRAN

```
* installing *source* package ‘ripe’ ...
** package ‘ripe’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** installing vignettes
** testing if installed package can be loaded from temporary location
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (ripe)

```
# TCIU

<details>

* Version: 1.1.0
* Source code: https://github.com/cran/TCIU
* URL: https://github.com/SOCR/TCIU, https://spacekime.org, https://tciu.predictive.space
* BugReports: https://github.com/SOCR/TCIU/issues
* Date/Publication: 2020-09-18 12:00:32 UTC
* Number of recursive dependencies: 189

Run `cloud_details(, "TCIU")` for more info

</details>

## Newly broken

*   checking whether package ‘TCIU’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: loading Rplot failed
    See ‘/tmp/workdir/TCIU/new/TCIU.Rcheck/00install.out’ for details.
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 12.3Mb
      sub-directories of 1Mb or more:
        doc  11.2Mb
    ```

# tidytidbits

<details>

* Version: 0.2.2
* Source code: https://github.com/cran/tidytidbits
* Date/Publication: 2020-04-15 14:50:02 UTC
* Number of recursive dependencies: 31

Run `cloud_details(, "tidytidbits")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    
    Attaching package: ‘dplyr’
    
    The following objects are masked from ‘package:stats’:
    
        filter, lag
    
    The following objects are masked from ‘package:base’:
    
        intersect, setdiff, setequal, union
    
    > x <- c() # now x exists in the calling env
    > tibble(a=1, b=2) %>%
    +    mutate(b=a+3) %>%
    +    interlude(x <- .$b) %>%
    +    mutate(a=a+1)
    Warning: `call_stack()` is deprecated as of rlang 0.3.0.
    This warning is displayed once per session.
    Error in stack[[i + 1]] : subscript out of bounds
    Calls: %>% -> mutate -> interlude
    Execution halted
    ```

# torch

<details>

* Version: 0.1.1
* Source code: https://github.com/cran/torch
* URL: https://torch.mlverse.org/docs, https://github.com/mlverse/torch
* BugReports: https://github.com/mlverse/torch/issues
* Date/Publication: 2020-10-20 21:10:02 UTC
* Number of recursive dependencies: 58

Run `cloud_details(, "torch")` for more info

</details>

## Newly broken

*   checking whether package ‘torch’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/tmp/workdir/torch/new/torch.Rcheck/00install.out’ for details.
    ```

## Newly fixed

*   checking installed package size ... NOTE
    ```
      installed size is 157.6Mb
      sub-directories of 1Mb or more:
        R       3.1Mb
        help    2.8Mb
        libs  151.2Mb
    ```

## Installation

### Devel

```
* installing *source* package ‘torch’ ...
** package ‘torch’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c RcppExports.cpp -o RcppExports.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c autograd.cpp -o autograd.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c contrib.cpp -o contrib.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c cuda.cpp -o cuda.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c device.cpp -o device.o
In file included from device.cpp:2:
torch_types.h:7: warning: "LANTERN_HOST_HANDLER" redefined
    7 | #define LANTERN_HOST_HANDLER lantern_host_handler();
      | 
In file included from device.cpp:1:
lantern/lantern.h:35: note: this is the location of the previous definition
   35 | #define LANTERN_HOST_HANDLER
      | 
In file included from device.cpp:1:
lantern/lantern.h: In function ‘bool lanternInit(const string&, std::string*)’:
lantern/lantern.h:4097:6: note: variable tracking size limit exceeded with ‘-fvar-tracking-assignments’, retrying without
 4097 | bool lanternInit(const std::string &libPath, std::string *pError)
      |      ^~~~~~~~~~~
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c dimname_list.cpp -o dimname_list.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c dtype.cpp -o dtype.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c gen-namespace.cpp -o gen-namespace.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c generator.cpp -o generator.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c indexing.cpp -o indexing.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c lantern.cpp -o lantern.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c layout.cpp -o layout.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c memory_format.cpp -o memory_format.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c nn_utils_rnn.cpp -o nn_utils_rnn.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c qscheme.cpp -o qscheme.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c quantization.cpp -o quantization.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c reduction.cpp -o reduction.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c save.cpp -o save.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c scalar.cpp -o scalar.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c storage.cpp -o storage.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c tensor.cpp -o tensor.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c tensor_list.cpp -o tensor_list.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c tensor_options.cpp -o tensor_options.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c utils.cpp -o utils.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c variable_list.cpp -o variable_list.o
g++ -std=gnu++11 -shared -L/usr/lib/R/lib -Wl,-Bsymbolic-functions -Wl,-z,relro -o torch.so RcppExports.o autograd.o contrib.o cuda.o device.o dimname_list.o dtype.o gen-namespace.o generator.o indexing.o lantern.o layout.o memory_format.o nn_utils_rnn.o qscheme.o quantization.o reduction.o save.o scalar.o storage.o tensor.o tensor_list.o tensor_options.o utils.o variable_list.o -L/usr/lib/R/lib -lR
Renaming torch lib to torchpkg
"/usr/lib/R/bin/Rscript" "../tools/renamelib.R"
installing to /tmp/workdir/torch/new/torch.Rcheck/00LOCK-torch/00new/torch/libs
** R
Warning in dir.create(outCodeDir) :
  cannot create dir '/tmp/workdir/torch/new/torch.Rcheck/00LOCK-torch/00new/torch/R', reason 'No space left on device'
Error in .install_package_code_files(".", instdir) : 
  cannot open directory '/tmp/workdir/torch/new/torch.Rcheck/00LOCK-torch/00new/torch/R'
ERROR: unable to collate and parse R files for package ‘torch’
* removing ‘/tmp/workdir/torch/new/torch.Rcheck/torch’

```
### CRAN

```
* installing *source* package ‘torch’ ...
** package ‘torch’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c RcppExports.cpp -o RcppExports.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c autograd.cpp -o autograd.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c contrib.cpp -o contrib.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c cuda.cpp -o cuda.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c device.cpp -o device.o
In file included from device.cpp:2:
torch_types.h:7: warning: "LANTERN_HOST_HANDLER" redefined
    7 | #define LANTERN_HOST_HANDLER lantern_host_handler();
      | 
In file included from device.cpp:1:
lantern/lantern.h:35: note: this is the location of the previous definition
   35 | #define LANTERN_HOST_HANDLER
      | 
In file included from device.cpp:1:
lantern/lantern.h: In function ‘bool lanternInit(const string&, std::string*)’:
lantern/lantern.h:4097:6: note: variable tracking size limit exceeded with ‘-fvar-tracking-assignments’, retrying without
 4097 | bool lanternInit(const std::string &libPath, std::string *pError)
      |      ^~~~~~~~~~~
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c dimname_list.cpp -o dimname_list.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c dtype.cpp -o dtype.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c gen-namespace.cpp -o gen-namespace.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c generator.cpp -o generator.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c indexing.cpp -o indexing.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c lantern.cpp -o lantern.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c layout.cpp -o layout.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c memory_format.cpp -o memory_format.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c nn_utils_rnn.cpp -o nn_utils_rnn.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c qscheme.cpp -o qscheme.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c quantization.cpp -o quantization.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c reduction.cpp -o reduction.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c save.cpp -o save.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c scalar.cpp -o scalar.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c storage.cpp -o storage.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c tensor.cpp -o tensor.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c tensor_list.cpp -o tensor_list.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c tensor_options.cpp -o tensor_options.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c utils.cpp -o utils.o
g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/usr/local/lib/R/site-library/Rcpp/include"   -fpic  -g -O2 -fdebug-prefix-map=/build/r-base-jbaK_j/r-base-3.6.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g  -c variable_list.cpp -o variable_list.o
g++ -std=gnu++11 -shared -L/usr/lib/R/lib -Wl,-Bsymbolic-functions -Wl,-z,relro -o torch.so RcppExports.o autograd.o contrib.o cuda.o device.o dimname_list.o dtype.o gen-namespace.o generator.o indexing.o lantern.o layout.o memory_format.o nn_utils_rnn.o qscheme.o quantization.o reduction.o save.o scalar.o storage.o tensor.o tensor_list.o tensor_options.o utils.o variable_list.o -L/usr/lib/R/lib -lR
Renaming torch lib to torchpkg
"/usr/lib/R/bin/Rscript" "../tools/renamelib.R"
installing to /tmp/workdir/torch/old/torch.Rcheck/00LOCK-torch/00new/torch/libs
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
*** copying figures
** building package indices
** installing vignettes
** testing if installed package can be loaded from temporary location
** checking absolute paths in shared objects and dynamic libraries
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (torch)

```
