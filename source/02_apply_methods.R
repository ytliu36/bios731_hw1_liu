## Wald confidence
wald_CI<-function(data, alpha=0.05){
  model<-lm(y~x, data = data)
  if (dim(summary(model)$coefficients)[1] == 1){
    return(c(NA,NA,NA,NA))
  }
  else{
    mean = summary(model)$coefficients[2,1]
    sd = summary(model)$coefficients[2,2]
    lCI = mean+qnorm(alpha/2)*sd
    uCI = mean+qnorm(1-alpha/2)*sd
    return(c(mean, sd, lCI, uCI))
  }
}
## nonparametric percentile
boot_np<-function(data, B, alpha = 0.05){
  boot_mean = rep(NA, B)
  model1<-lm(y~x, data = data)
  if (dim(summary(model1)$coefficients)[1] == 1){
    return(c(NA,NA,NA,NA))
  }else{
  for (i in 1:B){
    repeat{
      index <- sample(1:dim(data)[1], dim(data)[1], replace = TRUE)
      model<-lm(y~x, data = data[index,])

      if (dim(summary(model)$coefficients)[1] > 1) {
        boot_mean[i] <- summary(model)$coefficients[2,1]
        break
      }
    }
  }
  return(c(mean(boot_mean), sd(boot_mean), quantile(boot_mean, probs = c(alpha/2,1-(alpha/2)))))
  }
}
## nonparametric t interval
boot_t<-function(data, B, K, alpha = 0.05){
  boot_mean = tstar = rep(NA, B)
  model0<-lm(y~x, data = data)
  if (dim(summary(model0)$coefficients)[1] == 1){
    return(c(NA,NA,NA,NA))
  }
  else{
    beta_hat<-summary(model0)$coefficients[2,1]
    for(i in 1:B){
      repeat{
        index <- sample(1:dim(data)[1], dim(data)[1], replace = TRUE)
        model<-lm(y~x, data = data[index,])

        if (dim(summary(model)$coefficients)[1] > 1) {
          boot_mean[i] <- summary(model)$coefficients[2,1]
          break
        }
      }
      boot_mean_k<-rep(NA, K)
      for (j in 1:K){
        repeat {
          index_k <- sample(index, dim(data)[1], replace = TRUE)
          model_k <- lm(y ~ x, data = data[index_k,])

          if (dim(summary(model_k)$coefficients)[1] > 1) {
            boot_mean_k[j] <- summary(model_k)$coefficients[2,1]
            break
          }
        } ## need repeat because for small dataset, there's is probability of unable to fit lm
      }
      se_star<-sd(boot_mean_k)
      tstar[i]<-(boot_mean[i]-beta_hat)/se_star
    }
    t_quants = quantile(tstar, probs = c(alpha/2, 1-(alpha/2)))
    boot_beta = mean(boot_mean)
    se_beta_hat = sd(boot_mean)
    lCI = beta_hat - t_quants[2] *se_beta_hat
    uCI = beta_hat - t_quants[1] *se_beta_hat
    return(c(boot_beta, se_beta_hat, lCI, uCI))
  }

}


