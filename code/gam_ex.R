library(mgcv)
library(tidyverse); theme_set(theme_bw())
## diagnostics, plotting
library(gratia)   
library(DHARMa)
library(emmeans)  ## prediction with CIs
library(broom) ## model summary (with glimpse())

## check available smooths
apropos("smooth.construct")

## example investigating contents of an mgcv 'smooth' object:
##  see ?smooth.construct for more details
dd <- data.frame(x = seq(0, 1, length.out=100))
ss <- smooth.construct.bs.smooth.spec(s(x, bs = "bs"), data = dd, knots = NULL)
names(ss)
matplot(ss$X)
ss$null.space.dim
ss$knots
library(Matrix)
## S is a *list* of penalty matrices
image(ss$S[[1]])
## better representation (matrix-centric)
image(Matrix(ss$S[[1]]))

## fitting example:
plot(mpg ~ hp, data = mtcars)
## use all defaults (thin-plate spline; number of knots)
## from ?choose.k:
## When setting up models in the ‘mgcv’ package, using s or
##      te terms in a model formula, ‘k’ must be chosen: the defaults
##      are essentially arbitrary.
## (default for 1D smooths is k=10)
## see https://stats.stackexchange.com/a/565430/2126
m1 <- gam(mpg ~ s(hp), data = mtcars)
print(m1)
summary(m1)

## use REML instead of GCV
m2 <- update(m, method = "REML")
## switch from thin plate (tp) to B-spline (bs)
m3 <- update(m, . ~ s(hp, bs = "bs"), method = "REML")

## plot predicted smooths
hpvec <- with(mtcars, seq(min(hp), max(hp), length.out = 101))
plot(mpg ~ hp, data = mtcars)
lines(hpvec, predict(m, newdata = data.frame(hp = hpvec)))
lines(hpvec, predict(m2, newdata = data.frame(hp = hpvec)), col = 2, lwd =3 )
points(hpvec, predict(m3, newdata = data.frame(hp = hpvec)), col = 4)

## or, fancier:
pfun <- function(model, xvec = hpvec) {
    data.frame(hp = hpvec,
               mpg = predict(model, newdata = data.frame(hp = xvec)))
}
mod_list <- list(base = m1,
                 REML = m2,
                 `REML+bs` = m3)
pframe <- mod_list |> purrr::map_dfr(pfun, .id = "model")
ggplot(pframe, aes(hp, mpg)) +
    geom_line(aes(colour = model)) +
    geom_point(data = mtcars)

## what if we also want the confidence intervals for each model?
pfun2 <- function(model, xvec = hpvec) {
    emmeans(model, specs = ~hp, at = list(hp = xvec)) |>
        as_tibble() |>
        rename(mpg = emmean, lwr = lower.CL, upr = upper.CL)
}
pframe2 <- mod_list |> purrr::map_dfr(pfun2, .id = "model")
ggplot(pframe2, aes(hp, mpg)) +
    geom_line(aes(colour = model)) +
    geom_ribbon(aes(ymin = lwr, ymax = upr, fill = model),
                colour = NA, alpha = 0.25) +
    geom_point(data = mtcars)

## really very little difference in this case ...

## this doesn't work because the smooth is zero-centered
draw(m3, data = mtcars) + geom_point(data = mtcars, aes(y = mpg))

## but this does - *partial* residuals (not original data)
draw(m3, data = mtcars, residuals = TRUE)

## diagnostics ...
gam.check(m3)                ## base mgcv
appraise(m3)                 ## gratia
plot(simulateResiduals(m3))  ## DHARMa

## performance::check_model() doesn't work
##  Error in d[, !(names(data) %in% all.varying), drop = FALSE] : 
##   incorrect number of dimensions

## check adequacy of max basis dimension by hand
m4 <- summary(update(m3, . ~ s(hp, bs = "bs", k = 20)))

## compare basis associated with the thin-plate spline
ss_tp <- smooth.construct.tp.smooth.spec(s(x, bs = "tp"),
                                         data = dd, knots = NULL)
matplot(ss_tp$X, type = "l")

## GAMs with more than one smooth
m5 <- gam(mpg ~ s(hp) + s(wt), data = mtcars)
summary(m5)
draw(m5)
AIC(m1, m5)
concurvity(m5)

## tensor product smooth
m6 <- gam(mpg ~ te(hp,wt), data = mtcars)
summary(m6)

mod_list2 <- c(mod_list, list(add_wt = m5, tensor = m6))
mod_list2 |>
    map_dfr(glance, .id = "model") |>
    select(model, df, AIC, deviance) |>
    mutate(across(c(AIC, deviance), ~ . - min(.))) |>
    arrange(AIC)

## technically I shouldn't be comparing REML and GCV-based fits ...

                            
