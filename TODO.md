# Stat 720 TODO

## Set-up tasks

* Piazza (quiz framework etc.?)
* preliminary assessment questions
* set up GH pages (copy stat790, also Navarro Makefile machinery <https://blog.djnavarro.net/posts/2023-06-30_makefiles/>)
* Quiz/terminology intro (for completion credit)? e.g. coverage, likelihood profile, model misspecification, pseudoreplication, p-hacking/snooping/HARKing, post-selection inference, ... ?
* homework/test scheduling
* annotated bibliography?
   * Harrell, Faraway, Thyregod and Madsden, Searle, etc.

## Week 1/intro

### Big picture

* "God is in every leaf of every tree"
* Concepts rather than a grab bag of tools 
   * in practice lots of tools, but knowing what they have in common ...
* embrace generative models (cf Breiman)
    * testing methods
	* knowing the conditions under which methods will work
	* consider effects of model misspecification
* ... but recognize M-openness (Tukey, "all models are wrong")
* requirement for efficient computation
* vs STATS 780
   * more focus on theory
   * only regression-based models (no trees, kernel methods, SVMs, etc.)
* vs STATS 790
   * ditto, but less emphasis on computation
* what can we do with the combination of
   * model matrices
   * (usually Gaussian) shrinkage estimators (**latent variables**)
   * MLE or approximations thereof
   * (mostly *not* E-M algorithm)

### Computation stuff

* workflows, R best practices ...  @rossFasteR2013
* @bryanProjectoriented2017, @bryanExcuse2017

### R formula interface

* nuts and bolts of contrasts

### Inference dos and don'ts

* @shamsudheenShould2021

