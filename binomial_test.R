# Load the data
poly2_signal75_problem1 <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/problem01.csv',header = F)
NN_result_direct <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/NN_direct_result.csv',header = F)
NN_result_alternative <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/nn_alternative_result.csv',header = F)
GP_results_alternative <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/GPresult.csv',header = F)

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


