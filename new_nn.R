library(grid)
library(MASS)
library(neuralnet)
library(nnet)
###### Normal ANN ######
# Load the data
poly2_signal75_problem1 <- "add your file path"

# Show the relationship of the treatment and interventional data
plot(poly2_signal75_problem1[,26],poly2_signal75_problem1[,27])

# Preprocess the data
maxs <- apply(poly2_signal75_problem1[1:800,], 2, max) 
mins <- apply(poly2_signal75_problem1[1:800,], 2, min)
means <- apply(poly2_signal75_problem1[1:800,],2,mean)
scaled <- as.data.frame(scale(poly2_signal75_problem1[1:800,], center = means, scale = maxs - mins))
train_Z <- scaled[1:800,1:25]
train_X <- as.matrix(scaled[1:800,26])
train_Y <- as.matrix(scaled[1:800,27])
train_XYZ <- scaled[1:800,1:27]

# Build the neural networks for XYZ
n <- names(train_XYZ)
fun <- as.formula(paste("V27 ~", paste(n[!n %in% "V27"], collapse = " + ")))
nn_XYZ <- neuralnet(fun,hidden = c(40),data = train_XYZ,linear.output = F)
plot(nn_XYZ)

# Use the NN model for the training dataset
means <- matrix(0,800,1)
for (i in 1:800){
  X_vector <- train_X[i]*matrix(1,800,1)
  XZ_matrix <- cbind(train_Z,X_vector)
  pred_XYZ <- compute(nn_XYZ,XZ_matrix)
  means[i] <- mean(pred_XYZ$net.result)
}

f_hat_in <- means*(max(poly2_signal75_problem1$V27[1:800])-min(poly2_signal75_problem1$V27[1:800]))+mean(poly2_signal75_problem1$V27[1:800])
MSE_nn_in <- sum((poly2_signal75_problem1$V28[1:800] - f_hat_in)^2)/800


# testing dataset
# scaling the testing data
test_maxs <- apply(poly2_signal75_problem1[801:1000,], 2, max) 
test_mins <- apply(poly2_signal75_problem1[801:1000,], 2, min)
test_means <- apply(poly2_signal75_problem1[801:1000,],2,mean)
test_scaled <- as.data.frame(scale(poly2_signal75_problem1[801:1000,], center = test_means, scale = test_maxs - test_mins))
test_Z <- test_scaled[,1:25]
test_X <- test_scaled[,26]
test_Y <- test_scaled[,27]
test_XZ <- test_scaled[,1:26]

# Build the neural networks for testing
means_test <- matrix(0,200,1)
for (i in 1:200){
  X_vector_test <- test_X[i]*matrix(1,800,1)
  XZ_matrix_test <- cbind(train_Z,X_vector_test)
  pred_XYZ_test <- compute(nn_XYZ,XZ_matrix_test)
  means_test[i] <- mean(pred_XYZ_test$net.result)
}
# Evaluation by MSE
f_hat_in_test <- means_test*(max(poly2_signal75_problem1$V27[801:1000])-min(poly2_signal75_problem1$V27[801:1000]))+mean(poly2_signal75_problem1$V27[801:1000])
MSE_nn_in_test <- sum((poly2_signal75_problem1$V27[801:1000] - f_hat_in_test)^2)/200


plot(poly2_signal75_problem1[801:1000,26],poly2_signal75_problem1[801:1000,28],col='red',main = "Advanced Neural Network", xlab = "treatment",ylab = "outcome")
points(poly2_signal75_problem1[801:1000,26],f_hat_in_test)


