# Software tools for STATS 720

(see also [setup info](../assignments/setup.html))

*Note*: some people use the [Anaconda](https://www.anaconda.com/) stack to manage their installations of Python (and other languages). It is slightly notorious for not playing nicely with other software; if you use it I'm happy for you but you may have to find Anaconda-specific instructions for installing all the bits and pieces below.

## R

R is a domain-specific language for statistics and data science

   - download links etc. at [CRAN](https://cran.r-project.org/) (Comprehensive R Archive Network) (if you already have R installed, make sure you have upgraded to the **latest version**)
   - in the course of the term you will probably need compilation tools for building R code that includes compiled (C/Fortran) code
   
      - [MacOS tools](https://mac.r-project.org/tools/)
      - [Windows tools](https://cran.r-project.org/bin/windows/Rtools/rtools42/rtools.html)
	  - if you use Linux you are likely to have most of these tools already, but see [here](https://cran.r-project.org/bin/linux/) (and go to the subdirectory appropriate for your distribution); you may also want to use [r2u](https://github.com/eddelbuettel/r2u#r2u-cran-as-ubuntu-binaries) to simplify and speed up package installation

## Quarto

[Quarto](https://quarto.org/) is a scientific publishing/reporting system for integrating code and output in a document or notebook. [Download/install link](https://quarto.org/docs/get-started/)

## VS Code

[Visual Studio Code](https://code.visualstudio.com/) (VSCode) is an integrated development environment (IDE). While it primarily targets software development rather than data analysis, it handles multiple languages better than RStudio (see below). [Download and install](https://code.visualstudio.com/download)

  - [R extension](https://code.visualstudio.com/docs/languages/r)
  - [radian](https://github.com/randy3k/radian#radian-a-21-century-r-console) (improved R console for VS Code)
  - [Julia extension](https://code.visualstudio.com/docs/languages/julia)
  - [Quarto extension](https://quarto.org/docs/tools/vscode.html)
  
## Positron

[Positron](https://github.com/posit-dev/positron?tab=readme-ov-file)  is an R/Python-oriented development environment based on VS Code; it's much less mature than RStudio or VS Code, but you may want to check it out.
  
## TeX 

[TeX](https://en.wikipedia.org/wiki/TeX) is an ancient (first released in the 1970s) typesetting/document creation system that is still standard in mathematics and many technical fields. If you already have (La)TeX installed on your system, you probably don't need to reinstall it.

- [install TinyTeX for quarto](https://quarto.org/docs/output-formats/pdf-engine.html)

## RStudio

RStudio is a more traditional IDE that supports R very well, and other languages OK. [Download/install](https://www.rstudio.com/products/rstudio/download/) (free desktop version). 

## Python (optional)

You'll need to install Python if you want to use `radian`, which is an improved R console for VS Code. [Download/install](https://www.python.org/downloads/)

