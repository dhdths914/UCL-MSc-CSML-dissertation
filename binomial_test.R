# Load the data
poly2_signal75_problem1 <- "add your file path"
NN_result_direct <- "add your file path"
NN_result_alternative <- "add your file path"
GP_results_alternative <- "add your file path"

# compute the error
gp_error_alter <- abs(GP_results_alternative-poly2_signal75_problem1[801:1000,28])
nn_error_alter <- abs(NN_result_alternative-poly2_signal75_problem1[801:1000,28])
nn_error_direct <- abs(NN_result_direct-poly2_signal75_problem1[801:1000,28])

# compare which is better
compare_result <- matrix(NA,200,1)
for (i in 1:200) {
  if (gp_error_alter[i,1] - nn_error_alter[i,1] < 0) { 
    compare_result[i,1] <- 0
   }else {
    compare_result[i,1] <-1
   }
}

# binomial test
success <- sum(compare_result==1)
binomial_result <- binom.test(success,nrow(compare_result),p=0.5, alternative="two.sided",conf.level=0.95)
binomial_result

# bar chart
compare_result<-factor(compare_result, levels = c(0,1), labels = c("GP", "NN"))
compare_result <- table(compare_result)
barplot(compare_result,main="Bar plot for the number of winner", xlab = "type",ylab = "count")


