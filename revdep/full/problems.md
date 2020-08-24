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

# detrendr

<details>

* Version: 0.6.8
* Source code: https://github.com/cran/detrendr
* URL: https://rorynolan.github.io/detrendr, https://www.github.com/rorynolan/detrendr#readme
* BugReports: https://www.github.com/rorynolan/detrendr/issues
* Date/Publication: 2020-08-03 15:30:18 UTC
* Number of recursive dependencies: 102

Run `cloud_details(, "detrendr")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > if (!detrendr:::win32bit()) test_check("detrendr")
      ── 1. Error: best_swaps() works (@test-best_params.R#113)  ─────────────────────
      Your image is too close to zero. Can't detrend an image with so few nonzero values. 
      * `img` has 375000 elements and just 374998 of them are greater than zero.
      Backtrace:
       1. testthat::expect_equal(...)
       4. detrendr::best_swaps(img, quick = TRUE)
       8. detrendr:::best_swaps_naive(img)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 66 | SKIPPED: 19 | WARNINGS: 2 | FAILED: 1 ]
      1. Error: best_swaps() works (@test-best_params.R#113) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  7.8Mb
      sub-directories of 1Mb or more:
        libs   6.6Mb
    ```

*   checking for GNU extensions in Makefiles ... NOTE
    ```
    GNU make is a SystemRequirements.
    ```

# dragon

<details>

* Version: 1.0.1
* Source code: https://github.com/cran/dragon
* URL: https://github.com/sjspielman/dragon
* BugReports: https://github.com/sjspielman/dragon/issues
* Date/Publication: 2020-07-19 00:10:03 UTC
* Number of recursive dependencies: 124

Run `cloud_details(, "dragon")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Backtrace:
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 105 | SKIPPED: 3 | WARNINGS: 0 | FAILED: 8 ]
      1. Error: fct_build_network::initialize_data_age() using maximum known age (@test_build-network.R#76) 
      2. Error: fct_build_network::initialize_data_age() using minimum known age (@test_build-network.R#103) 
      3. Error: fct_build_network::construct_network() with elements_by_redox = F (@test_build-network.R#129) 
      4. Error: fct_build_network::construct_network() with elements_by_redox = T (@test_build-network.R#167) 
      5. Error: fct_build_network::specify_community_detect_network() with Louvain community clustering (@test_build-network.R#204) 
      6. Error: fct_build_network::initialize_network() works (@test_build-network.R#226) 
      7. Error: fct_export_network::* works  (@test_export-network.R#15) 
      8. Error: fct_timeline::prepare_timeline_data() works (@test_timeline.R#14) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘htmltools’ ‘magrittr’ ‘promises’
      All declared Imports should be used.
    ```

# finalfit

<details>

* Version: 1.0.2
* Source code: https://github.com/cran/finalfit
* URL: https://github.com/ewenharrison/finalfit
* BugReports: https://github.com/ewenharrison/finalfit/issues
* Date/Publication: 2020-07-03 13:10:03 UTC
* Number of recursive dependencies: 139

Run `cloud_details(, "finalfit")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > 
    > colon_s %>%
    + 	glmuni(dependent, explanatory) %>%
    + 	fit2df(estimate_suffix=" (univariable)") -> example.univariable
    Waiting for profiling to be done...
    Waiting for profiling to be done...
    Waiting for profiling to be done...
    Waiting for profiling to be done...
    > 
    > colon_s %>%
    + 	 glmmulti(dependent, explanatory) %>%
    + 	 fit2df(estimate_suffix=" (multivariable)") -> example.multivariable
    Waiting for profiling to be done...
    > 
    > colon_s %>%
    +   glmmixed(dependent, explanatory, random_effect) %>%
    + 	 fit2df(estimate_suffix=" (multilevel") -> example.multilevel
    Error in exists(v, envir = env, inherits = FALSE) : 
      use of NULL environment is defunct
    Calls: %>% ... checkFormulaData -> allvarex -> vapply -> FUN -> exists
    Execution halted
    ```

# nandb

<details>

* Version: 2.0.7
* Source code: https://github.com/cran/nandb
* URL: https://rorynolan.github.io/nandb, https://github.com/rorynolan/nandb
* BugReports: https://github.com/rorynolan/nandb/issues
* Date/Publication: 2020-05-08 13:10:06 UTC
* Number of recursive dependencies: 106

