## Response to CRAN comments on last submit

* Another attempt at getting title casing correct.
* Added a slightly longer description to the DESCRIPTION file
* Added quotation marks to the Treachery of Images quotation.
* The quotation is kept as it is part og the package's image. 
  I hope you will respect this decision.
* Added NEWS.md to .Rbuildignore

## Test environments

* local Windows 7 install, R 3.1.2
* ubuntu 12.04 (on travis-ci), R 3.1.2
* win-builder (devel and release)

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
