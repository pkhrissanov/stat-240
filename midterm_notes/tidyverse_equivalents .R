# ============================================================
# TIDYVERSE -> BASE R CHEATSHEET (midterm-ready)
# Focus: dplyr/tidyr verbs + “check” questions (like sorted timestamps)
# ============================================================

# ----------------------------
# 0) SETUP NOTES / RULES
# ----------------------------
# Base R works with: df[rows, cols], df$col, with(df, ...), subset(), transform()
# Many “dplyr” tasks become: indexing + order() + aggregate()/tapply()/by()/merge()

# ============================================================
# 1) FILTER ROWS
# ============================================================

# dplyr: filter(df, age > 20)
# base:
df[df$age > 20, ]
subset(df, age > 20)

# dplyr: filter(df, age > 20, score >= 90)
# base:
df[df$age > 20 & df$score >= 90, ]
subset(df, age > 20 & score >= 90)

# dplyr: filter(df, name %in% c("A","C"))
# base:
df[df$name %in% c("A","C"), ]

# dplyr: filter(df, is.na(x))
# base:
df[is.na(df$x), ]

# ============================================================
# 2) SELECT / DROP COLUMNS
# ============================================================

# dplyr: select(df, age, score)
# base:
df[, c("age", "score")]
df[c("age", "score")]               # same (keeps data.frame)

# dplyr: select(df, -age)
# base:
df[, setdiff(names(df), "age")]
df[, -which(names(df) == "age")]

# dplyr: select(df, starts_with("temp"))
# base:
df[, grepl("^temp", names(df))]

# ============================================================
# 3) MUTATE (ADD / MODIFY COLUMNS)
# ============================================================

# dplyr: mutate(df, speed = distance / airtime)
# base:
df$speed <- df$distance / df$airtime

# dplyr: mutate(df, grade = if_else(score >= 90, "A", "B"))
# base:
df$grade <- ifelse(df$score >= 90, "A", "B")

# dplyr: mutate(df, z = scale(x))
# base:
df$z <- as.numeric(scale(df$x))     # scale() returns a matrix

# ============================================================
# 4) ARRANGE (SORT ROWS)
# ============================================================

# dplyr: arrange(df, score)
# base:
df[order(df$score), ]

# dplyr: arrange(df, desc(score))
# base:
df[order(-df$score), ]

# dplyr: arrange(df, age, desc(score))
# base:
df[order(df$age, -df$score), ]

# ============================================================
# 5) SUMMARISE + GROUP BY (AGGREGATION)
# ============================================================

# dplyr: df |> group_by(cut) |> summarise(n=n(), avg=mean(price))
# base (aggregate):
aggregate(price ~ cut, data=df, FUN=mean)
aggregate(price ~ cut, data=df, FUN=function(x) c(n=length(x), avg=mean(x)))
# NOTE: this returns a matrix column; you may need to split it.

# base (tapply) for one measure:
tapply(df$price, df$cut, mean)
tapply(df$price, df$cut, length)

# base (by) gives per-group results:
by(df$price, df$cut, mean)

# base (xtabs/table) counts:
table(df$cut)
xtabs(~ cut, data=df)

# Multiple grouping vars:
# dplyr: group_by(a,b) |> summarise(avg=mean(x))
aggregate(x ~ a + b, data=df, FUN=mean)

# ============================================================
# 6) DISTINCT / UNIQUE
# ============================================================

# dplyr: distinct(df, name)
# base:
unique(df["name"])
df[!duplicated(df["name"]), ]

# dplyr: distinct(df)  (unique rows)
# base:
unique(df)

# ============================================================
# 7) RENAME
# ============================================================

# dplyr: rename(df, new = old)
# base:
names(df)[names(df) == "old"] <- "new"

# ============================================================
# 8) JOINs (merge)
# ============================================================

# dplyr: left_join(df1, df2, by="id")
# base:
merge(df1, df2, by="id", all.x=TRUE)

# dplyr: inner_join
merge(df1, df2, by="id", all=FALSE)

# dplyr: full_join
merge(df1, df2, by="id", all=TRUE)

