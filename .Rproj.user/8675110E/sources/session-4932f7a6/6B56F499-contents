## Wald confidence
wald_CI<-function(data){
  model<-lm(y~x, data = data)
  return(summary(linear)$coefficients[2,1:2])
}
## nonparametric percentile
npara_per<-function(data, B){
  for (i in 1:B){
    ystar = sample(y_i, size = length(y_i), replace = TRUE)
    boot_mean[i] = mean(ystar, trim = 0.1)
  }

}
## nonparametric t interval
npara_t<-function(data, B, K){
  for(i in 1:B){
    ystar = sample(y_i, size = length(y_i), replace = TRUE)
    boot_mean[i] = mean(ystar, trim = 0.1)
    boot_mean2<-rep(NA, K)
    for (j in 1:K){
      ystar2 = sample(ystar, size = length(y_i), replace = TRUE)
      boot_mean2[j] = mean(ystar2, trim = 0.1)
    }
    se_star<-sd(boot_mean2)
    tstar[i]<-(boot_mean[i]-est)/se_star
  }
}


