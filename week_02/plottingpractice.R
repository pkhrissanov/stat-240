subset <- data[data$ticker == "GOOGL" , ]
xs <- as.POSIXct(strptime(paste(
  "2015-11-15",
  subset$timestamp
), "%Y-%m-%d %H:%M:%S"))

ys <- subset$open
plot(xs, ys,
     xlab = "Time", ylab = "Price (USD)",
     main = "GOOGL open price / minute", type = "l"
)