# dplyr: right_join
merge(df1, df2, by="id", all.y=TRUE)

# ============================================================
# 9) COUNT() + PROPORTIONS
# ============================================================

# dplyr: count(df, cut)
# base:
as.data.frame(table(df$cut))

# dplyr: count(df, cut, sort=TRUE)
tmp <- as.data.frame(table(df$cut))
tmp[order(-tmp$Freq), ]

# proportions:
prop.table(table(df$cut))

# ============================================================
# 10) SLICE / HEAD / TAIL / SAMPLE
# ============================================================

# dplyr: slice(df, 1:5)
df[1:5, ]

# dplyr: slice_max(df, score, n=5)
df[order(-df$score), ][1:5, ]

# random sample rows:
df[sample(nrow(df), 5), ]

# ============================================================
# 11) PIVOTING (TIDYR -> BASE)
# ============================================================

# pivot_longer (wide -> long):
# tidyr: pivot_longer(df, cols=c("1999","2000"), names_to="year", values_to="cases")
# base:
stack(df[c("1999","2000")])  # returns values + ind (column name)
# If you want to keep id columns too:
long <- cbind(df[setdiff(names(df), c("1999","2000"))],
              stack(df[c("1999","2000")]))
names(long)[names(long) == "ind"] <- "year"
names(long)[names(long) == "values"] <- "cases"

# pivot_wider (long -> wide):
# tidyr: pivot_wider(df, names_from=year, values_from=cases)
# base:
reshape(df, idvar="id", timevar="year", direction="wide")   # requires an id column

# separate/unite equivalents:
# separate(col, into=c("a","b"), sep="-") -> strsplit + do.call(rbind, ...)
parts <- do.call(rbind, strsplit(as.character(df$col), "-"))
df$a <- parts[,1]; df$b <- parts[,2]

# ============================================================
# 12) “CHECK” QUESTIONS (LIKE YOUR TIMESTAMP ONE)
# ============================================================

# A) Check if a vector is in non-decreasing order (sorted):
is_sorted <- function(x) all(diff(x) >= 0)

# If x is character times "HH:MM:SS", convert to POSIXct first:
# t <- as.POSIXct(df$timestamp, format="%H:%M:%S", tz="UTC")
# is_sorted(t)

# Your style (equivalent):
# all(sort(x) == x)   # works if no NAs and exact comparable
# safer:
all(order(df$timestamp) == seq_along(df$timestamp))  # TRUE if already sorted by timestamp

# B) Check strictly increasing (no ties):
is_strictly_increasing <- function(x) all(diff(x) > 0)

# C) Find where order breaks (helpful on tests):
which(diff(t) < 0)          # indices where it decreases
which(diff(t) <= 0)         # indices where not strictly increasing

# D) Check uniqueness:
all(!duplicated(df$timestamp))  # TRUE if all unique

# E) Check “no missing”:
all(!is.na(df$timestamp))

# ============================================================
# 13) NA HANDLING (IMPORTANT)
# ============================================================

# dplyr: drop_na(df)
# base:
df[complete.cases(df), ]

# dplyr: replace_na(list(x=0))
# base:
df$x[is.na(df$x)] <- 0

# Summaries ignoring NA:
mean(df$x, na.rm=TRUE)
sum(df$x, na.rm=TRUE)

# ============================================================
# 14) STRING TOOLS (COMMON IN DATA CLEANING)
# ============================================================

# str_detect(x, "abc") -> grepl("abc", x)
# str_replace(x, "a", "b") -> sub("a","b",x) (or gsub for all)
# str_to_lower -> tolower
# str_trim -> trimws
# paste/paste0 are base.

# ============================================================
# 15) QUICK “DPLYR PIPELINE” TRANSLATION TEMPLATE
# ============================================================

# dplyr:
# df |> filter(cond) |> select(cols) |> mutate(new=...) |> arrange(desc(x))

# base:
out <- df[df$cond, c("col1","col2")]
out$new <- ...
out <- out[order(-out$x), ]

# ============================================================
# If you want, paste your exact midterm-style prompt(s)
# and I’ll translate each tidyverse solution into base R.
# ============================================================