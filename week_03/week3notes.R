stock_data <- read.table("AS-N100.data", header = FALSE)
columns <- readLines("AS-N100.names")
print(stock_data[1, "ticker"])
colnames(stock_data) <- columns
print(stock_data[1, "ticker"])
colnames(stock_data) <- columns
google_stock <- stock_data[stock_data[, "ticker"] == "GOOGL", ]
print(min(google_stock[, "open"]))
colnames(stock_data)[c(4, 10)] <- c("open", "tradecount")
google_stock <- stock_data[stock_data[, "ticker"] == "GOOGL", ]
print(min(google_stock[, "open"]))


x <- c(1, 7, 2, 9)
example <- data.frame()
for (v in c(9, 99, 999)) {
  x[4] <- v
  example <- rbind(example, c(median(x), mean(x), max(x)))
}
colnames(example) <- c("median", "mean", "max")
kable(example)


xs <- (google_stock$tradecount)
hist(xs,
     main = "GOOGL minutely on 2015-11-17", ylab = "Count",
     xlab = "Log number of trades"
)
abline(
  v = c(median(xs), mean(xs)), col = c("blue", "red"),
  lty = c(1, 2), lwd = c(2, 2)
)
legend("topleft", legend = c("median", "mean"), col = c(
  "blue",
  "red"
), lty = c(1, 2), lwd = c(2, 2))



xs <- google_stock$volume
hist(xs,
     main = "GOOGL minutely on 2015-11-17", ylab = "Count",
     xlab = "Number of trades"
)
abline(
  v = c(median(xs), mean(xs)), col = c("blue", "red"),
  lty = c(1, 2), lwd = c(2, 2)
)
legend("topright", legend = c("median", "mean"), col = c(
  "blue",
  "red"
), lty = c(1, 2), lwd = c(2, 2))




set.seed(240)
hist(rnorm(10000),
     freq = FALSE, ylim = c(0, .4), breaks = 25,
     xlab = "X", main = "Histogram of iid normal random variables"
)
xs <- seq(-4, 4, by = 0.1)
lines(xs, dnorm(xs))




## library ggplot2
ggplot(google_stock, aes(open, close)) +
  geom_point()


ggplot(google_stock, aes(open, close)) + geom_point() +
  labs(x = "Opening Price", y = "Closing Price",
       title = "Google Stock Price, November 17th 2015") +
  theme_bw()


google_stock$date_time <- as.POSIXct(strptime(paste(
  "2015-11-17",
  google_stock$timestamp
), "%Y-%m-%d %H:%M:%S"))

ggplot(google_stock, aes(x = date_time, y = open)) +
  geom_line() + theme_linedraw()

google_stock$change <- google_stock$close - google_stock$open
ggplot(google_stock, aes(change)) + geom_histogram() + theme_classic()


ggplot(data = mtcars, aes(x = cyl)) + geom_bar() +
  labs(title = "Count of Cars by Number of Cylinders",
       x = "Number of Cylinders", y = "Count of Cars") +
  theme_minimal()



#library(RColorBrewer)
tech <- c("TSLA", "NVDA")
tech_stocks <- stock_data[stock_data[, "ticker"] %in% tech, ] 

tech_stocks$date_time <- as.POSIXct(strptime(paste(
  "2015-11-17",
  tech_stocks$timestamp
), "%Y-%m-%d %H:%M:%S"))
p1 < - ggplot(tech_stocks, aes(date_time, tradecount, colour = ticker)) +
  geom_line() +
  scale_color_brewer(palette = "Set2") 



my_max <- function(v) {
  result <- -Inf
  for (i in 1:length(v)) {
    if (v[i] > result) {
      result <- v[i]
    }
  }
  return(result)
}
print(my_max(c(1, 7, 2, 9)))




install.packages("rjson")
library(rjson)
libraries <- fromJSON(file = "libraries.json")
print(class(libraries))


v1 <- c(1, 7)
v2 <- c(2, 9)
v3 <- list(v1, v2, p1) #this is to make a array of vectors. concatintion of vectors combines them into a single vector. 
print(v3)


 install.packages("imager")
library(imager)
image <- load.image("Figure02.png")
plot(image)





