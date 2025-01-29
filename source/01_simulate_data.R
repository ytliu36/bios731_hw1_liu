# load libraries
library(tidyverse)


get_simdata = function(n, beta_treat, eps_dist){
  beta0 = 1
  x = rbinom(n, 1, prob = 0.5)
  if (eps_dist == "normal"){
    epsilon = rnorm(n, 0, sd = sqrt(2))
  }else if (eps_dist == "log-normal"){
    epsilon = rlnorm(n, 0, sd = sqrt(log(2)))
  }
  y = beta0 + beta_treat * x + epsilon

  tibble(
    x = x,
    y = y
  )

}



