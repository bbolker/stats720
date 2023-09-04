---
title: "software installation"
---

*Note*: some people use the [Anaconda](https://www.anaconda.com/) stack to manage their installations of Python (and other languages). It is slightly notorious for not playing nicely with other software; if you use it I'm happy for you but you may have to find Anaconda-specific instructions for installing all the bits and pieces below.

## Git and GitHub

### Install Git

  * downloads from [here](https://git-scm.com/downloads/)
  * [Happy Git with R](https://happygitwithr.com/) has detailed instructions designed around R/RStudio; 
  * https://www.jcchouinard.com/install-git-in-vscode/ has VSCode-centred instructions
  
### Set up GitHub

* get a Github user name (if you don't have one already)
    * Apply for [student benefits](https://docs.github.com/en/billing/managing-the-plan-for-your-github-account/discounted-plans-for-github-accounts) on GitHub if you like (more free stuff: private accounts etc)
* create a repository called `stats720`
* add me as a collaborator (Settings > Collaborators > enter `bbolker`)
* https://code.visualstudio.com/docs/sourcecontrol/overview
* send me a message on Piazza telling me your GH user name

### Learn about Git(Hub)

* Software Carpentry has a basic (command-line oriented) Git/Github lesson [here](https://swcarpentry.github.io/git-novice/)
* [Happy Git with R](https://happygitwithr.com/) for R/RStudio
* [Git with VSCode](https://code.visualstudio.com/docs/sourcecontrol/overview)

## R

R is a domain-specific language for statistics and data science.

If you already have R installed, please make sure that you have upgraded to the latest version!

* Download links:  https://cloud.r-project.org/ or https://mirror.csclub.uwaterloo.ca/CRAN/
* in the course of the term you may need compilation tools for building R code that includes compiled (C/Fortran) code
   * [MacOS tools](https://mac.r-project.org/tools/)
   * [Windows tools](https://cran.r-project.org/bin/windows/Rtools/rtools42/rtools.html)
   * if you use Linux you are likely to have most of these tools already, but see [here](https://cran.r-project.org/bin/linux/) (and go to the subdirectory appropriate for your distribution); you may also want to use [r2u](https://github.com/eddelbuettel/r2u#r2u-cran-as-ubuntu-binaries) to simplify and speed up package installation

## Quarto (preferred)

[Quarto](https://quarto.org/) is a scientific publishing/reporting system for integrating code and output in a document or notebook.

* https://quarto.org/docs/get-started/

## TeX (preferred)

[TeX](https://en.wikipedia.org/wiki/TeX) is an ancient (first released in the 1970s) typesetting/document creation system that is still standard in mathematics and many technical fields
   - [install TinyTeX for quarto](https://quarto.org/docs/output-formats/pdf-engine.html)

## VSCode (optional)

[Visual Studio Code](https://code.visualstudio.com/) (VSCode) is an integrated development environment (IDE). While it primarily targets software development rather than data analysis, it handles multiple languages better than RStudio (see below).

* https://code.visualstudio.com/download
* (`sudo apt install code -y` on recent Debian-based linux)

## extras

* For VSCode: recommended `radian` R console (also need Python installed!) `pip install radian`; update settings. See https://code.visualstudio.com/docs/languages/r
* spellchecker?
