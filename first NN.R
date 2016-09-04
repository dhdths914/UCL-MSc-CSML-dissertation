library(grid)
library(MASS)
library(neuralnet)
###### Normal ANN ######
# Load the data
poly2_signal75_problem1 <- read.csv('/Users/dhdths914/Documents/UCL-CSML/Project/GP/data-GP/poly2_signal75/problem1.csv',header = F)

# Preprocess the data
maxs <- apply(poly2_signal75_problem1[1:800,], 2, max) 
mins <- apply(poly2_signal75_problem1[1:800,], 2, min)
means <- apply(poly2_signal75_problem1[1:800,],2,mean)
scaled <- as.data.frame(scale(poly2_signal75_problem1[1:800,], center = means, scale = maxs - mins))
X <- scaled[,1:26]
Y <- scaled[,27]
n <- names(scaled)
fun <- as.formula(paste("V27 ~", paste(n[!n %in% "V27"], collapse = " + ")))

# Build the neural networks
nn <- neuralnet(fun,data = scaled,hidden = c(9,7,5,3),linear.output = T)
plot(nn)

# Predict the f-hat
pred <- compute(nn,X)

# Evaluation by MSE
f_hat <- pred$net.result*(max(poly2_signal75_problem1[1:800,27])-min(poly2_signal75_problem1[1:800,27]))+mean(poly2_signal75_problem1[1:800,27])
MSE_nn <- sum((poly2_signal75_problem1[1:800,27] - f_hat)^2)/nrow(f_hat)

# Visualization
plot(poly2_signal75_problem1[1:800,27],f_hat,col='red',main='Real vs predicted NN',pch=18,cex=0.7)
abline(0,1,lwd=2)

# T test 
t <- t.test(abs(f_hat-poly2_signal75_problem1[1:800,27]))
t

# testing
maxs_test <- apply(poly2_signal75_problem1[801:1000,], 2, max) 
mins_test <- apply(poly2_signal75_problem1[801:1000,], 2, min)
means_test <- apply(poly2_signal75_problem1[801:1000,],2,mean)
scaled_test <- as.data.frame(scale(poly2_signal75_problem1[801:1000,], center = means, scale = maxs - mins))
X_test <- scaled_test[,1:26]
Y_test <- scaled_test[,27]

# Predict the testing data
pred <- compute(nn,X_test)

# Evaluation by MSE
f_hat_test <- pred$net.result*(max(poly2_signal75_problem1[801:1000,27])-min(poly2_signal75_problem1[801:1000,27]))+mean(poly2_signal75_problem1[801:1000,27])
MSE_nn_test <- sum((poly2_signal75_problem1[801:1000,27] - f_hat)^2)/nrow(f_hat_test)











