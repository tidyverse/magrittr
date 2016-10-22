# magrittr 1.6

## Breaking Changes

* Aliases have been removed, and will appear in a separate package. This
  is to make it safer to load and attach all of magrittr.
* The pipeline function is no longer treated as a list/sequence, and 
  indexing via `[` will no longer work. This was a little used feature and 
  had very few use-cases. Instead a simple and more efficient function is
  constructed.


## New features

* RHS can be wrapped in a one-sided formula. This is to be able to use e.g. the 
  placeholder symbol without R CMD check notes. The explicit use of a formula
  is an explicit way for the user to express that this is desired.
* The dollar operator is now treated special wrt precedence to allow piping into
  e.g. R6 methods and functions in lists/environments.

## Bug fixes

* Colon syntax now works without parentheses.

