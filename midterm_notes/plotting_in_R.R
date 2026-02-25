# ============================================================
# BASE R PLOTTING — MIDTERM NOTES + TEMPLATES (NO ggplot2)
# ============================================================

# Core idea:
# plot() makes a new plot.
# points(), lines(), abline(), text(), legend() ADD to an existing plot.

# ------------------------------------------------------------
# 0) QUICK “WHAT TYPE OF PLOT DO I USE?”
# ------------------------------------------------------------
# 1 numeric vector         -> hist(x), boxplot(x)
# 2 numeric vectors x,y     -> plot(x,y) (scatter)
# numeric y over index/time -> plot(y, type="l")
# numeric by group          -> boxplot(y ~ group), stripchart(y ~ group)
# counts of categories      -> barplot(table(cat))

# ============================================================
# 1) THE MOST IMPORTANT FUNCTION: plot()
# ============================================================

# Scatterplot:
# plot(x, y)  # x and y numeric vectors same length
plot(x, y)

# Customize labels + title + limits:
plot(x, y,
     main = "Title",
     xlab = "X label",
     ylab = "Y label",
     xlim = c(min(x), max(x)),
     ylim = c(min(y), max(y))
)

# Plot y vs index (1,2,3,...):
plot(y)

# Line plot:
plot(x, y, type="l")      # line
plot(x, y, type="p")      # points (default)
plot(x, y, type="b")      # both
plot(x, y, type="o")      # overplotted
plot(x, y, type="h")      # vertical lines (hist-like)

# ============================================================
# 2) ADDING TO A PLOT (THEY LOVE THIS ON TESTS)
# ============================================================

plot(x, y)                # make plot first
points(x2, y2)            # add more points
lines(x, y2)              # add a line
abline(h=0)               # horizontal reference line
abline(v=10)              # vertical reference line
abline(a=2, b=0.5)        # line: y = a + b*x
text(x, y, labels=id)     # label points
title(main="New Title")   # add/modify title

# Legend:
legend("topleft",
       legend=c("Group 1","Group 2"),
       lty=c(1,1), pch=c(1,1), bty="n")

# Grid:
grid()

# ============================================================
# 3) COMMON PLOTS YOU SHOULD KNOW
# ============================================================

# HISTOGRAM
hist(x, main="Histogram of x", xlab="x", breaks=10)

# BOX PLOT (numeric)
boxplot(x, main="Boxplot of x")

# BOX PLOT (numeric by group)
# group is a factor or character vector same length as y
boxplot(y ~ group, main="y by group", xlab="group", ylab="y")

# BAR PLOT (counts)
counts <- table(cat)
barplot(counts, main="Counts", xlab="Category", ylab="Frequency")

# DENSITY PLOT
d <- density(x, na.rm=TRUE)
plot(d, main="Density of x")
polygon(d)   # fill under curve (optional)

# ============================================================
# 4) MULTIPLE PLOTS IN ONE WINDOW (BASE R PANELS)
# ============================================================

par(mfrow=c(2,2))   # 2x2 grid of plots
plot(x, y)
hist(x)
boxplot(y)
barplot(table(group))
par(mfrow=c(1,1))   # reset to 1 plot

# ============================================================
# 5) PLOTTING BY GROUP (BASE R WAY)
# ============================================================

# A) Separate plots per group
# by() runs a function per group
by(df$y, df$group, summary)

# B) Overlay groups on one scatterplot (simple template)
g <- factor(group)
lev <- levels(g)

plot(x[g==lev[1]], y[g==lev[1]], xlab="x", ylab="y", main="y vs x by group")
for (k in 2:length(lev)) {
  points(x[g==lev[k]], y[g==lev[k]])
}
legend("topleft", legend=lev, pch=1, bty="n")

# (On midterms, they often don’t care about colors; focus on logic)

# ============================================================
# 6) TIME / ORDERED PLOTTING (COMMON)
# ============================================================

# If timestamp is "HH:MM:SS" convert to time:
t <- as.POSIXct(timestamp, format="%H:%M:%S", tz="UTC")

# Plot y over time (line):
ord <- order(t)
plot(t[ord], y[ord], type="l", xlab="time", ylab="y", main="y over time")

# Check sorted time (like your question):
all(diff(t[ord]) >= 0)  # TRUE
# If already sorted in df:
all(diff(t) >= 0)

# ============================================================
# 7) QUICK REGRESSION LINE ON A SCATTERPLOT
# ============================================================

plot(x, y, main="Scatter with regression line")
fit <- lm(y ~ x)
abline(fit)              # adds fitted line
# OR: abline(a=coef(fit)[1], b=coef(fit)[2])

# ============================================================
# 8) SAVING PLOTS TO A FILE (VERY TESTABLE)
# ============================================================

# PNG:
png("plot.png", width=800, height=600)
plot(x, y)
dev.off()

# PDF:
pdf("plot.pdf")
plot(x, y)
dev.off()

# ============================================================
# 9) CLEAN “MIDTERM TEMPLATES” (COPY/PASTE)
# ============================================================

# TEMPLATE A: BASIC SCATTER
# plot(x, y, main="...", xlab="...", ylab="..."); grid()

# TEMPLATE B: LINE PLOT
# plot(x, y, type="l", main="...", xlab="...", ylab="..."); grid()

# TEMPLATE C: HISTOGRAM
# hist(x, main="...", xlab="...", breaks=10)

# TEMPLATE D: BOXPLOT BY GROUP
# boxplot(y ~ group, main="...", xlab="group", ylab="y")

# TEMPLATE E: BARPLOT COUNTS
# barplot(table(cat), main="...", xlab="cat", ylab="count")

# ============================================================
# 10) ULTRA-IMPORTANT MIDTERM REMINDERS
# ============================================================
# - plot() creates new plot; points()/lines()/abline() add to it.
# - type="p" points, "l" lines, "b" both.
# - Always label axes: xlab, ylab, and add main if asked.
# - For “over time”, sort by time first (order()).