# ============================================================
# RSQLite — MIDTERM NOTES + TEMPLATES (BASE R STYLE)
# ============================================================

# RSQLite lets you run SQL queries on SQLite databases from R.

# You MUST know these 5 functions:
# dbConnect()
# dbSendQuery()
# dbFetch()
# dbClearResult()
# dbDisconnect()

# Also useful:
# dbGetQuery()   # shortcut for send+fetch+clear

# ============================================================
# 1) LOAD LIBRARY
# ============================================================

library(RSQLite)

# ============================================================
# 2) CONNECT TO DATABASE
# ============================================================

# Connect to SQLite file:
db <- dbConnect(SQLite(), "database.sqlite")

# Connect to temporary database:
db <- dbConnect(SQLite(), ":memory:")

# Check connection:
db

# ============================================================
# 3) SEE TABLES IN DATABASE
# ============================================================

dbListTables(db)

# ============================================================
# 4) SEE COLUMNS IN TABLE
# ============================================================

dbListFields(db, "tablename")

# ============================================================
# 5) RUN SELECT QUERY (FULL METHOD)
# ============================================================

request <- dbSendQuery(db, "SELECT * FROM tablename")

data <- dbFetch(request)

dbClearResult(request)

# Now data is a data.frame

# ============================================================
# 6) SHORTCUT METHOD (VERY COMMON)
# ============================================================

data <- dbGetQuery(db, "SELECT * FROM tablename")

# dbGetQuery does ALL THREE steps:
# send + fetch + clear

# ============================================================
# 7) SELECT SPECIFIC COLUMNS
# ============================================================

data <- dbGetQuery(db,
                   "SELECT column1, column2
   FROM tablename"
)

# ============================================================
# 8) FILTER ROWS (WHERE)
# ============================================================

data <- dbGetQuery(db,
                   "SELECT *
   FROM tablename
   WHERE column1 > 10"
)

# Multiple conditions:
data <- dbGetQuery(db,
                   "SELECT *
   FROM tablename
   WHERE column1 > 10 AND column2 = 'ABC'"
)

# ============================================================
# 9) AGGREGATE FUNCTIONS (VERY TESTED)
# ============================================================

# COUNT rows:
dbGetQuery(db,
           "SELECT COUNT(*) FROM tablename"
)

# SUM:
dbGetQuery(db,
           "SELECT SUM(column1) FROM tablename"
)

# AVG:
dbGetQuery(db,
           "SELECT AVG(column1) FROM tablename"
)

# MIN / MAX:
dbGetQuery(db,
           "SELECT MIN(column1), MAX(column1)
   FROM tablename"
)

# ============================================================
# 10) GROUP BY (VERY IMPORTANT)
# ============================================================

dbGetQuery(db,
           "SELECT category, COUNT(*) AS n
   FROM tablename
   GROUP BY category"
)

# Multiple summaries:
dbGetQuery(db,
           "SELECT category,
          COUNT(*) AS n,
          AVG(price) AS avg_price
   FROM tablename
   GROUP BY category"
)

# ============================================================
# 11) ORDER RESULTS
# ============================================================

# Ascending:
dbGetQuery(db,
           "SELECT *
   FROM tablename
   ORDER BY column1"
)

# Descending:
dbGetQuery(db,
           "SELECT *
   FROM tablename
   ORDER BY column1 DESC"
)

# ============================================================
# 12) LIMIT RESULTS
# ============================================================

dbGetQuery(db,
           "SELECT *
   FROM tablename
   LIMIT 10"
)

# ============================================================
# 13) LIKE (PATTERN MATCHING) — VERY COMMON ON MIDTERMS
# ============================================================

# % means "anything after"
dbGetQuery(db,
           "SELECT *
   FROM tablename
   WHERE column1 LIKE 'ABC%'"
)

# Examples:
# 'ABC%'  starts with ABC
# '%ABC'  ends with ABC
# '%ABC%' contains ABC

# ============================================================
# 14) CREATE TABLE
# ============================================================

dbExecute(db,
          "CREATE TABLE test (
     id INTEGER,
     name TEXT
   )"
)

# ============================================================
# 15) INSERT DATA
# ============================================================

dbExecute(db,
          "INSERT INTO test VALUES (1, 'Alice')"
)

# ============================================================
# 16) WRITE R DATAFRAME TO DATABASE
# ============================================================

dbWriteTable(db, "newtable", df)

# Overwrite:
dbWriteTable(db, "newtable", df, overwrite=TRUE)

# Append:
dbWriteTable(db, "newtable", df, append=TRUE)

# ============================================================
# 17) REMOVE TABLE
# ============================================================

dbExecute(db, "DROP TABLE test")

# ============================================================
# 18) DISCONNECT DATABASE
# ============================================================

dbDisconnect(db)

# ============================================================
# 19) FULL TEMPLATE (MOST IMPORTANT)
# ============================================================

library(RSQLite)

# connect
db <- dbConnect(SQLite(), "database.sqlite")

# query
result <- dbGetQuery(db,
                     "SELECT column1, COUNT(*) AS n
   FROM tablename
   WHERE column2 > 10
   GROUP BY column1"
)

# use result in R:
head(result)

# disconnect
dbDisconnect(db)

# ============================================================
# 20) UNDERSTANDING dbSendQuery/dbFetch/dbClearResult
# ============================================================

request <- dbSendQuery(db, "SELECT * FROM tablename")

# request = query object

data <- dbFetch(request)

# data = data.frame result

dbClearResult(request)

# frees memory

# ============================================================
# 21) MIDTERM COMMON QUESTIONS
# ============================================================

# Get count:
dbGetQuery(db, "SELECT COUNT(*) FROM tablename")

# Get average grouped:
dbGetQuery(db,
           "SELECT group, AVG(value)
   FROM tablename
   GROUP BY group"
)

# Filter by pattern:
dbGetQuery(db,
           "SELECT *
   FROM tablename
   WHERE date LIKE '2011-02%'"
)

# Top 5 values:
dbGetQuery(db,
           "SELECT *
   FROM tablename
   ORDER BY value DESC
   LIMIT 5"
)

# ============================================================
# MOST IMPORTANT MIDTERM FUNCTIONS:
# ============================================================
# dbConnect()
# dbGetQuery()
# dbSendQuery()
# dbFetch()
# dbClearResult()
# dbDisconnect()
# dbListTables()
# dbListFields()
# dbWriteTable()
# dbExecute()