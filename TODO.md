# Stat 720 TODO

rcs vs B-splines vs ns
smoothing matrix for f''^2 penalty

Bayes

point to Bayes intro?

----


Notes: Laplace approx, AGHQ, Sigma/Z equivalence, parameterizations (paper on Laplace approx?)

* RTMB examples of mixed models

Yee and Wild (1996), JRSSB 58: 481-493

https://cran.r-project.org/web/packages/effects/vignettes/partial-residuals.pdf

* https://datavizf24.classes.andrewheiss.com/resource/ai-bs.html#what-about-code

* DQ definition
* questionnaire
* work on HW1 ?
* Gelman&Hill/Yakulic & Uriarte picture?
* interaction? (Ask them to define the modeling loop?)
* Olympic medals database: by GDP, population size, ... ? Multivariate model of medal types? Through time? Ask students to scrape?
   * https://gist.github.com/rmcelreath/8cc6d3414f469690287b4982fcf895ae
   * https://www.medalspercapita.com/#weighted-per-capita:2024
   * https://www.theguardian.com/sport/article/2024/aug/10/paris-olympics-2024-how-does-medal-tally-work-order
   * Choi, Yun Hyeong, Qingyuan Wei, Luyao Zhang, and Seong-Jin Choi. 2022. “The Impact of Cultural Distance on Performance at the Summer Olympic Games.” Sage Open 12 (1): 21582440221085265. https://doi.org/10.1177/21582440221085265.
   * https://www.kaggle.com/datasets/heesoo37/120-years-of-olympic-history-athletes-and-results
   
## Set-up tasks

* land acknowledgement
* Quiz/terminology intro (for completion credit)? e.g. coverage, likelihood profile, model misspecification, pseudoreplication, p-hacking/snooping/HARKing, post-selection inference, ... ?
* keep working on lin models (consult Faraway)
* Zoom meeting?
* clean up Makefiles?
* homework/test scheduling

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

## Linear modeling machinery

* model matrices
* general linear model
* understanding coefficients
   * contrasts
       * orthogonality
   * principle of marginality
* contrasts notes from 4C03, plus comparisons vignette of emmeans
* emmeans, effects, marginaleffects
