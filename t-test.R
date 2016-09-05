# Load the data
poly2_signal75_problem1 <- "add your file path"
NN_result_direct <- "add your file path"
NN_result_alternative <- "add your file path"
GP_results_alternative <- "add your file path"

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


