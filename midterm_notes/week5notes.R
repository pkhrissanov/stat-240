
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
...