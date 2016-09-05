# Load the data
X_test <- "add your file path"
Y_test <- "add your file path"
NN_all_IHDP <- "add your file path"
NN_college_IHDP  <- "add your file path"
NN_high_IHDP  <- "add your file path"
GP_all_IHDP <- "add your file path"
GP_college_IHDP  <- "add your file path"
GP_high_IHDP  <- "add your file path"

# compute the error
gp_error_all <- abs(GP_all_IHDP-Y_test)
gp_error_college <- abs(GP_college_IHDP-Y_test)
gp_error_high <- abs(GP_high_IHDP-Y_test)

nn_error_all <- abs(NN_all_IHDP-Y_test)
nn_error_college <- abs(NN_college_IHDP-Y_test)
nn_error_high <- abs(NN_high_IHDP-Y_test)

# compare which is better
# IHDP all
compare_result_all <- matrix(NA,19,1)
for (i in 1:19) {
  if (gp_error_all[i,1] - nn_error_all[i,1] < 0) { 
    compare_result_all[i,1] <- 0
  }else {
    compare_result_all[i,1] <-1
  }
}

# IHDP college
compare_result_college <- matrix(NA,19,1)
for (i in 1:19) {
  if (gp_error_college[i,1] - nn_error_college[i,1] < 0) { 
    compare_result_college[i,1] <- 0
  }else {
    compare_result_college[i,1] <-1
  }
}

# IHDP high school
compare_result_high <- matrix(NA,19,1)
for (i in 1:19) {
  if (gp_error_high[i,1] - nn_error_high[i,1] < 0) { 
    compare_result_high[i,1] <- 0
  }else {
    compare_result_high[i,1] <-1
  }
}

# binomial test
success_all <- sum(compare_result_all==1)
binomial_result_all <- binom.test(success_all,nrow(compare_result_all),p=0.5, alternative="two.sided",conf.level=0.95)
binomial_result_all

success_college <- sum(compare_result_college==1)
binomial_result_college <- binom.test(success_college,nrow(compare_result_college),p=0.5, alternative="two.sided",conf.level=0.95)
binomial_result_college

success_high <- sum(compare_result_high==1)
binomial_result_high <- binom.test(success_high,nrow(compare_result_high),p=0.5, alternative="two.sided",conf.level=0.95)
binomial_result_high

# bar chart
compare_result_all<-factor(compare_result_all, levels = c(0,1), labels = c("GP", "NN"))
compare_result_all <- table(compare_result_all)
barplot(compare_result_all,main="Bar plot for the number of winner (all)", xlab = "type",ylab = "count")

compare_result_college<-factor(compare_result_college, levels = c(0,1), labels = c("GP", "NN"))
compare_result_college <- table(compare_result_college)
barplot(compare_result_college,main="Bar plot for the number of winner (college)", xlab = "type",ylab = "count")

compare_result_high<-factor(compare_result_high, levels = c(0,1), labels = c("GP", "NN"))
compare_result_high <- table(compare_result_high)
barplot(compare_result_high,main="Bar plot for the number of winner (high school)", xlab = "type",ylab = "count")






