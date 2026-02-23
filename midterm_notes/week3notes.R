
# How to read in multiple files into a single dataset ---------------------

stock_data <- read.table("AS-N100.data", header = FALSE)
columns <- readLines("AS-N100.names")
colnames(stock_data) <- columns #colnames sets the collum names for the file stock_data
print(stock_data[1, "ticker"])

#header specifies that there are no collumn names in the file. 

#when wanting to access a certain collumn or certain row: stock_data[row, collumn].  
#we can specifify the collumn and certain variable if needed. 

google_stock <- stock_data[stock_data[, "ticker"] == "GOOGL", ]


#if want to swap certain columns: 
colnames(stock_data)[c(4, 10)] <- c("open", "tradecount")
google_stock <- stock_data[stock_data[, "ticker"] == "GOOGL", ]


#median formula: 

# x_( ( n + 1 ) / 2 ) if n is odd. 
# ( x_( n / 2) + x_( ( n / 2 ) + 1) ) / 2 if n is even. 

#mean formula: 
# 1/n * sum(vector of values)



# how to define functions  ------------------------------------------------

function_name <- function(parameter){ 
  #some code
}



# How to make a vector of vectors -----------------------------------------
v1 <- c(1, 7)
v2 <- c(2, 9)
v3 <- list(v1, v2)
print(v3)





# how to read and manipulate json files  ----------------------------------

# install.packages("rjson")

library(rjson)
libraries <- fromJSON(file = "libraries.json")
print(class(libraries))

#can use nested lists to acces specific libraries


# how to plot images ------------------------------------------------------

library(imager)
image <- load.image("Figure02.png", axes = TRUE) #can specifify true or false depending on what want. 
plot(image)

#how to plot points 
W <- dim(image)[1]
H <- dim(image)[2]
plot(image, axes = FALSE)
points(W / 2, H / 2, col = "red", pch = 4, lwd = 5)  #pch is the shape of the point 
text(W / 2 + 125, H / 2, "Centre", col = "red")  