Run `cloud_details(, "nandb")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       13. detrendr:::best_swaps_naive(img)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 101 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 8 ]
      1. Error: brightness works (@test-brightness.R#5) 
      2. Error: brightness_timeseries works (@test-brightness.R#128) 
      3. Error: cc_brightness() works (@test-cc_brightness.R#7) 
      4. Error: cc_brightness_timeseries() works (@test-cc_brightness.R#65) 
      5. Error: cc_number() works (@test-cc_number.R#7) 
      6. Error: cc_number_timeseries() works (@test-cc_number.R#65) 
      7. Error: number works (@test-number.R#5) 
      8. Error: number_timeseries works (@test-number.R#200) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# nlmixr

<details>

* Version: 1.1.1-9
* Source code: https://github.com/cran/nlmixr
* URL: https://github.com/nlmixrdevelopment/nlmixr
* Date/Publication: 2020-06-22 08:50:08 UTC
* Number of recursive dependencies: 154

Run `cloud_details(, "nlmixr")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library(nlmixr)
      > 
      > test_check("nlmixr")
      ── 1. Error: UI updates work correctly (@test-piping.R#63)  ────────────────────
      object '.tmp' not found
      Backtrace:
       1. f %>% update(tka = 4, cl = exp(tcl), ka = exp(tka), .tmp)
       3. nlmixr:::update.nlmixrUI(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 188 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: UI updates work correctly (@test-piping.R#63) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 28.6Mb
      sub-directories of 1Mb or more:
        libs  26.9Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘stringr’
      All declared Imports should be used.
    ```

# r2dii.analysis

<details>

* Version: 0.0.1
* Source code: https://github.com/cran/r2dii.analysis
* URL: https://github.com/2DegreesInvesting/r2dii.analysis
* BugReports: https://github.com/2DegreesInvesting/r2dii.analysis/issues
* Date/Publication: 2020-06-28 10:20:03 UTC
* Number of recursive dependencies: 64

Run `cloud_details(, "r2dii.analysis")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(r2dii.analysis)
      > 
      > test_check("r2dii.analysis")
      ── 1. Failure: returns visibly (@test-join_ald_scenario.R#17)  ─────────────────
      join_ald_scenario(...) does not invisibly
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 104 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Failure: returns visibly (@test-join_ald_scenario.R#17) 
      
      Error: testthat unit tests failed
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

# rlang

<details>

* Version: 0.4.7
* Source code: https://github.com/cran/rlang
* URL: http://rlang.r-lib.org, https://github.com/r-lib/rlang
* BugReports: https://github.com/r-lib/rlang/issues
* Date/Publication: 2020-07-09 23:00:18 UTC
* Number of recursive dependencies: 48

Run `cloud_details(, "rlang")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘sink.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 2686 | SKIPPED: 25 | WARNINGS: 2 | FAILED: 14 ]
      1. Failure: %>% frames are collapsed (@test-trace.R#219) 
      2. Failure: %>% frames are collapsed (@test-trace.R#222) 
      3. Failure: %>% frames are collapsed (@test-trace.R#225) 
      4. Failure: children of collapsed %>% frames have correct parent (@test-trace.R#245) 
      5. Failure: combinations of incomplete and leading pipes collapse properly (@test-trace.R#303) 
      6. Failure: combinations of incomplete and leading pipes collapse properly (@test-trace.R#306) 
      7. Failure: combinations of incomplete and leading pipes collapse properly (@test-trace.R#309) 
      8. Failure: combinations of incomplete and leading pipes collapse properly (@test-trace.R#312) 
      9. Failure: combinations of incomplete and leading pipes collapse properly (@test-trace.R#315) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

# taber

<details>

* Version: 0.1.0
* Source code: https://github.com/cran/taber
* URL: http://github.com/restonslacker/taber
* BugReports: http://github.com/restonslacker/taber/issues
* Date/Publication: 2015-08-03 21:10:50
* Number of recursive dependencies: 20

Run `cloud_details(, "taber")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > ### ** Examples
    > 
    > library(dplyr)
    
    Attaching package: ‘dplyr’
    
    The following objects are masked from ‘package:stats’:
    
        filter, lag
    
    The following objects are masked from ‘package:base’:
    
        intersect, setdiff, setequal, union
    
    > aframe <- data.frame(zed = runif(100))
    > set_to_zero <- . %>% mutate(zed = 0)
    > aframe %>% scion(zed >0.5, false_fun=set_to_zero) %>% mutate(zed=1) %>% graft
    Error in .pop() : 
      No more scions on stack. Perhaps you meant to specify the "data2" argument to graft()?
    Calls: %>% -> graft -> .pop
    Execution halted
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

# xpose

<details>

* Version: 0.4.11
* Source code: https://github.com/cran/xpose
* URL: https://github.com/UUPharmacometrics/xpose
* BugReports: https://github.com/UUPharmacometrics/xpose/issues
* Date/Publication: 2020-07-22 21:10:03 UTC
* Number of recursive dependencies: 96

Run `cloud_details(, "xpose")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > 
    > # List output files data
    > list_files(xpdb_ex_pk)
    Files:
      name       extension problem subprob method data               modified
      <chr>      <chr>       <dbl>   <dbl> <chr>  <list>             <lgl>   
    1 run001.cor cor             1       0 foce   <tibble [14 × 15]> FALSE   
    2 run001.cov cov             1       0 foce   <tibble [14 × 15]> FALSE   
    3 run001.ext ext             1       0 foce   <tibble [28 × 16]> FALSE   
    4 run001.grd grd             1       0 foce   <tibble [21 × 11]> FALSE   
    5 run001.phi phi             1       0 foce   <tibble [74 × 12]> FALSE   
    6 run001.shk shk             1       0 foce   <tibble [7 × 5]>   FALSE   
    > 
    > # List special data
    > xpdb_ex_pk %>% 
    + vpc_data(quiet = TRUE) %>% 
    + list_special()
    Error in split_chain(match.call(), env = env) : 
      could not find function "split_chain"
    Calls: %>% ... <Anonymous> -> vpc.default -> do.call -> <Anonymous> -> %>%
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Backtrace:
        1. `%>%`(...)
        5. xpose::vpc_data(., quiet = TRUE)
       10. `%>%`(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 460 | SKIPPED: 6 | WARNINGS: 0 | FAILED: 5 ]
      1. Error: (unknown) (@test-console_outputs.R#4) 
      2. Error: (unknown) (@test-edits.R#18) 
      3. Error: (unknown) (@test-vpc.R#17) 
      4. Error: get_special checks input properly (@test-xpdb_access.R#193) 
      5. Error: get_data works properly (@test-xpdb_access.R#209) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

