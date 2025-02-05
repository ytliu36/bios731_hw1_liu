
get_estimates = function(res_wd, res_np, res_t, beta_true, start_wd, start_np, start_t, end_wd, end_np, end_t ){
  bias = c(res_wd[1], res_np[1], res_t[1])-beta_true
  se = c(res_wd[2], res_np[2], res_t[2])
  cover = c((beta_true>=res_wd[3] & beta_true<=res_wd[4]), (beta_true>=res_np[3] & beta_true<=res_np[4]), (beta_true>=res_t[3] & beta_true<=res_t[4]))
  time = as.numeric(c(end_wd-start_wd,end_np-start_np,end_t-start_t))
  return(c(bias, se, cover, time))
}
