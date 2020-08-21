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

# ggedit

<details>

* Version: 0.3.1
* Source code: https://github.com/cran/ggedit
* URL: https://github.com/yonicd/ggedit
* BugReports: https://github.com/yonicd/ggedit/issues
* Date/Publication: 2020-06-02 11:50:06 UTC
* Number of recursive dependencies: 81

Run `cloud_details(, "ggedit")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > 
    > # renaming in lambdas:
    > iris %>%
    + {
    +   my_data <- .
    +   size <- sample(1:10, size = 1)
    +   rbind(head(my_data, size), tail(my_data, size))
    + }
        Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
    1            5.1         3.5          1.4         0.2    setosa
    2            4.9         3.0          1.4         0.2    setosa
    3            4.7         3.2          1.3         0.2    setosa
    148          6.5         3.0          5.2         2.0 virginica
    149          6.2         3.4          5.4         2.3 virginica
    150          5.9         3.0          5.1         1.8 virginica
    > 
    > # Building unary functions with %>%
    > trig_fest <- . %>% tan %>% cos %>% sin
    Error in cos(.) : non-numeric argument to mathematical function
    Calls: %>% -> %>%
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘magrittr’
      All declared Imports should be used.
    ```

# keyholder

<details>

* Version: 0.1.5
* Source code: https://github.com/cran/keyholder
* URL: https://echasnovski.github.io/keyholder/, https://github.com/echasnovski/keyholder/
* BugReports: https://github.com/echasnovski/keyholder/issues/
* Date/Publication: 2020-05-09 11:20:02 UTC
* Number of recursive dependencies: 55

