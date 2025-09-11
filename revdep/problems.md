# StreamCatTools

<details>

* Version: 0.6.0
* GitHub: https://github.com/USEPA/StreamCatTools
* Source code: https://github.com/cran/StreamCatTools
* Date/Publication: 2025-09-02 20:40:02 UTC
* Number of recursive dependencies: 167

Run `revdepcheck::cloud_details(, "StreamCatTools")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(StreamCatTools)
      > 
      > test_check("StreamCatTools")
      [ FAIL 1 | WARN 1 | SKIP 0 | PASS 69 ]
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
    ...
       4.       └─jsonlite::fromJSON("https://api.epa.gov/StreamCat/streams/metrics")
       5.         └─jsonlite:::parse_and_simplify(...)
       6.           └─jsonlite:::parseJSON(txt, bigint_as_char)
       7.             └─jsonlite:::parse_con(txt, bigint_as_char)
       8.               ├─base::open(con, "rb")
       9.               └─base::open.connection(con, "rb")
      
      [ FAIL 1 | WARN 1 | SKIP 0 | PASS 69 ]
      Error: Test failures
      Execution halted
    ```

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘Applications.Rmd’ using rmarkdown
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  5.1Mb
      sub-directories of 1Mb or more:
        doc   4.4Mb
    ```

