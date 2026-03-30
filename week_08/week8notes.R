house_sales <- read.csv("house_prices.csv")


set.seed(240)
prop_train <- 0.7
prop_test <- 1 - prop_train

n_data <- nrow(house_sales)

train_test <- sample(c("Train", "Test"),
                     size = n_data, replace = TRUE, 
                     prob = c(prop_train, prop_test))

train_data <- house_sales[train_test == "Train", ]
test_data <- house_sales[train_test == "Test",]

#root mean squared is the score for the k nearest neighbours method....


# How to choose K  --------------------------------------------------------

#basically, take 4 chunnks of the training data, we make a k model for THAT new training set, test it with the last of the 
#old training data

#once we do this 5 times for the training data for a CERTAIN K, we can get the the mean RMPSE as the score for a K. we can get 
#the best k value by finding the lowest average RMPSE

library(caret)

set.seed(240)
CV_folds <- sample(1:5, size = nrow(train_data), replace = TRUE)
num_folds <- 5
CV_RMSPE <- rep(NA, num_folds)

for(i in 1:num_folds){
  cv_train <- train_data[CV_folds != i, ]
  cv_val <- train_data[CV_folds == i, ]
  fit_knn <- knnreg(price ~ area, data = cv_train, k = 10)
  cv_pred <- predict(fit_knn, cv_val)
  CV_RMSPE[i] <- sqrt( mean( (cv_pred - cv_val$price)^2) )
}

overall_RMSPE <- mean(CV_RMSPE)
overall_RMSPE





# finding the best k, based off a double loop -----------------------------

K_vals <- seq(from = 1, to = 125, by = 1)
K_RMSPE <- rep(NA, length(K_vals))
set.seed(100)

CV_folds <- sample(1:5, size = nrow(train_data), replace = TRUE)
num_folds <- 5

for(j in 1:length(K_vals)) {
  k <- K_vals[j]
  CV_RMSPE <- rep(NA, num_folds)
  
  for(i in 1:num_folds){
    cv_train <- train_data[CV_folds != i, ]
    cv_val <- train_data[CV_folds == i, ]
    fit_knn <- knnreg(price ~ area, data = cv_train, k = k)
    cv_pred <- predict(fit_knn, cv_val)
    CV_RMSPE[i] <- sqrt( mean( (cv_pred - cv_val$price)^2) )
  }
  K_RMSPE[j] <- mean(CV_RMSPE)
}

plot(K_RMSPE, type = "l")
which.min(K_RMSPE)














