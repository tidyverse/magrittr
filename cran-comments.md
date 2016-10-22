## Changes

* Removed aliases. Many common names were exported. These will instead
  be provided by separate package.
* One can now use `foo$bar` rhs specifications, to meet some OO systems, where
  methods are accessed like this.
* The pipe no longer uses recursion. Rather the right-hand sides are all 
  used to construct a single function, which is much easier to debug. 
  Also, the stack traces are simpler.
* One can now wrap right-hand sides in a one-sided formula. This is useful
  in package development when the dot placeholder is used (but not known
  to the checker).
* Some internal clean-up.

## Test environments

* local Windows 7 install, R 3.2.3
* ubuntu 12.04 (on travis-ci), R 3.1.2
* win-builder (devel and release)

## R CMD check results
TODO

## Downstream dependencies
TODO