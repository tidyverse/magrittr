# ggfortify

<details>

* Version: 0.4.10
* Source code: https://github.com/cran/ggfortify
* URL: https://github.com/sinhrks/ggfortify
* BugReports: https://github.com/sinhrks/ggfortify/issues
* Date/Publication: 2020-04-26 13:20:02 UTC
* Number of recursive dependencies: 124

Run `cloud_details(, "ggfortify")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘test-all.R’
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      ── 1. Error: fortify.MSwM works for sample data (@test-MSwM.R#8)  ──────────────
      Lapack routine dgesv: system is exactly singular: U[3,3] = 0
      Backtrace:
       1. MSwM::msmFit(...)
       2. MSwM::msmFit(...)
       4. MSwM:::em(ans, control)
       6. MSwM:::hessian(object)
       9. base::solve.default(res$Hessian)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 734 | SKIPPED: 47 | WARNINGS: 7 | FAILED: 1 ]
      1. Error: fortify.MSwM works for sample data (@test-MSwM.R#8) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

