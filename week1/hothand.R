#### Simple hot hand example code for week 1

data <- read.csv("shot_logs.csv")
## need to ensure you're looking for the csv file in the right place when
## running an R script like this
## I'm using an RStudio project to make this a bit easier here

data <- data[order(
  data$player_name, data$GAME_ID,
  data$PERIOD, data$SHOT_NUMBER
), ]



W <- 0
X <- 0
Y <- 0
Z <- 0
for (i in 2:dim(data)[1]) {
  if (data$SHOT_RESULT[i - 1] == "made") { # HOT
    if (data$SHOT_RESULT[i] == "made") {
      W <- W + 1
    } else {
      X <- X + 1
    }
  } else { # NOT
    if (data$SHOT_RESULT[i] == "made") {
      Y <- Y + 1
    } else {
      Z <- Z + 1
    }
  }
}


result <- data.frame(MADE = c(W, Y), MISSED = c(X, Z))
rownames(result) <- c("HOT", "NOT")
knitr::kable(result)
cat(sprintf("Scoring percent after making a shot: %.1f%%\n",
            100 * W / (W + X)))
cat(sprintf("Scoring percent after missing a shot: %.1f%%\n",
            100 * Y / (Y + Z)))