Run `cloud_details(, "keyholder")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 253 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 15 ]
      1. Error: arrange.keyed_df works (@test-keyed-df-one-tbl.R#320) 
      2. Error: arrange_all works (@test-keyed-df-one-tbl.R#348) 
      3. Error: arrange_if works (@test-keyed-df-one-tbl.R#369) 
      4. Error: arrange_at works (@test-keyed-df-one-tbl.R#384) 
      5. Error: filter.keyed_df works (@test-keyed-df-one-tbl.R#401) 
      6. Error: filter_all works (@test-keyed-df-one-tbl.R#417) 
      7. Error: filter_if works (@test-keyed-df-one-tbl.R#441) 
      8. Error: filter_at works (@test-keyed-df-one-tbl.R#457) 
      9. Error: slice.keyed_df works (@test-keyed-df-one-tbl.R#482) 
      1. ...
      
      Error: testthat unit tests failed
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

# ruler

<details>

* Version: 0.2.3
* Source code: https://github.com/cran/ruler
* URL: https://echasnovski.github.io/ruler/, https://github.com/echasnovski/ruler
* BugReports: https://github.com/echasnovski/ruler/issues
* Date/Publication: 2020-05-09 15:00:03 UTC
* Number of recursive dependencies: 58

Run `cloud_details(, "ruler")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
          is_false, is_null, is_true
      
      > library(ruler)
      > 
      > test_check("ruler")
      Error in UseMethod("summarise_") : 
        no applicable method for 'summarise_' applied to an object of class "c('fseq', 'function')"
      Calls: test_check ... %>% -> <Anonymous> -> summarise.default -> summarise_
      In addition: Warning message:
      `summarise_()` is deprecated as of dplyr 0.7.0.
      Please use `summarise()` instead.
      This warning is displayed once every 8 hours.
      Call `lifecycle::last_warnings()` to see where this warning was generated. 
      Execution halted
    ```

# spork

<details>

* Version: 0.1.6
* Source code: https://github.com/cran/spork
* Date/Publication: 2020-02-28 16:30:06 UTC
* Number of recursive dependencies: 51

Run `cloud_details(, "spork")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      no applicable method for 'as_plotmath' applied to an object of class "c('fseq', 'function')"
      Backtrace:
       1. . %>% as_spork %>% as_plotmath %>% as_preview
       4. spork::as_plotmath(.)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 11 | SKIPPED: 4 | WARNINGS: 0 | FAILED: 5 ]
      1. Error: extreme juxtapostion without escape succeeds (@test-spork.R#291) 
      2. Error: arbitrary plotmath escapes succeed by default (@test-spork.R#317) 
      3. Error: expressions render without error (@test-spork.R#324) 
      4. Error: as_plotmath handles arbitrary location of newline (@test-spork.R#427) 
      5. Error: newline renders sensibly as plotmath (@test-spork.R#451) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# staRdom

<details>

* Version: 1.1.14
* Source code: https://github.com/cran/staRdom
* URL: https://cran.r-project.org/package=staRdom
* BugReports: https://github.com/MatthiasPucher/staRdom/issues
* Date/Publication: 2020-07-28 23:40:02 UTC
* Number of recursive dependencies: 152

Run `cloud_details(, "staRdom")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘staRdom-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: eempf_leverage_data
    > ### Title: Combine leverages into one data frame and add optional labels.
    > ### Aliases: eempf_leverage_data
    > 
    > ### ** Examples
    > 
    > data(pf_models)
    > 
    > leverage <- eempf_leverage(pf4[[1]])
    > lev_data <- eempf_leverage_data(leverage)
    Error in rownames_to_column(., "x") : is.data.frame(df) is not TRUE
    Calls: eempf_leverage_data ... %>% -> setNames -> %>% -> rownames_to_column -> stopifnot
    Execution halted
    ```

# survivalAnalysis

<details>

* Version: 0.1.3
* Source code: https://github.com/cran/survivalAnalysis
* Date/Publication: 2020-06-29 12:22:09 UTC
* Number of recursive dependencies: 140

Run `cloud_details(, "survivalAnalysis")` for more info

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
    
    > survival::aml %>%
    +   analyse_survival(vars(time, status), x) %>%
    +   kaplan_meier_plot(break.time.by="breakByMonth",
    +                     xlab=".OS.months",
    +                     risk.table=TRUE,
    +                     ggtheme=ggplot2::theme_bw(10))
    Error in list_recurse(.x, list2(...), function(x, y) y) : 
      is.list(x) is not TRUE
    Calls: %>% ... do_plot -> list_modify -> list_recurse -> stopifnot
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

# tidybayes

<details>

* Version: 2.1.1
* Source code: https://github.com/cran/tidybayes
* URL: http://mjskay.github.io/tidybayes, https://github.com/mjskay/tidybayes
* BugReports: https://github.com/mjskay/tidybayes/issues/new
* Date/Publication: 2020-06-19 05:50:03 UTC
* Number of recursive dependencies: 201

Run `cloud_details(, "tidybayes")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Component 15: Mean relative difference: 0.1934548
      Component 16: Mean relative difference: 0.5598497
      Component 17: Mean relative difference: 0.2413982
      Component 18: Mean relative difference: 0.2821581
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 246 | SKIPPED: 15 | WARNINGS: 0 | FAILED: 5 ]
      1. Failure: [add_]fitted_draws allows extraction of dpar on brms models with categorical outcomes (response scale) (@test.fitted_draws.R#381) 
      2. Failure: [add_]fitted_draws allows extraction of dpar on brms models with categorical outcomes (response scale) (@test.fitted_draws.R#382) 
      3. Failure: ungather_draws works on a simple parameter with no dimensions (@test.ungather_draws.R#37) 
      4. Failure: ungather_draws works on multiple parameters with different dimensions (@test.ungather_draws.R#55) 
      5. Failure: ungather_draws(drop_indices = TRUE) drops draw indices (@test.ungather_draws.R#70) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘HDInterval’ ‘grid’ ‘scales’
      All declared Imports should be used.
    ```

# tidyMicro

<details>

* Version: 1.43
* Source code: https://github.com/cran/tidyMicro
* BugReports: https://github.com/CharlieCarpenter/tidyMicro
* Date/Publication: 2020-03-28 14:20:02 UTC
* Number of recursive dependencies: 173

Run `cloud_details(, "tidyMicro")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > 
    > ### ** Examples
    > 
    > data(phy); data(cla); data(ord); data(fam); data(clin)
    > 
    > otu_tabs = list(Phylum = phy, Class = cla, Order = ord, Family = fam)
    > set <- tidy_micro(otu_tabs = otu_tabs, clinical = clin) %>%
    + filter(day == 7) ## Only including the first week
    Contains 74 libraries from OTU files.
    
    Summary of sequencing depth:
    
       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
       8851   24938   33314   36650   43590   97408 
    > 
    > ## Bray-Curtis beta diversity
    > bray <- set %>% beta_div(table = "Family")
    Error in `rownames<-`(`*tmp*`, value = Lib) : 
      attempt to set 'rownames' on an object with no dimensions
    Calls: %>% -> beta_div -> rownames<-
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘Evomorph’ ‘cowplot’ ‘factoextra’ ‘gridExtra’ ‘lme4’ ‘lsr’ ‘plotly’
      ‘png’ ‘shapes’
      All declared Imports should be used.
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
    > mtcars %>% count_at(vars(gear, cyl))
    Error: Can't subset columns that don't exist.
    ✖ Column `rel` doesn't exist.
    Backtrace:
         █
      1. ├─mtcars %>% count_at(vars(gear, cyl))
      2. ├─tidytidbits::count_at(., vars(gear, cyl))
      3. │ └─`%>%`(...)
      4. ├─dplyr::select(., !!!labels, !!!.grouping, !!!column_names)
      5. └─dplyr:::select.data.frame(., !!!labels, !!!.grouping, !!!column_names)
      6.   └─tidyselect::eval_select(expr(c(...)), .data)
      7.     └─tidyselect:::eval_select_impl(...)
      8.       ├─tidyselect:::with_subscript_errors(...)
      9.       │ ├─base::tryCatch(...)
     10.       │ │ └─base:::tryCatchList(expr, classes, parentenv, handlers)
     11.       │ │   └─base:::tryCatchOne(expr, names, parentenv, handlers[[1L]])
     12.       │ │     └─base:::doTryCatch(return(expr), name, parentenv, handler)
     13.       │ └─tidyselect:::instrument_base_errors(expr)
     14.       │   └─base::withCallingHandlers(...)
     15.       └─tidyselect:::vars_select_eva
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
        6. xpose::vpc_data(., quiet = TRUE)
       11. `%>%`(...)
      
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

# yamlet

<details>

* Version: 0.4.8
* Source code: https://github.com/cran/yamlet
* Date/Publication: 2020-06-18 18:00:03 UTC
* Number of recursive dependencies: 70

Run `cloud_details(, "yamlet")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      target is NULL, current is character
      
      ── 2. Error: factorize_codelist creates class factor and removes attribute codel
      $ operator is invalid for atomic vectors
      Backtrace:
       1. testthat::expect_true("factor" %in% x$Heart$class)
       4. "factor" %in% x$Heart$class
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 127 | SKIPPED: 4 | WARNINGS: 59 | FAILED: 2 ]
      1. Failure: factorize_codelist creates class factor and removes attribute codelist (@test-yamlet.R#328) 
      2. Error: factorize_codelist creates class factor and removes attribute codelist (@test-yamlet.R#332) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

