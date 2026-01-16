# Data from https://www.kaggle.com/datasets/dansbecker/ ...
#    nba-shot-logs
# "Data on shots taken during the 2014-2015 season ...
#   Scraped from NBA's REST API."

# Fixes problem where first shots of players or games were incorrectly counted.

data <- read.csv("shot_logs.csv")


data <- data[order(
  data$player_name, data$GAME_ID,
  data$PERIOD, data$SHOT_NUMBER
), ]

W <- 0
X <- 0
Y <- 0
Z <- 0
for (i in 2:dim(data)[1]) {
  if (data$GAME_ID[i - 1] == data$GAME_ID[i] && data$player_name[i - 1] == data$player_name[i]) {
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
}

result <- data.frame(MADE = c(W, Y), MISSED = c(X, Z))

cat(sprintf("Scoring percent after making a shot: %.1f%%\n", 100 * W / (W + X)))
cat(sprintf("Scoring percent after missing a shot: %.1f%%\n", 100 * Y / (Y + Z)))
example <- data.frame(HEADS = c(5, 3), TAILS = c(2, 7))
rownames(example) <- c("A", "B")
fisher.test(example)$p.value
