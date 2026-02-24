
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

request <- dbSendQuery(db, query)

a <- 2      # intercept
b  <- 0.5    # slope

x <- c(0, 1, 2, 3, 4, 5)

y <- c(2.1, 2.4, 3.2, 3.9, 4.1, 4.8)


#sum of least squares. 
SSE <- function(alpha, beta, x, y){
  sum((y - (alpha + beta * x))^2)
}

SSE(a, b, x, y)

SSE(a, b, x, y)

...