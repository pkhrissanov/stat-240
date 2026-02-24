
# SQL NOTS ----------------------------------------------------------------


library(RSQLite) #library that we use for SQL 

db <- dbConnect(SQLite(), dbname = "shapes.sqlite") #calls connection 
dbListTables(db) #lists tables inside of the database 
data <- dbReadTable(db, "Platonic") #create the data frame 
print(data)


# how to add datasets in a database ---------------------------------------
dbWriteTable(
  conn = db,
  name = "Diamonds",
  value = ggplot2::diamonds,
  row.names = FALSE,
  overwrite = TRUE
)

head(dbReadTable(db, "Diamonds"))

request <- dbExecute( db, "INSERT INTO Platonic VALUES ('Octahedron', 8)" ) #exectues sql code. 



# requesting data ---------------------------------------------------------

request <- dbSendQuery(
  db,
  "SELECT * FROM Platonic WHERE Sides > 5"
)
# the * means ALL 
#send Query prepares resutls 

data <- dbFetch(request)
#dbFetch puts results into a dataframe that R can actuall read. 
dbClearResult(request)
print(data)


#can also use dbGetQuery(db, "SQL QUERY")
#does both dbSend and dbFetch 


#how to paste in query with values we are not sure about yet. 
name <- "Octahedron"
sides <- 8
query <- paste0(
  "INSERT INTO Platonic VALUES ('", name,
  "', ", sides, ")"
)



# similar dplyr commands  -------------------------------------------------


# order by 
request_order <- dbSendQuery(
  db,
  "SELECT * FROM Diamonds ORDER BY price"
)
head(dbFetch(request_order))

#to make descending, add DESC to the end. 

# how to summarize by certain groups: 
request_avg <- dbSendQuery(
  db,
  "SELECT cut, COUNT(*) AS n, AVG(price) AS avg_price
  FROM diamonds
  GROUP BY cut"
)
head(dbFetch(request_avg))

# SELECT cut, # SELECT says show cut by group 
#COUNT(*) AS n,  COUNT(*) AS n counts all by group and stores as n. 
#AVG(price) AS avg_price #AVG is a SQL equivalent of mean(). stores as avg_price

# equivalent dplyr code: diamonds |> 
# group_by(cut) |> 
#  summarize(
#    n = n(),
#    avg_price = mean(price)
#  )













