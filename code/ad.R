## illustrations of differentiation/AD

e <- expression(cos(x)*(sin(x^2)))
## D() does _symbolic_ differentiation
##  (returns only the gradients requested; will
##   not re-use computations between the objective
##   function and gradient)
D(e, "x")

## deriv() does algorithmic/automatic diff
deriv(e, "x")

## returns a function that computes the objective
## function, gradient, and hessian
f1 <- deriv(e, "x", function.arg = "x", hessian = TRUE)
f1(2)

## Deriv::Deriv() is more flexible
library(Deriv)
f0 <- function(x) cos(x)*(sin(x^2))
f3 <- Deriv(f0, "x", nderiv = 0:2)
f3(2)

library(RTMB)

data(prussian, package = "pscl")
X2 <- model.matrix(~factor(year), data = prussian)
par2 <- list(beta = rep(0, ncol(X2)))
f2 <- function(pars) {
    RTMB::getAll(pars)
    mu <- exp(X2 %*% beta)
    -sum(dpois(prussian$y, lambda = mu, log  = TRUE))
}
f2(par2)

## the function passed to MakeADFun takes a list, but
##  the function *returned* by MakeADFun (as the $fn
##  element) takes a *vector*

## optim() (and other basic minimization functions
##  like nlminb(), nloptr::nlopt()) take the parameter
##  argument as a single vector
## 
## stats4::mle, bbmle::mle2 take the parameter argument
##  as a named list
##
## unlist(), relist() can help convert
ff2 <- RTMB::MakeADFun(f2, par2, silent = TRUE)
ff2$fn()  ## $fn() also stores default values *internally*
ff2$fn(unlist(par2))
ff2$gr(unlist(par2))

## have to work a bit harder to let mle2 use
##  an objective function where parameters are
##  stored as a vector: parnames<-, vecpar=TRUE
library(bbmle)
parnames(ff2$fn) <- names(unlist(par2))
system.time(bbmle::mle2(minuslogl = ff2$fn,
                        start = unlist(par2),
                        vecpar = TRUE,
                        gr = ff2$gr,
                        method = "BFGS"))

system.time(bbmle::mle2(y ~ dpois(exp(logmu)),
            parameters = list(logmu ~ factor(year)),
            data = prussian,
            start = list(logmu = 0),
            method = "BFGS"))
