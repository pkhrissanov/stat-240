library(RSQLite)
db <- dbConnect(SQLite(), dbname = "xcoretail.sqlite")
dbListTables(db)

library(DBI)
months <- sprintf("2011-%02d", 1:12)
counts <- rep(NA, 12)
for(i in 1:length(counts)) {
  query <- sqlInterpolate(db, "SELECT SUM(Quantity) FROM sales
                        WHERE StockCode = '71053' AND
                        InvoiceDate LIKE ?month",
                          month = paste0(months[i], "%") )
  request <- dbSendQuery(db, query)
  counts[i] <- as.numeric(dbFetch(request))
  dbClearResult(request)
}
plot(x = 1:12, y = counts, xlab = "Months", ylab = "Total Sales")

x <- 1:9
y <- counts[1:9]

fit <- lm(y ~ x)
fit

alpha_hat <- as.numeric(coef(fit)[1])
beta_hat <- as.numeric(coef(fit)[2])
alpha_hat
beta_hat
y_hat <- alpha_hat + beta_hat * 10
Error <- (y_hat - counts[10])^2
Error

house_sales <- read.csv("house_prices.csv")
plot(x = house_sales$area, y = house_sales$price, xlab = "Area (Sq ft)",
     ylab = "Sale Price")





set.seed(69420)
prop_train <- 0.7
prop_test <- 1 - prop_train

n_data <- nrow(house_sales)

train_test <- sample(c("Train", "Test"),
                     size = n_data, replace = TRUE, 
                     prob = c(prop_train, prop_test))
head(train_test)

train_data <- house_sales[train_test == "Train", ]
test_data <- house_sales[train_test == "Test",]

nrow(train_data)/n_data

fit_train <- lm(price ~ area, data = train_data)
fit_train

est_Y <- predict(fit_train, newdata = test_data)
head(est_Y)

RMSPE <- sqrt( mean( (est_Y - test_data$price) ^2) )
RMSPE



library(caret)

fit_knn <- knnreg(price ~ area, data = train_data, k = 50)
est_Y_knn <- predict(fit_knn, test_data)
head(est_Y_knn)
RMSPE_knn <- sqrt( mean( (est_Y_knn - test_data$price) ^2) )
RMSPE_knn









