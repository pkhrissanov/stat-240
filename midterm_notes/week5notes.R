
library(RSQLite)
# more sql stuff ----------------------------------------------------------

dbSendQuery(db, "SELECT col1, col2, col3, FROM table WHERE specfic < value")
#when want to 


#when wanting to look for non-numeric data, must use single quotes
request <- dbSendQuery(
  db,
  "SELECT *
  FROM diamonds
  WHERE clarity = 'SI2' "
)
head(dbFetch(request))

#how to find collumn names and types in a table without SELECT
request <- dbSendQuery(db, "pragma table_info('sales')")
dbFetch(request)

#wildcard 
request <- dbSendQuery(db, "SELECT * FROM sales
WHERE StockCode = '71053' AND
InvoiceDate LIKE '2011-05%'")
# % will match anything afterwards. 


#should use this instead of paste0 for sendquery: 

library(DBI)
query <- sqlInterpolate(db, "SELECT SUM(Quantity) FROM sales
                        WHERE StockCode = '71053' AND
                        InvoiceDate LIKE ?month",
                        month = paste0(months[i], "%")
)


#how to do sql interprolate well 
library(DBI)
con <- dbConnect(RSQLite::SQLite(), ":memory:")
sql <- "SELECT * FROM users WHERE name = ?name AND age > ?age"
query <- sqlInterpolate(con, sql, name = "John", age = 25)
# Output: SELECT * FROM users WHERE name = 'John' AND age > 25






request <- dbSendQuery(db, query)



a <- 2  
b  <- 0.5   
x <- c(0, 1, 2, 3, 4, 5)
y <- c(2.1, 2.4, 3.2, 3.9, 4.1, 4.8)

#sum of least squares. 
SSE <- function(alpha, beta, x, y){
  sum((y - (alpha + beta * x))^2)
}


SSE <- function(alpha, beta, x, y){
  result <- 0
  
  for(i in 1:length(x)){
    result <- result + (y[i] - (alpha + beta * x[i]))^2
  }
  
  return(result)
}



# linear model function  --------------------------------------------------

df <- data.frame(
  x = c(1,2,3,4,5),
  y = c(2,4,5,4,5)
)


lin_model <- lm(y ~ x, data = df)
#how to extract alpha and beta

a <- as.numeric(coef(lin_model)[1]) #intercept, or alpha
b <- as.numeric(coef(lin_model)[2]) #slope, or beta
c <- (a+b)
c



#or can do : 
xs <- c(1, 2, 3)
ys <- c(73, 42, 55)
model <- lm(y ~ x, data = data.frame(x = xs, y = ys))
alpha <- summary(model)$coefficients[1, 1]
beta <- summary(model)$coefficients[2, 1]
alpha










...