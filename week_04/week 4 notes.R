#can make table of contents. 

#yaml is the info about the file, can include data, tbc 









# Learning SQL  -----------------------------------------------------------

library(RSQLite)
db <- dbConnect(SQLite(), dbname = "shapes.sqlite")
data <- dbReadTable(db, "Platonic")
print(data)

dbListTables(db)
dbReadTable(db, "Platonic")

dbWriteTable(
  conn = db,
  name = "Diamonds",
  value = ggplot2::diamonds,
  row.names = FALSE,
  overwrite = TRUE
)

head(dbReadTable(db, "Diamonds"))


request <- dbExecute(
  db,
  "INSERT INTO Platonic VALUES ('Octahedron', 8)"
)
print(request)

request <- dbSendQuery(
  db,
  "SELECT * FROM Platonic WHERE Sides > 5"
)
data <- dbFetch(request)
dbClearResult(request)
print(data)


request_new <- dbSendQuery(
  db,
  "SELECT * FROM Platonic WHERE Sides > 5"
)
dbFetch(request_new, n = 1)


name <- "Octahedron"
sides <- 8
query <- paste0(
  "INSERT INTO Platonic VALUES ('", name,
  "', ", sides, ")"
)
query

