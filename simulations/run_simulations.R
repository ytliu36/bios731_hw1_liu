####################################################################
library(tidyverse)
library(parallel)
library(doParallel)
library(foreach)
###############################################################
## define or source functions used in code below
###############################################################

source(here::here("source", "01_simulate_data.R"))
source(here::here("source", "02_apply_methods.R"))
source(here::here("source", "03_extract_estimates.R"))
###############################################################
## set simulation design elements
###############################################################
nsim = 100

n = c(10, 50, 100)
beta_true = c(0, 0.5, 2)
eps_dist = c("normal", "log-normal")

params = expand.grid(n = n,
                     n_sim = nsim,
                     beta_true = beta_true,
                     eps_dist = eps_dist)

num_cores <- detectCores() - 1  # Use all available cores except 1
cl <- makeCluster(num_cores)
registerDoParallel(cl)

###############################################################
## start simulation code
###############################################################
foreach(scenario = c(1:nrow(params)),.packages = c("dplyr")) %dopar% {
  set.seed(2025)
  params = params[scenario,]
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
    start_w <- Sys.time()
    wald_res <- wald_CI(simdata)
    end_w <- Sys.time()

    start_np <- Sys.time()
    boot_np_res <- boot_np(simdata, 500)
    end_np <- Sys.time()

    start_t <- Sys.time()
    boot_t_res <- boot_t(simdata, 250, 80)
    end_t <- Sys.time()
    ####################
    # calculate estimates & store results, including estimates, speed, parameter scenarios
    results[[i]] = get_estimates(wald_res, boot_np_res, boot_t_res, params$beta_true, start_w, start_np, start_t, end_w, end_np, end_t)

  }

  ####################
  # save results
  # note that I am saving results outside of the for loop. For slow simulations,
    # you may want to save each iteration separately
  filename = paste0("scenario_", scenario, ".RDA")
  save(results,
       file = here::here("data", filename))
}

# Stop the parallel backend
stopCluster(cl)
