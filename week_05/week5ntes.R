library(RSQLite)
db <- dbConnect(SQLite(), dbname = "week_05/shapes.sqlite")
dbListTables(db)
request_new <- dbSendQuery(
  db,
  "SELECT * FROM Platonic WHERE Sides > 5"
)
dbFetch(request_new, n = 1)
dbClearResult(request_new)

request <- dbSendQuery(
  db,
  "SELECT color,
  COUNT(*) AS n,
  AVG(carat) AS avg_carat
FROM diamonds
WHERE cut = 'Premium'
GROUP BY color;"
)
head(dbFetch(request), n = 7) ## only 7 colors here 







# Case Study --------------------------------------------------------------

library(RSQLite)
db <- dbConnect(SQLite(), dbname = "xcoretail.sqlite")
dbListTables(db)

request <- dbSendQuery(db, "SELECT * FROM sales")
dbFetch(request, n = 1)

dbClearResult(request)
request <- dbSendQuery(db, "SELECT * FROM prices")
dbFetch(request, n = 1)
dbClearResult(request)

request <- dbSendQuery(db, "pragma table_info('sales')")
dbFetch(request)


request <- dbSendQuery(db, "SELECT * FROM sales
                            WHERE StockCode = '71053' AND
                            InvoiceDate LIKE '2011-05%'")

data <- dbFetch(request)
dbClearResult(request)
dim(data)
unique(data$StockCode)
unique(data$InvoiceDate)
min(data$Quantity)
max(data$Quantity)
sum(data$Quantity)








months <- c("2011-02", "2011-03", "2011-04", "2011-05")
counts <- rep(NA, 4)
for (i in 1:4) {
  query <- paste0("SELECT SUM(Quantity) FROM sales
                  WHERE StockCode = '71053' AND
                  InvoiceDate LIKE '", months[i], "%'")
  request <- dbSendQuery(db, query)
  counts[i] <- dbFetch(request)
  dbClearResult(request)
}
  

plot(c(1, 2, 3), counts[-4],
     main = "Product 71053: 2011-05 order",
     ylab = "Units", xlab = "Month", pch = 19, xlim = c(0.5, 4.5),
     ylim = c(50, 350)
)
points(4, counts[4], pch = 3)


library(DBI)
query <- sqlInterpolate(db, "SELECT SUM(Quantity) FROM sales
                        WHERE StockCode = '71053' AND
                        InvoiceDate LIKE ?month",
                        month = paste0(months[i], "%")
)

request <- dbSendQuery(db, query)
...
dbDisconnect()




# Linear Regression -------------------------------------------------------

#sum of squaquares because fir both up and down 


xs <- c(1, 2, 3)
ys <- c(73, 42, 55)
model <- lm(y ~ x, data = data.frame(x = xs, y = ys))
alpha <- summary(model)$coefficients[1, 1]
beta <- summary(model)$coefficients[2, 1]
alpha




SSE <- function(alpha, beta, x, y){
  
                 
                 
  est_line <- alpha + beta *x
  SSE <- (y - est_line)^2
  
  
  
  
  
  
  
}
  
  
  
  












