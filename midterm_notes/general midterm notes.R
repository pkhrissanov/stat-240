
# Basic R -----------------------------------------------------------------

df <-  data.frame(V1 = c(1, 2), V2 = c(3, 4), V3 = c(5, 6))
df$V1
#access all data in collunm



df[, c("V1", "V3")]
#access data in collumns

df[ , c(1, 1, 2)]



# Write Table  ------------------------------------------------------------


# Basics:
# write.table(x, file) writes x (data.frame/matrix/vector) to a text file.
# Defaults: sep=" " (space), row.names=TRUE, col.names=TRUE, quote=TRUE, na="NA", append=FALSE

# Common exports:
# Clean TSV (tab-separated):
# write.table(df, "out.tsv", sep="\t", row.names=FALSE, quote=FALSE, na="")
#
# Clean CSV (comma-separated) using write.table:
# write.table(df, "out.csv", sep=",", row.names=FALSE, col.names=TRUE, quote=TRUE, na="")

# Key args you must know:
# sep       -> column separator: " ", "\t", ",", ";"
# row.names -> writes rownames as first column (default TRUE) -> set FALSE to avoid extra column
# col.names -> header row (default TRUE)
# quote     -> quote strings/factors (default TRUE) -> FALSE to remove quotes
# na        -> how NA is written (default "NA")
# append    -> TRUE to add to end (often col.names=FALSE after first write)
# dec       -> decimal mark "." (write.csv2 uses dec="," and sep=";")
# fileEncoding -> e.g., "UTF-8" for accents

# Gotchas:
# Extra first column? -> row.names=TRUE (fix: row.names=FALSE)
# Not CSV/TSV?        -> forgot sep (fix: sep="," or "\t")
# Quotes everywhere?  -> quote=TRUE (fix: quote=FALSE)

# Read-back check (match settings):
# df2 <- read.table("out.tsv", sep="\t", header=TRUE)

# Related helpers:
# write.csv(df, "out.csv", row.names=FALSE)     # wrapper for common CSV export
# write.csv2(df, "out.csv")                     # sep=";" and dec="," (European format)





