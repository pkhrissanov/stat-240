############################################################
# BASE R GRAPHING NOTES
# Everything you need for exams / assignments
############################################################

############################################################
# BASIC PLOT FUNCTION
############################################################

# General syntax:
plot(x, y)

# Example:
x <- 1:10
y <- x^2

plot(x, y)

# This creates a scatterplot by default.


############################################################
# IMPORTANT ARGUMENTS
############################################################

plot(x, y,
     main = "Title",      # title
     xlab = "X label",    # x axis label
     ylab = "Y label",    # y axis label
     col = "blue",        # color
     pch = 16,            # point shape
     cex = 1.5,           # point size
     xlim = c(0, 12),     # x axis limits
     ylim = c(0, 120),    # y axis limits
     type = "p"           # plot type
)

############################################################
# COMMON PLOT TYPES
############################################################

# "p" = points (default)
plot(x, y, type = "p")

# "l" = line
plot(x, y, type = "l")

# "b" = both points and line
plot(x, y, type = "b")

# "o" = overplotted points and line
plot(x, y, type = "o")

# "h" = vertical lines
plot(x, y, type = "h")

# "n" = no points (blank plot)
plot(x, y, type = "n")


############################################################
# ADDING THINGS TO EXISTING PLOT
############################################################

# points()
points(x, y, col = "red", pch = 16)

# lines()
lines(x, y, col = "blue", lwd = 2)

# abline() → add straight line
abline(a = 0, b = 1)  # intercept and slope

# horizontal line
abline(h = 10)

# vertical line
abline(v = 5)


############################################################
# LINEAR REGRESSION EXAMPLE (IMPORTANT)
############################################################

# Sample data
x <- c(1, 2, 3, 4, 5)
y <- c(2, 4, 5, 4, 6)

# Plot points
plot(x, y,
     main = "Linear Regression Example",
     xlab = "x",
     ylab = "y",
     pch = 16,
     col = "blue")

# Fit regression model
model <- lm(y ~ x)

# Add regression line
abline(model, col = "red", lwd = 2)

# This is equivalent to:
# abline(a = intercept, b = slope)


############################################################
# EXTRACT INTERCEPT AND SLOPE
############################################################

coef(model)

# intercept
coef(model)[1]

# slope
coef(model)[2]


############################################################
# PREDICT VALUES
############################################################

predict(model)

# predict at specific x values
predict(model, newdata = data.frame(x = c(6, 7, 8)))


############################################################
# MULTIPLE LINES ON SAME PLOT
############################################################

plot(x, y, pch = 16)

y2 <- x^2

lines(x, y2, col = "red", lwd = 2)


############################################################
# LEGEND
############################################################

legend("topleft",
       legend = c("Data", "Regression line"),
       col = c("blue", "red"),
       pch = c(16, NA),
       lty = c(NA, 1))


############################################################
# GRID
############################################################

grid()


############################################################
# HISTOGRAM
############################################################

hist(y,
     main = "Histogram",
     col = "lightblue",
     breaks = 10)


############################################################
# BOXPLOT
############################################################

boxplot(y,
        main = "Boxplot",
        col = "lightgreen")


############################################################
# IMPORTANT EXAM PATTERN
############################################################

# THIS IS VERY COMMON:

x <- c(1, 2, 3, 4, 5)
y <- c(2, 4, 5, 4, 6)

plot(x, y)

model <- lm(y ~ x)

abline(model)


############################################################
# CUSTOMIZING POINT SHAPES (pch)
############################################################

# common values:
# 16 = solid circle
# 1  = hollow circle
# 17 = triangle
# 15 = square

plot(x, y, pch = 17)


############################################################
# SAVE PLOT TO FILE
############################################################

png("plot.png")

plot(x, y)

abline(model)

dev.off()


############################################################
# KEY FUNCTIONS SUMMARY (MEMORIZE)
############################################################

# plot()     → create plot
# points()   → add points
# lines()    → add line
# abline()   → add straight line / regression line
# lm()       → fit regression
# coef()     → get slope/intercept
# predict()  → predict values
# legend()   → add legend
# hist()     → histogram
# boxplot()  → boxplot
# grid()     → grid lines

############################################################