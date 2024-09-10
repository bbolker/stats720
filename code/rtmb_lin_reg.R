library(RTMB)
library(bbmle)

## make model matrix
X <- model.matrix(~ 1 + hp + cyl + wt, data = mtcars)

## assemble data
tmb_data <- list(X = X, y = mtcars$mpg)

## default/starting parameters

pars <- list(beta = c(20, rep(0, 3)), logsd = 0)
f <- function(pars) {
    getAll(tmb_data, pars)
    mu <- X %*% beta
    -sum(dnorm(y, mean = mu, sd = exp(logsd), log = TRUE))
}

## test
f(pars)

## autodiff version
ff <- RTMB::MakeADFun(f, pars, silent = TRUE)
ff$fn()  ## test

## optimize
fit_rtmb <- with(ff, nlminb(start = par, objective = fn, gradient = gr))

## fit linear model
fit_lm <- lm(mpg ~ 1 + hp + cyl + wt, data = mtcars)

rtmb_coefs <- as.list(sdreport(ff), "Est")

## check coefs
all.equal(unname(coef(fit_lm)),
          rtmb_coefs$beta, tolerance = 1e-7)


bench::mark(rtmb = with(ff, nlminb(start = par, objective = fn, gradient = gr)),
            lm = lm(mpg ~ 1 + hp + cyl + wt, data = mtcars),
            check = FALSE)

## could also try bbmle::mle2(), glm(), ...
