# Load the data
poly2_signal75_problem1 <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/problem01.csv',header = F)
NN_result_direct <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/NN_direct_result.csv',header = F)
NN_result_alternative <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/nn_alternative_result.csv',header = F)
GP_results_alternative <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/GPresult.csv',header = F)

# compute the error
gp_error_alter <- abs(GP_results_alternative-poly2_signal75_problem1[801:1000,28])
nn_error_alter <- abs(NN_result_alternative-poly2_signal75_problem1[801:1000,28])
nn_error_direct <- abs(NN_result_direct-poly2_signal75_problem1[801:1000,28])

#t-test
t.test(gp_error_alter,nn_error_alter)
t.test(nn_error_direct,nn_error_alter)

#plot
plot(poly2_signal75_problem1[801:1000,28],as.matrix(GP_results_alternative),col='red',main='Real vs predicted GP',pch=3,cex=0.7)
abline(0,1)


