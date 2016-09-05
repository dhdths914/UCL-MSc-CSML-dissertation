library(grid)
library(MASS)
library(neuralnet)
library(nnet)
###### Normal ANN ######
# Load the data
all_IHDP <- "add your file path"
X_test <- "add your file path"
Y_test <- "add your file path"

# Preprocess the data
maxs <- apply(all_IHDP, 2, max) 
mins <- apply(all_IHDP, 2, min)
means <- apply(all_IHDP,2,mean)
scaled <- as.data.frame(scale(all_IHDP, center = means, scale = maxs - mins))
train_Z <- scaled[,3:20]
train_X <- as.matrix(scaled[,2])
train_Y <- as.matrix(scaled[,1])
train_XYZ <- scaled[,1:20]


n <- names(train_XYZ)
fun <- as.formula(paste("V1 ~", paste(n[!n %in% "V1"], collapse = " + ")))
nn_XYZ <- neuralnet(fun,hidden = c(20),data = train_XYZ,linear.output = F)
#plot(nn_XYZ)
means <- matrix(0,347,1)
for (i in 1:347){
  X_vector <- train_X[i]*matrix(1,347,1)
  Y_vector <- train_Y[i]*matrix(1,347,1)
  XZ_matrix <- cbind(X_vector,train_Z)
  pred_XYZ <- compute(nn_XYZ,XZ_matrix)
  means[i] <- mean(pred_XYZ$net.result)
}

# Evaluation by MSE
f_hat_in <- means*(max(all_IHDP$V1)-min(all_IHDP$V1))+mean(all_IHDP$V1)
MSE_nn_in <- sum((all_IHDP[,1] - f_hat_in)^2)/347


# testing dataset
test_maxs <- apply(X_test, 2, max) 
test_mins <- apply(X_test, 2, min)
test_means <- apply(X_test,2,mean)
test_scaled <- as.data.frame(scale(X_test, center = test_means, scale = test_maxs - test_mins))
test_X <- test_scaled



# Build the neural networks for testing
means_test <- matrix(0,19,1)
for (i in 1:19){
  X_vector_test <- test_X[i,1]*matrix(1,347,1)
  XZ_matrix_test <- cbind(X_vector_test,train_Z)
  pred_XYZ_test <- compute(nn_XYZ,XZ_matrix_test)
  means_test[i] <- mean(pred_XYZ_test$net.result)
}
# Evaluation by MSE
f_hat_in_test <- means_test*(test_maxs-test_mins)+test_means
MSE_nn_in_test <- sum((Y_test - f_hat_in_test)^2)/19

# plot
plot(X_test[,1],Y_test[,1],col='black',main='IHDP All Neural Network plot',pch=3,cex=0.7,xlab = 'treatment',ylab = 'outcome')
points(X_test[,1],f_hat_in_test,col='red')
