library(lme4)
lmer(Reaction ~ Days + (Days|Subject), sleepstudy)

priorpred <- stan_lmer(Reaction ~ Days + (Days|Subject),
                       prior_PD = TRUE, ## prior predictive simulation
                       data = sleepstudy,
                       seed = 101,
                       chains = 1)

prior_summary(priorpred)
plot(priorpred, pars = c("(Intercept)", "Days"))

stanfit <- stan_lmer(Reaction ~ Days + (Days|Subject),
                     data = sleepstudy,
                     cores = 4,
                     iter = 10000,
                     seed = 101,
                     chains = 4)

bayestestR::diagnostic_posterior(stanfit)
mcmc_trace(stanfit, regex_pars = "Sigma")
mcmc_rank_overlay(stanfit, regex_pars = "Sigma")

launch_shinystan(stanfit)

tidy(stanfit, c("fixed", "ran_pars"), conf.int = TRUE)

(as_draws(stanfit)
   |> tidyr::pivot_longer(everything())
   |> group_by(name)
   |> summarise(estimate = median(value),
                lwr = quantile(value, 0.025))
   |> filter(!stringr::str_detect(name, "^b\\["))
)

form1 <- Reaction ~ Days + (Days|Subject)
get_prior(form1, sleepstudy)  ## brms

b_prior <- set_prior("normal(0,10)", "b")
brm(form1, sleepstudy, seed = 101, 
    ## sample_prior = "only",
    prior = b_prior)
bb <- .Last.value
bb

m <- MCMCglmm(Reaction ~ Days,
              random = ~us(1+Days):Subject,
              data  = sleepstudy,
              prior = list(G=list(G1=list(V=diag(2), nu = 0.1))))

## options(error=recover)
options(error=NULL)
undebug(MCMCglmm:::priorformat)
