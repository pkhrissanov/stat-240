set.seed(240)
theta <- 0.7
x <- rep(NA, 100)
coins <- sample(1:2, size = 100, replace = TRUE, prob = c(theta, 1 - theta))
coins[1:10]

for(i in 1:length(coins)) {
  if(coins[i] == 1) {
    x[i] <- rnorm(1, mean = 0, sd = 0.25)
  if(coins[i] == 2) {
    x[i] <- rnorm(1, mean = -5, sd = .5)
  }
  }
}

hist(x)


library(EMCluster)
restarts <- 100
models <- vector("list", restarts)
lls <- rep(NA, restarts)
for (i in 1:restarts) {
  models[[i]] <- emcluster(as.matrix(x), 
                           simple.init(as.matrix(x), nclass = 2))
  lls[i] <- models[[i]]$llhdval
}
model <- models[[which.max(lls)]]


