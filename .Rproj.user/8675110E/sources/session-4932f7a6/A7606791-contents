####################################################################
# Julia Wrobel
# January 2025
#
# This file produces simulations for linear regression under different data
# generating scenarios
####################################################################


library(tidyverse)


###############################################################
## define or source functions used in code below
###############################################################

source(here::here("source", "01_simulate_data.R"))
source(here::here("source", "02_apply_methods.R"))
source(here::here("source", "03_extract_estimates.R"))
###############################################################
## set simulation design elements
###############################################################

# how are you justifying nsim?
nsim = 475


n = c(10, 50, 100)
beta_true = c(0, 0.5, 2)
eps_dist = c("normal", "log-normal")

params = expand.grid(n = n,
                     n_sim = nsim,
                     beta_true = beta_true,
                     eps_dist = eps_dist)



# define simulation scenario
scenario = 1
params = params[scenario,]




###############################################################
## start simulation code
###############################################################

# generate a random seed for each simulated dataset
seed = floor(runif(nsim, 1, 10000))
results = as.list(rep(NA, nsim))

for(i in 1:nsim){


  set.seed(seed[i])

  ####################
  # simulate data
  simdata = get_simdata(n = params$n,
                        beta_treat = params$beta_true,
                        eps_dist = params$eps_dist)

  ####################
  # apply method(s)

  ####################
  # calculate estimates


  ####################
  # store results, including estimates, speed, parameter scenarios


}

####################
# save results
# note that I am saving results outside of the for loop. For slow simulations,
  # you may want to save each iteration separately
filename = paste0("scenario_", scenario, ".RDA")
save(results,
     file = here::here("results", filename))

