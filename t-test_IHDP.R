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

#t-test
t.test(gp_error_all,nn_error_all)
t.test(gp_error_college,nn_error_college)
t.test(gp_error_high,nn_error_high)





