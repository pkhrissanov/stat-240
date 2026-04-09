likeleyhood <- function(prob,heads, tails){
  
  (prob^heads) * ((1-prob)^tails)
  
  
}
likeleyhood(.5,)


xs <- seq(0, 1, length.out = 100)
ys <- log((xs)^4 * (1 - xs)^2)

plot(xs, ys, ylab = "likelihood", xlab = "theta", type = "l")






alpha <- 2
beta <- 1
sigma <- 3
xs <- runif(10)
ys <- alpha + beta * xs + rnorm(10, sd = sigma)
plot(xs, ys, ylab = "y", xlab = "x")


set.seed(240)
K <- 3
mus <- c(-1, 1, 5)        # means
sigmas <- c(0.1, 1, 0.5)     # variances
varpi <- c(0.3, 0.35, 0.35)
N <- 1000
zs <- sample(K, size = N, replace = TRUE, prob = varpi)


xs <- rep(NA, N)
for (k in 1:K) {
  xs[zs == k] <- rnorm(sum(zs == k), 
                       mean = mus[k], 
                       sd = sqrt(sigmas[k]))
}
hist(xs, breaks = 50, col = "grey", border = "white",
     main = "1D Gaussian Mixture", xlab = "x")




library(EMCluster)

xmat <- matrix(xs, ncol = 1)

restarts <- 100
models <- vector("list", restarts)
lls <- rep(NA, restarts)

for (i in 1:restarts) {
  models[[i]] <- emcluster(xmat, simple.init(xmat, nclass = 3))
  lls[i] <- models[[i]]$llhdval
}

model <- models[[which.max(lls)]]


library(lubridate)
load("londonbills.RData")
date <- ymd(londonbills$Date)
count <- londonbills$deaths_all_causes
date <- date[!is.na(count)]
count <- count[!is.na(count)]
plot(date, count, main = "All deaths, London")



library(tidyverse)
data <- data.frame(date = date, count = count)
data$year <- lubridate::year(data$date)
binned <- data |>
  group_by(year) |>
  summarise(sum = sum(count))
ggplot(binned, aes(x = year, y = sum)) +
  ylab("Deaths") +
  geom_bar(stat = "identity")


floor_decade <- function(value) {
  return(value - value %% 10)
}
data$decade <- floor_decade(data$year)
binned <- data |>
  group_by(decade) |>
  summarise(count = sum(count))

ggplot(binned, aes(x = decade, y = count)) +
  ylab("Deaths") +
  geom_bar(stat = "identity") +
  ggtitle("All deaths by decade, London")
 


binned <- data |>
  group_by(year) |>
  summarise(count = sum(count))
ggplot(binned, aes(x = count)) +
  ylab("Yearly deaths") +
  geom_histogram()


restarts <- 100
xs <- data.frame(count = data$count)
m2s <- vector("list", restarts)
ll2s <- rep(NA, restarts)
for (i in 1:restarts) {
  m2s[[i]] <- emcluster(xs, simple.init(xs, nclass = 2))
  ll2s[i] <- m2s[[i]]$llhdval
}
m2 <- m2s[[which.max(ll2s)]]
print(m2$Mu)


m1s <- vector("list", restarts)
ll1s <- rep(NA, restarts)
for (i in 1:restarts) {
  m1s[[i]] <- emcluster(xs, simple.init(xs, nclass = 1))
  ll1s[i] <- m1s[[i]]$llhdval
}
m1 <- m1s[[which.max(ll1s)]]
print(m1$Mu)

N <- nrow(xs)
results <- data.frame(
  K = c("1", "2"),
  BIC = c(
    2 * log(N) - 2 * m1$llhdval,
    5 * log(N) - 2 * m2$llhdval
  )
)
kable(results, row.names = NA)



append1 <- function(n){
  x <- NULL
  for (i in 1:n){
    
    
    x <- c(x, i)
  }
  x
}

output <- append1(5)
output

lvec <- list(age=39,weight=165,height=176,hair=c("brown","medium"))



lvec$hair[[2]]
typeof(lvec)
as.vector(lvec)




