
# HOW TO READ IN FILES  ---------------------------------------------------
#if file is a simple csv, or any sort of value seperated file, can use:
read.csv(file, sep = "something")

#if file is two seperate files : 
stock_data <- read.table("AS-N100.data", header = FALSE)
columns <- readLines("AS-N100.names")
print(stock_data[1, "ticker"])
colnames(stock_data) <- colums 

#how to swap collum names: 

colnames(stock_data)[c(4, 10)] <- c("open", "tradecount")
google_stock <- stock_data[stock_data[, "ticker"] == "GOOGL", ]
print(min(google_stock[, "open"]))

#how to define functions: 
function_name <- function(parameter1, parameter2) {
  #some sort of code 
}