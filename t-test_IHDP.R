# Load the data
X_test <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/new_data/IHDP data/X_test_2.csv',header=F)
Y_test <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/new_data/IHDP data/Y_test_2.csv',header=F)
NN_all_IHDP <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/new_data/NN IHDP/nn_IHDP_allresult.csv',header = F)
NN_college_IHDP  <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/new_data/NN IHDP/nn_IHDP_collegeresult.csv',header = F)
NN_high_IHDP  <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/new_data/NN IHDP/nn_IHDP_highresult.csv',header = F)
GP_all_IHDP <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/new_data/GP IHDP/GP_IHDP_all_results.csv',header = F)
GP_college_IHDP  <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/new_data/GP IHDP/GP_IHDP_college_results.csv',header = F)
GP_high_IHDP  <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/all_code/new_data/GP IHDP/GP_IHDP_highschool_results.csv',header = F)

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





