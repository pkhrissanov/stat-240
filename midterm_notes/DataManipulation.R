# ============================================================
# BASE R DATA MANIPULATION — MIDTERM NOTES (NO TIDYVERSE)
# ============================================================

# Assume df is a data.frame
# df <- data.frame(name=c("A","B","C"), age=c(20,25,30), score=c(90,85,88))

# ============================================================
# 1. INSPECTING DATA
# ============================================================

head(df)        # first 6 rows
tail(df)        # last 6 rows
dim(df)         # number of rows, columns
nrow(df)        # number of rows
ncol(df)        # number of columns
names(df)       # column names
colnames(df)    # same as names()
str(df)         # structure (VERY IMPORTANT)
summary(df)     # summary statistics
class(df)       # object type

# ============================================================
# 2. SELECTING COLUMNS
# ============================================================

df$age                  # select single column (vector)
df[["age"]]             # same
df[, "age"]             # same

df[, c("age","score")]  # multiple columns
df[, 2]                 # select column by index
df[, -2]                # exclude column 2

# Keep as data.frame:
df[, "age", drop=FALSE]

# ============================================================
# 3. SELECTING ROWS
# ============================================================

df[1, ]        # first row
df[1:3, ]      # rows 1 to 3

df[df$age > 20, ]    # condition filter
df[df$name == "A", ]

# Multiple conditions:
df[df$age > 20 & df$score > 85, ]
df[df$age > 20 | df$score > 85, ]

# ============================================================
# 4. SELECTING ROWS AND COLUMNS TOGETHER
# ============================================================

df[df$age > 20, c("name","score")]

# ============================================================
# 5. ADDING COLUMNS
# ============================================================

df$newcol <- df$age * 2

df$passed <- df$score > 50

# Using transform():
df <- transform(df, bonus = score + 5)

# ============================================================
# 6. MODIFYING VALUES
# ============================================================

df$score[1] <- 100

df$score[df$score < 90] <- 90

# ============================================================
# 7. REMOVING COLUMNS
# ============================================================

df$age <- NULL

# OR
df <- df[, -2]

# ============================================================
# 8. RENAMING COLUMNS
# ============================================================

names(df)[2] <- "new_name"

# OR
colnames(df)[colnames(df) == "score"] <- "grade"

# ============================================================
# 9. ORDERING / SORTING
# ============================================================

df[order(df$score), ]         # ascending
df[order(-df$score), ]        # descending

# Multiple columns:
df[order(df$age, df$score), ]

# ============================================================
# 10. CREATING NEW DATA FRAMES
# ============================================================

newdf <- df[df$score > 85, ]

subset_df <- df[, c("name","score")]

# ============================================================
# 11. USING subset() FUNCTION
# ============================================================

subset(df, age > 20)

subset(df, age > 20, select=c(name, score))

# ============================================================
# 12. ADDING ROWS
# ============================================================

newrow <- data.frame(name="D", age=40, score=95)

df <- rbind(df, newrow)

# ============================================================
# 13. ADDING COLUMNS
# ============================================================

newcol <- c(1,2,3)

df <- cbind(df, newcol)

# ============================================================
# 14. REMOVING ROWS
# ============================================================

df <- df[-1, ]     # remove row 1

df <- df[df$age > 20, ]

# ============================================================
# 15. FINDING VALUES
# ============================================================

which(df$score > 90)

df[df$score == max(df$score), ]

# ============================================================
# 16. UNIQUE VALUES
# ============================================================

unique(df$name)

# ============================================================
# 17. COUNTING
# ============================================================

length(df$score)

table(df$name)

# ============================================================
# 18. APPLY FUNCTIONS
# ============================================================

mean(df$score)

sum(df$score)

min(df$score)

max(df$score)

# column means:
colMeans(df[, c("score")])

# row sums:
rowSums(df[, c("score")])

# ============================================================
# 19. CONDITIONAL CREATION
# ============================================================

df$grade <- ifelse(df$score >= 90, "A", "B")

# ============================================================
# 20. MERGING DATA FRAMES
# ============================================================

merge(df1, df2, by="id")

merge(df1, df2, by="id", all=TRUE)    # full join
merge(df1, df2, by="id", all.x=TRUE)  # left join
merge(df1, df2, by="id", all.y=TRUE)  # right join

# ============================================================
# 21. IMPORTANT INDEXING RULE
# ============================================================

# df[rows, columns]

df[2,3]         # row 2, column 3

df[,2]          # all rows, column 2

df[2,]          # row 2, all columns

# ============================================================
# 22. LOGICAL INDEXING (VERY IMPORTANT)
# ============================================================

condition <- df$score > 90

df[condition, ]

# ============================================================
# MOST IMPORTANT MIDTERM FUNCTIONS:
# ============================================================

# df[]
# df$col
# subset()
# order()
# merge()
# rbind()
# cbind()
# which()
# ifelse()
# names()
# str()

# These are the core base R manipulation tools.