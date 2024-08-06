
r =100

for (i in 1:r) {
  
  no <- i
  input.elements.no <- input_elements[[no]]
  
  
  # one_fold-model process -------------------------------------------------------

  #Function to obtain all information regarding the eblup.bhf for a simulation

  one_fold_start = Sys.time()
  one_fold_results <- one_fold_func(x = input.elements.no,
                          formul_one_fold = formul,
                          domains =  domains)

  one_fold_end = Sys.time()
  time_one_fold <- one_fold_start - one_fold_end
  one_fold_results[["time"]] <- time_one_fold
# 
#   save(one_fold_results,
#        file = paste0(mod,
#                      "/results/one_fold/one_fold_",
#                      sprintf("%03d", no),
#                      ".RData"))

  one_fold_results_est <- one_fold_results$ind %>% dplyr::select(domain = Domain, Mean, Head_Count, Poverty_Gap)
 # stopifnot(all(dim(one_fold_results_est) == c(50, 4)))
  # bhf.results.est$run <- 1
  one_fold_results_est$run <- no
  if (file.exists("one_foldEstimates_mod2.csv")) {
    write.table(
      one_fold_results_est,
      file = "one_foldEstimates_mod2.csv",
      append = T,
      row.names = F,
      col.names = F
    )
  } else{
    write.table(
      one_fold_results_est,
      file = "one_foldEstimates_mod2.csv",
      append = F,
      row.names = F,
      col.names = T
    )
  }

  
  
  
}
