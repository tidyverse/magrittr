# actogrammr

<details>

* Version: 0.2.3
* Source code: https://github.com/cran/actogrammr
* Date/Publication: 2017-10-25 17:24:10 UTC
* Number of recursive dependencies: 68

Run `cloud_details(, "actogrammr")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘actogrammr-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: bin_data
    > ### Title: bin_data
    > ### Aliases: bin_data
    > 
    > ### ** Examples
    > 
    > f <- file.path(system.file(package = 'actogrammr'), 'testdata')
    > d <- read_clock_lab_files(file_names = list.files(path = f, full.names = TRUE))
    Warning: `as_data_frame()` is deprecated as of tibble 2.0.0.
    Please use `as_tibble()` instead.
    The signature and semantics have changed, see `?as_tibble`.
    This warning is displayed once every 8 hours.
    Call `lifecycle::last_warnings()` to see where this warning was generated.
    Error in long_act %>% dplyr::as_data_frame() %>% tidyr::separate(col = min,  : 
      no function to return from, jumping to top level
    Calls: read_clock_lab_files -> read_clock_lab_file -> %>%
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > 
      > test_check("actogrammr")
      ── 1. Error: read_clock_lab (@test_read_clock_lab.R#7)  ────────────────────────
      no function to return from, jumping to top level
      Backtrace:
       1. actogrammr::read_clock_lab_files(...)
       2. actogrammr:::read_clock_lab_file(file_name = file_name)
       3. `%>%`(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 0 | SKIPPED: 0 | WARNINGS: 1 | FAILED: 1 ]
      1. Error: read_clock_lab (@test_read_clock_lab.R#7) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# AnglerCreelSurveySimulation

<details>

* Version: 1.0.2
* Source code: https://github.com/cran/AnglerCreelSurveySimulation
* Date/Publication: 2018-03-13 21:25:26 UTC
* Number of recursive dependencies: 62

Run `cloud_details(, "AnglerCreelSurveySimulation")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > 
    > 
    > #Simulation 1
    > start_time <- c(1, 3.5, 6.5) 
    > wait_time <- c(2, 2, 3) 
    > n_anglers <- c(10,10,50) 
    > n_sites <- 3
    > sampling_prob <- sum(wait_time)/12
    > mean_catch_rate <- 3
    > 
    > n_sims <- 10
    > 
    > set.seed(256)
    > 
    > conduct_multiple_surveys(n_sims = n_sims, start_time = start_time, wait_time = wait_time, 
    +                          n_anglers = n_anglers, n_sites = n_sites, 
    +                          sampling_prob = sampling_prob, mean_catch_rate = mean_catch_rate)
    Error in data.frame(n_observed_trips = n_observed_trips, total_observed_trip_effort = total_observed_trip_effort,  : 
      no function to return from, jumping to top level
    Calls: conduct_multiple_surveys -> simulate_bus_route -> get_total_values -> %>%
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       1. AnglerCreelSurveySimulation::simulate_bus_route(...)
       2. AnglerCreelSurveySimulation::get_total_values(...)
       3. `%>%`(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 8 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 6 ]
      1. Error: Conducting n_simulations produces n_sims rows (@test_conduct_multiple_surveys.R#14) 
      2. Error: Wait time passed to fx is equal to actual wait time (@test_get_total_values.R#10) 
      3. Error: When wait time is zero, effort, completed trips, and catch is 0 (@test_get_total_values.R#23) 
      4. Error: True effort is the same as the sum of anglers$trip_length (@test_get_total_values.R#38) 
      5. Error: Simulating a bus route provides output (@test_simulate_bus_route.R#13) 
      6. Error: Simulating a bus route with 0 wait time provides output for only some fields (@test_simulate_bus_route.R#33) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# bupaR

<details>

* Version: 0.4.4
* Source code: https://github.com/cran/bupaR
* URL: https://www.bupar.net, https://github.com/bupaverse/bupaR
* Date/Publication: 2020-06-17 12:10:03 UTC
* Number of recursive dependencies: 57

Run `cloud_details(, "bupaR")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      ── 2. Error: slice returns eventlog with correct amount of cases (@test_slice.R#
      no function to return from, jumping to top level
      Backtrace:
        1. testthat::expect_equal(n_cases(slice(patients, selection)), length(selection))
        9. bupaR:::filter.eventlog(...)
       10. `%>%`(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 0 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 2 ]
      1. Error: slice returns eventlog (@test_slice.R#7) 
      2. Error: slice returns eventlog with correct amount of cases (@test_slice.R#13) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# c14bazAAR

<details>

* Version: 1.2.0
* Source code: https://github.com/cran/c14bazAAR
* URL: https://docs.ropensci.org/c14bazAAR, https://github.com/ropensci/c14bazAAR
* BugReports: https://github.com/ropensci/c14bazAAR/issues
* Date/Publication: 2020-01-12 16:50:02 UTC
* Number of recursive dependencies: 127

Run `cloud_details(, "c14bazAAR")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘c14bazAAR-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: as.sf
    > ### Title: Convert a *c14_date_list* to a sf object
    > ### Aliases: as.sf as.sf.default as.sf.c14_date_list
    > 
    > ### ** Examples
    > 
    > sf_c14 <- as.sf(example_c14_date_list)
    Warning in remove_dates_without_coordinates(., quiet) :
      Dates without coordinates were removed.
    Error in x %>% dplyr::filter(!is.na(.data[["lat"]]) & !is.na(.data[["lon"]])) %>%  : 
      no function to return from, jumping to top level
    Calls: as.sf ... as.sf.c14_date_list -> %<>% -> remove_dates_without_coordinates -> %>%
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 30 | SKIPPED: 2 | WARNINGS: 0 | FAILED: 11 ]
      1. Error: as.c14_date_list gives back a c14_date_list with correct input (@test_c14_date_list_basic.R#21) 
      2. Error: as.c14_date_list ignores additional columns (@test_c14_date_list_basic.R#30) 
      3. Error: (unknown) (@test_c14_date_list_calibrate.R#3) 
      4. Error: (unknown) (@test_c14_date_list_classify_material.R#5) 
      5. Error: as.sf prints a warning when it has to remove dates without coordinates (@test_c14_date_list_convert.R#6) 
      6. Error: (unknown) (@test_c14_date_list_convert.R#12) 
      7. Error: (unknown) (@test_c14_date_list_coordinate_precision.R#5) 
      8. Error: (unknown) (@test_c14_date_list_country_attribution.R#7) 
      9. Error: (unknown) (@test_c14_date_list_duplicates.R#3) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

# ChangePointTaylor

<details>

* Version: 0.1.0
* Source code: https://github.com/cran/ChangePointTaylor
* Date/Publication: 2020-06-09 09:40:06 UTC
* Number of recursive dependencies: 62

Run `cloud_details(, "ChangePointTaylor")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘ChangePointTaylor-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: change_point_analyzer
    > ### Title: change_point_analyzer
    > ### Aliases: change_point_analyzer
    > 
    > ### ** Examples
    > 
    > x <- US_Trade_Deficit$deficit_billions
    > label_vals <- US_Trade_Deficit$date
    > 
    > change_point_analyzer(x)
    Warning in change_df %>% dplyr::filter(!(.data$level == drop_level & .data$change_conf <  :
      no function to return from, jumping to top level
    Error in data.frame(change_ix = NA, label = NA, CI_init = "error", change_conf = NA,  : 
      no function to return from, jumping to top level
    Calls: change_point_analyzer ... tryCatch -> tryCatchList -> tryCatchOne -> <Anonymous> -> %>%
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘bench’ ‘ggplot2’
      All declared Imports should be used.
    ```

# collidr

<details>

* Version: 0.1.2
* Source code: https://github.com/cran/collidr
* URL: https://github.com/collidrpackage/collidr
* BugReports: https://github.com/collidrpackage/collidr/issues
* Date/Publication: 2019-09-08 15:50:04 UTC
* Number of recursive dependencies: 23

Run `cloud_details(, "collidr")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘collidr-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: CRAN_collisions
    > ### Title: Check for Namespace Collisions
    > ### Aliases: CRAN_collisions
    > 
    > ### ** Examples
    > 
    > 
    > # Test single function name
    > function_or_package_name <- "a3.r2"
    > CRAN_collisions(function_or_package_name)
    Error in output_list %>% return : 
      no function to return from, jumping to top level
    Calls: CRAN_collisions -> %>%
    Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 237 marked UTF-8 strings
    ```

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

# fbar

<details>

* Version: 0.5.2
* Source code: https://github.com/cran/fbar
* URL: http://maxconway.github.io/fbar/, https://github.com/maxconway/fbar
* BugReports: https://github.com/maxconway/fbar/issues
* Date/Publication: 2018-12-03 11:32:41 UTC
* Number of recursive dependencies: 62

Run `cloud_details(, "fbar")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    The error most likely occurred in:
    
    > ### Name: decompose_metabolites
    > ### Title: Decompose a metabolite table into the metabolite stub itself and
    > ###   the compartment it is in
    > ### Aliases: decompose_metabolites
    > 
    > ### ** Examples
    > 
    > data(ecoli_core)
    > 
    > mod <- reactiontbl_to_expanded(ecoli_core)
    Warning: `as_data_frame()` is deprecated as of tibble 2.0.0.
    Please use `as_tibble()` instead.
    The signature and semantics have changed, see `?as_tibble`.
    This warning is displayed once every 8 hours.
    Call `lifecycle::last_warnings()` to see where this warning was generated.
    Error in split %>% tibble::as_data_frame() %>% mutate(reversible = equations %>%  : 
      no function to return from, jumping to top level
    Calls: reactiontbl_to_expanded -> %>% -> mutate -> split_on_arrow -> %>%
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 8 | SKIPPED: 2 | WARNINGS: 2 | FAILED: 19 ]
      1. Error: toy model 1 (@test-ROI.R#15) 
      2. Error: toy model 2 (@test-ROI.R#34) 
      3. Error: same results on ecoli_core (@test-ROI_plugins.R#31) 
      4. Error: same results on iJO1366 (@test-ROI_plugins.R#48) 
      5. Error: find_fluxes_df gives sensible result with minimization (@test-convenience.R#16) 
      6. Error: find_fluxes_df gives sensible result without minimization (@test-convenience.R#24) 
      7. Error: find_fluxes_df works in grouped context (@test-full-size.R#19) 
      8. Error: tricky equations split correctly (@test-metabolite-parsing.R#19) 
      9. Error: metabolites are decomposed and recomposed correctly (@test-metabolite-parsing.R#29) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
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

# geocacheR

<details>

* Version: 0.1.0
* Source code: https://github.com/cran/geocacheR
* Date/Publication: 2020-02-11 10:50:12 UTC
* Number of recursive dependencies: 44

Run `cloud_details(, "geocacheR")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘geocacheR-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: vigenere
    > ### Title: Encrypt or decrypt a string using a key
    > ### Aliases: vigenere
    > 
    > ### ** Examples
    > 
    > vigenere("MN vdopf wq brcep zwtcd.", "midway")
    Error in mapply(FUN = rot, x = xv, n = xkey, MoreArgs = list(alphabet = alphabet,  : 
      no function to return from, jumping to top level
    Calls: vigenere -> %>%
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > 
      > test_check("geocacheR")
      ── 1. Error: vigenere outputs equal to expected values (@test_text_manipulation.
      no function to return from, jumping to top level
      Backtrace:
       1. testthat::expect_equal(...)
       4. geocacheR::vigenere("mlw jnmud uvgpg jgq", key = "te s1t")
       5. `%>%`(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 43 | SKIPPED: 0 | WARNINGS: 1 | FAILED: 1 ]
      1. Error: vigenere outputs equal to expected values (@test_text_manipulation.R#39) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tibble’
      All declared Imports should be used.
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

# gtsummary

<details>

* Version: 1.3.3
* Source code: https://github.com/cran/gtsummary
* URL: https://github.com/ddsjoberg/gtsummary, http://www.danieldsjoberg.com/gtsummary/
* BugReports: https://github.com/ddsjoberg/gtsummary/issues
* Date/Publication: 2020-08-11 18:20:03 UTC
* Number of recursive dependencies: 158

Run `cloud_details(, "gtsummary")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘gtsummary-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: add_global_p.tbl_regression
    > ### Title: Adds the global p-value for categorical variables
    > ### Aliases: add_global_p.tbl_regression
    > 
    > ### ** Examples
    > 
    > tbl_lm_global_ex1 <-
    +   lm(marker ~ age + grade, trial) %>%
    +   tbl_regression() %>%
    +   add_global_p()
    Error in unique(model_frame[[x]]) %>% as.character() %>% fixed() %>% str_detect(fixed(":")) %>%  : 
      no function to return from, jumping to top level
    Calls: %>% ... tbl_regression -> parse_fit -> %>% -> map_lgl -> .f -> %>%
    Execution halted
    ```

# healthcareai

<details>

* Version: 2.5.0
* Source code: https://github.com/cran/healthcareai
* URL: http://docs.healthcare.ai
* BugReports: https://github.com/HealthCatalyst/healthcareai-r/issues
* Date/Publication: 2020-08-05 23:30:02 UTC
* Number of recursive dependencies: 118

Run `cloud_details(, "healthcareai")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > ### Aliases: evaluate evaluate.predicted_df evaluate.model_list
    > 
    > ### ** Examples
    > 
    > models <- machine_learn(pima_diabetes[1:40, ],
    +                        patient_id,
    +                        outcome = diabetes,
    +                        models = c("XGB", "RF"),
    +                        tune = FALSE,
    +                        n_folds = 3)
    Training new data prep recipe...
    
    Variable(s) ignored in prep_data won't be used to tune models: patient_id
    
    diabetes looks categorical, so training classification algorithms.
    
    After data processing, models are being trained on 12 features with 40 observations.
    Based on n_folds = 3 and hyperparameter settings, the following number of models will be trained: 3 xgb's and 3 rf's 
    
    Training at fixed values: eXtreme Gradient Boosting
    Training at fixed values: Random Forest
    ```

*   checking tests ... ERROR
    ```
    ...
      Running ‘testthat-2.R’
      Running ‘testthat-3.R’
      Running ‘testthat-4.R’
      Running ‘testthat-5.R’
    Running the tests in ‘tests/testthat-5.R’ failed.
    Last 13 lines of output:
      ── 1. Error: the fundamentals work (@test-cran_only.R#6)  ──────────────────────
      no function to return from, jumping to top level
      Backtrace:
       1. stats::predict(m)
       2. healthcareai:::predict.model_list(m)
       3. healthcareai:::predict_model_list_main(...)
       4. healthcareai:::get_oof_predictions(object, mi)
       5. tibble::tibble(preds = predictions, outcomes = obs) %>% return()
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 1 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: the fundamentals work (@test-cran_only.R#6) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# heuristicsmineR

<details>

* Version: 0.2.4
* Source code: https://github.com/cran/heuristicsmineR
* URL: https://github.com/bupaverse/heuristicsmineR
* BugReports: https://github.com/bupaverse/heuristicsmineR/issues
* Date/Publication: 2020-03-29 19:50:03 UTC
* Number of recursive dependencies: 104

Run `cloud_details(, "heuristicsmineR")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > ### Aliases: dependency_matrix
    > 
    > ### ** Examples
    > 
    > d <- dependency_matrix(L_heur_1)
    > print(d)
              consequent
    antecedent       End Start         a         b         c         d         e
         End   0.0000000     0 0.0000000 0.0000000 0.0000000 0.0000000 0.0000000
         Start 0.0000000     0 0.9756098 0.0000000 0.0000000 0.0000000 0.0000000
         a     0.0000000     0 0.0000000 0.9166667 0.9166667 0.9285714 0.0000000
         b     0.0000000     0 0.0000000 0.0000000 0.0000000 0.0000000 0.9166667
         c     0.0000000     0 0.0000000 0.0000000 0.0000000 0.0000000 0.9166667
         d     0.0000000     0 0.0000000 0.0000000 0.0000000 0.0000000 0.9285714
         e     0.9756098     0 0.0000000 0.0000000 0.0000000 0.0000000 0.0000000
    attr(,"class")
    [1] "dependency_matrix" "matrix"           
    Error in graph %>% return() : 
      no function to return from, jumping to top level
    Calls: print ... print.dependency_matrix -> print -> render_dependency_matrix -> %>%
    Execution halted
    ```

# inspectdf

<details>

* Version: 0.0.8
* Source code: https://github.com/cran/inspectdf
* URL: https://alastairrushworth.github.io/inspectdf/
* BugReports: http://github.com/alastairrushworth/inspectdf/issues
* Date/Publication: 2020-06-25 14:30:02 UTC
* Number of recursive dependencies: 57

Run `cloud_details(, "inspectdf")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    
    The following objects are masked from ‘package:base’:
    
        intersect, setdiff, setequal, union
    
    > 
    > # Single dataframe summary
    > inspect_num(starwars)
    # A tibble: 3 x 10
      col_name     min    q1 median  mean    q3   max    sd pcnt_na hist            
      <chr>      <dbl> <dbl>  <dbl> <dbl> <dbl> <dbl> <dbl>   <dbl> <named list>    
    1 height        66 167      180 174.  191     264  34.8    6.90 <tibble [23 × 2…
    2 mass          15  55.6     79  97.3  84.5  1358 169.    32.2  <tibble [30 × 2…
    3 birth_year     8  35       52  87.6  72     896 155.    50.6  <tibble [20 × 2…
    > 
    > # Paired dataframe comparison
    > inspect_num(starwars, starwars[1:20, ])
    Error in strsplit(gsub("\\[|,|\\)", "", L$value), " ") %>% unlist %>%  : 
      no function to return from, jumping to top level
    Calls: inspect_num ... tibble -> tibble_quos -> eval_tidy -> lapply -> FUN -> %>%
    Execution halted
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

# microseq

<details>

* Version: 2.1.2
* Source code: https://github.com/cran/microseq
* Date/Publication: 2020-07-05 04:50:25 UTC
* Number of recursive dependencies: 24

Run `cloud_details(, "microseq")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > ### Aliases: findOrfs
    > 
    > ### ** Examples
    > 
    > # Using a genome file in this package
    > genome.file <- file.path(path.package("microseq"),"extdata","small.fna")
    > 
    > # Reading genome and finding orfs
    > genome <- readFasta(genome.file)
    > orf.tbl <- findOrfs(genome)
    > 
    > # Pipeline for finding LORFs of minimum length 100 amino acids
    > # and collecting their sequences from the genome
    > findOrfs(genome) %>% 
    +  lorfs() %>% 
    +  filter(orfLength(., aa = TRUE) > 100) %>% 
    +  gff2fasta(genome) -> lorf.tbl
    Error in orf.tbl %>% mutate(Length = Length) %>% arrange(desc(.data$Length)) %>%  : 
      no function to return from, jumping to top level
    Calls: %>% ... is.data.frame -> %>% -> filter -> %>% -> lorfs -> %>%
    Execution halted
    ```

# mortAAR

<details>

* Version: 1.0.2
* Source code: https://github.com/cran/mortAAR
* Date/Publication: 2019-07-31 09:40:02 UTC
* Number of recursive dependencies: 72

Run `cloud_details(, "mortAAR")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    Running examples in ‘mortAAR-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: is
    > ### Title: Checks if a variable is of class mortaar_life_table or
    > ###   mortaar_life_table_list
    > ### Aliases: is is.mortaar_life_table_list is.mortaar_life_table
    > 
    > ### ** Examples
    > 
    > # Create a mortaar_life_table from a prepared dataset.
    > class(schleswig_ma)
    [1] "data.frame"
    > is.mortaar_life_table(schleswig_ma)
    [1] FALSE
    > 
    > schleswig_1 <- life.table(schleswig_ma[c("a", "Dx")])
    Error in c(ifelse("a" %in% colnames(necdf) %>% all, necdf["a"] %>% unlist %>%  : 
      no function to return from, jumping to top level
    Calls: life.table ... inputchecks -> %>% -> unlist -> lapply -> FUN -> %>%
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(mortAAR)
      > 
      > test_check("mortAAR")
      Error in c(ifelse("a" %in% colnames(necdf) %>% all, necdf["a"] %>% unlist %>%  : 
        no function to return from, jumping to top level
      Calls: test_check ... inputchecks -> %>% -> unlist -> lapply -> FUN -> %>%
      Execution halted
    ```

# multipanelfigure

<details>

* Version: 2.1.2
* Source code: https://github.com/cran/multipanelfigure
* Date/Publication: 2020-03-04 16:10:03 UTC
* Number of recursive dependencies: 87

Run `cloud_details(, "multipanelfigure")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    The error most likely occurred in:
    
    > ### Name: multi_panel_figure
    > ### Title: multi_panel_figure
    > ### Aliases: multi_panel_figure multipanelfigure
    > ### Keywords: hplot utilities
    > 
    > ### ** Examples
    > 
    > # Figure construction based on the dimensions of the current device
    > figure1 <- multi_panel_figure(
    +    columns = 2,
    +    rows = 2,
    +    figure_name = "figure1")
    > 
    > # With no panels, printing shows the layout
    > figure1
    Error in x %>% as.numeric() %>% round(digits = digits) %>% grid::unit(saved_unit) %>%  : 
      no function to return from, jumping to top level
    Calls: <Anonymous> ... <Anonymous> -> textGrob -> grob -> round.unit -> %>%
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

# noisyCE2

<details>

* Version: 1.0.0
* Source code: https://github.com/cran/noisyCE2
* URL: https://www.flaviosanti.it/software/noisyCE2
* BugReports: https://github.com/f-santi/noisyCE2
* Date/Publication: 2019-08-20 09:50:02 UTC
* Number of recursive dependencies: 3

Run `cloud_details(, "noisyCE2")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘noisyCE2-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: noisyCE2
    > ### Title: Cross-Entropy Optimisation of Noisy Functions
    > ### Aliases: noisyCE2 print.noisyCE2 plot.noisyCE2
    > 
    > ### ** Examples
    > 
    > library(magrittr)
    > # Optimisation of the 4-dimensional function:
    > # f(x1,x2,x3,x4)=-(x1-1)^2-(x2-2)^2-(x3-3)^2-(x4-4)^2
    > sol <- noisyCE2(function(x) -sum((x - (1:4))^2), domain = rep('real', 4))
    Error in domain %>% as.list %>% lapply(function(x) { : 
      no function to return from, jumping to top level
    Calls: noisyCE2 -> generate_block -> %>%
    Execution halted
    ```

# optiSel

<details>

* Version: 2.0.3
* Source code: https://github.com/cran/optiSel
* Date/Publication: 2020-03-12 11:20:02 UTC
* Number of recursive dependencies: 102

Run `cloud_details(, "optiSel")` for more info

</details>

## Newly broken

*   checking whether package ‘optiSel’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: 'rgl.init' failed, running with 'rgl.useNULL = TRUE'.
    See ‘/tmp/workdir/optiSel/new/optiSel.Rcheck/00install.out’ for details.
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  9.1Mb
      sub-directories of 1Mb or more:
        extdata   1.8Mb
        libs      6.2Mb
    ```

# pathlibr

<details>

* Version: 0.1.0
* Source code: https://github.com/cran/pathlibr
* Date/Publication: 2019-02-22 14:40:06 UTC
* Number of recursive dependencies: 39

Run `cloud_details(, "pathlibr")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘pathlibr-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: Path$join
    > ### Title: Join two path components
    > ### Aliases: Path$join
    > 
    > ### ** Examples
    > 
    > {
    + path <- Path$new("some/path")
    + path$join("other/path")
    + }
    Error in lhs %>% file.path(other) %>% Path$new() %>% return() : 
      no function to return from, jumping to top level
    Calls: <Anonymous> -> %>%
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘R6’ ‘glue’ ‘logging’ ‘purrr’
      All declared Imports should be used.
    ```

# petrinetR

<details>

* Version: 0.2.1
* Source code: https://github.com/cran/petrinetR
* URL: https://www.bupar.net
* BugReports: https://github.com/gertjanssenswillen/petrinetR/issues
* Date/Publication: 2019-03-08 11:30:03 UTC
* Number of recursive dependencies: 71

Run `cloud_details(, "petrinetR")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    Backtrace:
         █
      1. ├─(function (x, ...) ...
      2. ├─petrinetR:::print.petrinet(x)
      3. │ ├─base::print(enabled(x))
      4. │ └─petrinetR::enabled(x)
      5. │   └─`%>%`(...)
      6. ├─dplyr::filter(., enabled == TRUE)
      7. ├─dplyr::mutate(...)
      8. ├─dplyr:::mutate.data.frame(...)
      9. │ └─dplyr:::mutate_cols(.data, ...)
     10. │   ├─base::withCallingHandlers(...)
     11. │   └─mask$eval_all_mutate(dots[[i]])
     12. ├─id %>% sapply(enabled_transition, PN = PN)
     13. ├─base::sapply(., enabled_transition, PN = PN)
     14. │ └─base::lapply(X = X, FUN = FUN, ...)
     15. │   └─petrinetR:::FUN(X[[i]], ...)
     16. │     ├─pre_set(PN, transition) %in% PN$marking
     17. │     └─petrinetR::pre_set(PN, transition)
     18. │       └─(PN$flows %>% filter(to ==
    Execution halted
    ```

# photosynthesis

<details>

* Version: 1.0.2
* Source code: https://github.com/cran/photosynthesis
* Date/Publication: 2020-07-01 09:40:02 UTC
* Number of recursive dependencies: 74

Run `cloud_details(, "photosynthesis")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘photosynthesis-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: A_supply
    > ### Title: CO2 supply and demand function (mol / m^2 s)
    > ### Aliases: A_supply A_demand
    > 
    > ### ** Examples
    > 
    > bake_par <- make_bakepar()
    Error in which %>% match.arg(c("bake", "constants", "enviro", "leaf")) %>%  : 
      no function to return from, jumping to top level
    Calls: make_bakepar -> %<>% -> <Anonymous> -> parameter_names -> %>%
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 0 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 15 ]
      1. Error: baked parameters do not equal unbaked unless Temp = 25 (@test-bake.R#6) 
      2. Error: constants returns class constants and list (@test-constants.R#5) 
      3. Error: fails when a parameter is left out (@test-constants.R#15) 
      4. Error: removes an improper parameter (@test-constants.R#26) 
      5. Error: nu_constant returns a list of two numbers (@test-constants.R#33) 
      6. Error: sh_constant returns a vector of one unitless number of numeric class (@test-constants.R#77) 
      7. Error: constants returns class enviro_par and list (@test-enviro-par.R#5) 
      8. Error: fails when a parameter is left out (@test-enviro-par.R#11) 
      9. Error: removes an improper parameter (@test-enviro-par.R#17) 
      1. ...
      
      Error: testthat unit tests failed
      Execution halted
    ```

# plot3logit

<details>

* Version: 2.2.0
* Source code: https://github.com/cran/plot3logit
* URL: https://www.flaviosanti.it/software/plot3logit
* BugReports: https://github.com/f-santi/plot3logit
* Date/Publication: 2020-07-19 06:30:02 UTC
* Number of recursive dependencies: 91

Run `cloud_details(, "plot3logit")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘plot3logit-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: DeltaB2pc
    > ### Title: Identification of equispaced central points
    > ### Aliases: DeltaB2pc DeltaB2pc_cat3logit DeltaB2pc_cat3logit_dim1
    > ###   DeltaB2pc_cat3logit_dim2 DeltaB2pc_cat3logit_dim3 DeltaB2pc_ord3logit
    > ### Keywords: internal
    > 
    > ### ** Examples
    > 
    > plot3logit:::DeltaB2pc_cat3logit(c(0.3, 0.7))
    Error in DeltaB %>% c(0, .) %>% order %>% mapply(function(x, y) { : 
      no function to return from, jumping to top level
    Calls: <Anonymous> ... DeltaB2pc_cat3logit_dim3 -> DeltaB2vroles_cat3logit -> %>%
    Execution halted
    ```

# predict3d

<details>

* Version: 0.1.3.3
* Source code: https://github.com/cran/predict3d
* URL: https://github.com/cardiomoon/predict3d
* BugReports: https://github.com/cardiomoon/predict3d/issues
* Date/Publication: 2019-09-03 13:00:02 UTC
* Number of recursive dependencies: 111

Run `cloud_details(, "predict3d")` for more info

</details>

## Newly broken

*   checking whether package ‘predict3d’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: 'rgl.init' failed, running with 'rgl.useNULL = TRUE'.
    See ‘/tmp/workdir/predict3d/new/predict3d.Rcheck/00install.out’ for details.
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘TH.data’ ‘moonBook’
      All declared Imports should be used.
    ```

# priceR

<details>

* Version: 0.1.4
* Source code: https://github.com/cran/priceR
* URL: https://github.com/stevecondylios/priceR
* BugReports: https://github.com/stevecondylios/priceR/issues
* Date/Publication: 2020-07-29 13:00:02 UTC
* Number of recursive dependencies: 42

Run `cloud_details(, "priceR")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘priceR-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: url_all_results
    > ### Title: Generate a World Bank API URL that will return all results for a
    > ###   given indicator in JSON format
    > ### Aliases: url_all_results
    > 
    > ### ** Examples
    > 
    > 
    > # Provide a World Bank API URL and `url_all_results` will convert it into one with all results
    > # for that indicator
    >   original_url <- "http://api.worldbank.org/v2/country" # Note: no ?format=json on url
    >   url_all_results(original_url)
    Generating URL to request all 304 results
    Error in url_with_all_results %>% return : 
      no function to return from, jumping to top level
    Calls: url_all_results -> %>%
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      The following object is masked from 'package:jsonlite':
      
          flatten
      
      The following object is masked from 'package:testthat':
      
          is_null
      
      Validating iso2Code for AU 
      Generating URL to request all 304 results
      Error in url_with_all_results %>% return : 
        no function to return from, jumping to top level
      Calls: test_check ... retrieve_inflation_data -> show_countries -> %>% -> url_all_results -> %>%
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘curl’ ‘lubridate’
      All declared Imports should be used.
    ```

# processanimateR

<details>

* Version: 1.0.3
* Source code: https://github.com/cran/processanimateR
* URL: https://github.com/bupaverse/processanimateR/
* BugReports: https://github.com/bupaverse/processanimateR/issues
* Date/Publication: 2020-03-13 21:30:02 UTC
* Number of recursive dependencies: 105

Run `cloud_details(, "processanimateR")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘processanimateR-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: animate_process
    > ### Title: Animate cases on a process map
    > ### Aliases: animate_process
    > 
    > ### ** Examples
    > 
    > data(example_log)
    > 
    > # Animate the process with default options (absolute time and 60s duration)
    > animate_process(example_log)
    Error in graph %>% return() : 
      no function to return from, jumping to top level
    Calls: animate_process -> process_map -> process_map.eventlog -> %>%
    Execution halted
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 11.6Mb
      sub-directories of 1Mb or more:
        doc           8.8Mb
        htmlwidgets   2.6Mb
    ```

# processcheckR

<details>

* Version: 0.1.3
* Source code: https://github.com/cran/processcheckR
* URL: https://www.bupar.net, https://github.com/bupaverse/processcheckr
* BugReports: https://github.com/bupaverse/processcheckr/issues
* Date/Publication: 2020-06-29 12:34:16 UTC
* Number of recursive dependencies: 85

Run `cloud_details(, "processcheckR")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    > library(bupaR)
    
    Attaching package: ‘bupaR’
    
    The following object is masked from ‘package:stats’:
    
        filter
    
    The following object is masked from ‘package:utils’:
    
        timestamp
    
    > library(eventdataR)
    > 
    > # Check for which patients the activity "MRI SCAN" is absent.
    > patients %>%
    + check_rule(absent("MRI SCAN"))
    Error in .data %>% as.data.frame() %>% dplyr::filter(...) %>% re_map(mapping) %>%  : 
      no function to return from, jumping to top level
    Calls: %>% ... filter_activity.eventlog -> filter -> filter.eventlog -> %>%
    Execution halted
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

# rgl

<details>

* Version: 0.100.54
* Source code: https://github.com/cran/rgl
* URL: https://r-forge.r-project.org/projects/rgl/
* BugReports: https://r-forge.r-project.org/projects/rgl/
* Date/Publication: 2020-04-14 14:40:02 UTC
* Number of recursive dependencies: 61

Run `cloud_details(, "rgl")` for more info

</details>

## Newly broken

*   checking whether package ‘rgl’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: 'rgl.init' failed, running with 'rgl.useNULL = TRUE'.
    See ‘/tmp/workdir/rgl/new/rgl.Rcheck/00install.out’ for details.
    ```

*   checking whether the namespace can be loaded with stated dependencies ... NOTE
    ```
    Warning: 'rgl.init' failed, running with 'rgl.useNULL = TRUE'.
    
    A namespace must be able to be loaded with just the base namespace
    loaded: otherwise if the namespace gets loaded by a saved object, the
    session will be unable to start.
    
    Probably some imports need to be declared in the NAMESPACE file.
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is 10.1Mb
      sub-directories of 1Mb or more:
        doc     3.6Mb
        fonts   1.5Mb
        libs    3.0Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Package unavailable to check Rd xrefs: ‘heplots’
    ```

# ripe

<details>

* Version: 0.1.0
* Source code: https://github.com/cran/ripe
* URL: https://github.com/yonicd/ripe
* BugReports: https://github.com/yonicd/ripe/issues
* Date/Publication: 2019-12-06 10:10:02 UTC
* Number of recursive dependencies: 55

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

# RNHANES

<details>

* Version: 1.1.0
* Source code: https://github.com/cran/RNHANES
* URL: http://github.com/silentspringinstitute/RNHANES
* BugReports: https://github.com/silentspringinstitute/RNHANES/issues
* Date/Publication: 2016-11-29 02:45:46
* Number of recursive dependencies: 65

Run `cloud_details(, "RNHANES")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      no function to return from, jumping to top level
      Backtrace:
       1. testthat::expect_equal(...)
       4. RNHANES:::process_file_name(c("EPH", "PFC"), c("2007-2008", "2011-2012"))
       5. RNHANES:::validate_year(year)
       6. `%>%`(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 24 | SKIPPED: 11 | WARNINGS: 0 | FAILED: 3 ]
      1. Error: file_suffix works (@test_data_files.R#7) 
      2. Error: it works for multiple years at a time (@test_data_files.R#17) 
      3. Error: it can process multiple file names/years at once (@test_data_files.R#67) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# rtext

<details>

* Version: 0.1.21
* Source code: https://github.com/cran/rtext
* URL: https://github.com/petermeissner/rtext
* BugReports: https://github.com/petermeissner/rtext/issues
* Date/Publication: 2019-01-23 22:00:03 UTC
* Number of recursive dependencies: 50

Run `cloud_details(, "rtext")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘test-all.R’
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      Loading required package: rtext
      Loading required package: stringb
      ── 1. Error: tools tokenize text (@test_tools.R#41)  ───────────────────────────
      no function to return from, jumping to top level
      Backtrace:
       1. testthat::expect_true(...)
       7. rtext:::text_tokenize.rtext(dings, "")
       8. `%>%`(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 279 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: tools tokenize text (@test_tools.R#41) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘RSQLite’ ‘stats’
      All declared Imports should be used.
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 2 marked UTF-8 strings
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

# sazedR

<details>

* Version: 2.0.1
* Source code: https://github.com/cran/sazedR
* URL: https://github.com/mtoller/autocorr_season_length_detection/
* Date/Publication: 2019-09-16 21:00:02 UTC
* Number of recursive dependencies: 25

Run `cloud_details(, "sazedR")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘sazedR-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: sazed
    > ### Title: SAZED Ensemble (Optimum)
    > ### Aliases: sazed
    > 
    > ### ** Examples
    > 
    > season_length <- 26
    > y <- sin(1:400*2*pi/season_length)
    > sazed(y)
    Error in subs %>% cor() %>% min %>% return() : 
      no function to return from, jumping to top level
    Calls: sazed -> sapply -> lapply -> FUN -> %>%
    Execution halted
    ```

# searchable

<details>

* Version: 0.3.3.1
* Source code: https://github.com/cran/searchable
* URL: https://github.com/decisionpatterns/searchable
* BugReports: https://github.com/decisionpatterns/searchable/issues
* Date/Publication: 2015-04-08 00:37:36
* Number of recursive dependencies: 25

Run `cloud_details(, "searchable")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘searchable-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: ignore.case
    > ### Title: Turn on/off case sensitivity for Searchable and Pattern objects
    > ### Aliases: case_insensitive case_sensitive ignore.case
    > ###   ignore.case.SearchableOrPattern ignore.case.character
    > ###   ignore.case.default use.case use.case.SearchableOrPattern
    > ###   use.case.character use.case.default
    > 
    > ### ** Examples
    > 
    > use.case("pattern")     # case-sensitive (Default)
    Error in msg %>% paste0(collapse = "") %>% return : 
      no function to return from, jumping to top level
    Calls: <Anonymous> ... <Anonymous> -> %>% -> cat -> .describe_pattern -> %>%
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
    Running examples in ‘tidyMicro-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: alpha_div
    > ### Title: Alpha Diversity Calculations for tidy_micro
    > ### Aliases: alpha_div
    > 
    > ### ** Examples
    > 
    > data(phy); data(cla); data(ord); data(fam); data(clin)
    > otu_tabs = list(Phylum = phy, Class = cla, Order = ord, Family = fam)
    > 
    > set <- tidy_micro(otu_tabs = otu_tabs, clinical = clin) %>%
    + filter(day == 7) ## Only including the first week
    Error in suppressWarnings(long_OTU %>% dplyr::select(rlang::.data$Lib,  : 
      no function to return from, jumping to top level
    Calls: %>% -> filter -> tidy_micro
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

# Tmisc

<details>

* Version: 0.1.22
* Source code: https://github.com/cran/Tmisc
* URL: https://github.com/stephenturner/Tmisc, http://stephenturner.github.io/Tmisc
* Date/Publication: 2019-12-05 15:30:05 UTC
* Number of recursive dependencies: 54

Run `cloud_details(, "Tmisc")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘Tmisc-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: ellipses
    > ### Title: Truncate a data frame with ellipses.
    > ### Aliases: ellipses
    > 
    > ### ** Examples
    > 
    > ellipses(mtcars, 5)
    Warning: `tbl_df()` is deprecated as of dplyr 1.0.0.
    Please use `tibble::as_tibble()` instead.
    This warning is displayed once every 8 hours.
    Call `lifecycle::last_warnings()` to see where this warning was generated.
    Error in df %>% head(n) %>% lapply(as.character) %>% data.frame(stringsAsFactors = FALSE) %>%  : 
      no function to return from, jumping to top level
    Calls: ellipses -> %>%
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
     1         0   25.4   1.47   7.45  0.214  0.200 0.00983 0.00601            1
     2         1   26.3   1.26   7.35  0.219  0.217 0.00989 0.00602            1
     3         2   25.6   1.47   7.29  0.216  0.212 0.00987 0.00603            1
     4         3   26.8   1.49   5.76  0.213  0.213 0.00979 0.00628            1
     5         4   26.7   1.49   5.69  0.213  0.212 0.00979 0.00629            1
     6         5   26.7   1.49   5.66  0.213  0.212 0.00979 0.00630            1
     7         6   26.6   1.49   5.03  0.210  0.217 0.0100  0.00652            1
     8         7   26.6   1.49   4.93  0.205  0.217 0.0100  0.00658            1
     9         8   26.6   1.48   4.62  0.211  0.217 0.00951 0.00735            1
    10         9   26.6   1.46   4.41  0.209  0.217 0.00903 0.00874            1
    # … with 18 more rows, and 7 more variables: `OMEGA(1,1)` <dbl>,
    #   `OMEGA(2,1)` <dbl>, `OMEGA(2,2)` <dbl>, `OMEGA(3,1)` <dbl>,
    #   `OMEGA(3,2)` <dbl>, `OMEGA(3,3)` <dbl>, OBJ <dbl>
    > 
    > # Multiple files (returns a list)
    > files <- get_file(xpdb_ex_pk, file = c('run001.ext', 'run001.phi'))
    Returning data from run001.ext, run001.phi
    Error in x$data %>% purrr::set_names(stringr::str_c(x$name, "_prob_",  : 
      no function to return from, jumping to top level
    Calls: get_file -> %>%
    Execution halted
    ```

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        1. `%>%`(...)
        6. xpose::vpc_data(., quiet = TRUE)
       11. `%>%`(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 459 | SKIPPED: 6 | WARNINGS: 0 | FAILED: 6 ]
      1. Error: (unknown) (@test-console_outputs.R#4) 
      2. Error: (unknown) (@test-edits.R#18) 
      3. Error: (unknown) (@test-vpc.R#17) 
      4. Error: get_file works properly (@test-xpdb_access.R#82) 
      5. Error: get_special checks input properly (@test-xpdb_access.R#193) 
      6. Error: get_data works properly (@test-xpdb_access.R#209) 
      
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

