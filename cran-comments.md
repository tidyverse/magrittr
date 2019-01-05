## Response to CRAN comments on last submit

* Another attempt at getting title casing correct.
* Added a slightly longer description to the DESCRIPTION file
* Added quotation marks to the Treachery of Images quotation.
* The quotation is kept as it is part og the package's image. 
  I hope you will respect this decision.
* Added NEWS.md to .Rbuildignore

## Test environments

* local: darwin15.6.0-3.5.1
* travis: 3.1, 3.2, 3.3, oldrel, release, devel
* r-hub: windows-x86_64-devel, ubuntu-gcc-release, fedora-clang-devel
* win-builder: windows-x86_64-devel

## R CMD check results
There were no ERRORs or WARNINGs. 

I experience this NOTE, when using devtools::release, but not
when I check the package as usual:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Stefan Milton Bache <stefan@stefanbache.dk>'
Components with restrictions and base license permitting such:
  MIT + file LICENSE
File 'LICENSE':
  YEAR: 2014
  COPYRIGHT HOLDER: Stefan Milton Bache and Hadley Wickham

## Downstream dependencies
I have also run R CMD check on downstream dependencies of magrittr. 
There were only notes unrelated to magrittr.
