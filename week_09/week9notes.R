library(tidyverse)
data <- read.csv("data.csv")
library(ggplot2)
ggplot(data, aes(x = x, y = y)) +
  theme_classic() +
  geom_point()

N <- dim(data)[1]
K <- 4
set.seed(240)
cluster <- sample(K, size = N, replace = TRUE)
data$cluster <- cluster
p <- ggplot(data, aes(x = x, y = y, color = as.factor(cluster))) +
  labs(color = "cluster") +
  theme_classic() +
  geom_point()
print(p)

mus <- matrix(NA, K, 3)
colnames(mus) <- c("x", "y", "cluster")
for (k in 1:K) {
  mus[k, 1] <- mean(data$x[data$cluster == k])
  mus[k, 2] <- mean(data$y[data$cluster == k])
  mus[k, 3] <- k
}
q <- p + geom_point(as.data.frame(mus), 
                    mapping = aes(x = x, y = y,
                                  color = as.factor(cluster)),
                    shape = 4, stroke = 1) +
  theme(legend.position = "none")
print(q)


set.seed(240)
result <- kmeans(data[, 1:2], 4, iter.max = 100)
data$cluster <- result$cluster
p <- ggplot(data, aes(x = x, y = y, color = as.factor(cluster))) +
  labs(color = "cluster") +
  theme_classic() +
  geom_point()
print(p)



#340 rows by 3 collumns

peng_scaled <- read.csv("peng_scaled.csv")
set.seed(100)
head(peng_scaled)
centroids <- sample_n(peng_scaled, size = 3)
centroids

my_dist  <- function(data, centroids){
  
  n_data <= nrow
  

}




fn <- "gatsby.txt"
s <- readChar(fn, file.info(fn)$size)
nchar(s) # Print number of characters in text
substring(s, 3504, 3775)

x <- strsplit(s, "\\s+")
length(x)
  
x <- unlist(x)
print(x[507:517])
length(x)

library(wordcloud)
word_counts <- table(x)
wordcloud(names(word_counts), word_counts) ## this is very slow
word_counts[101:107]

library(stopwords)
stopwords("en")[1:10]
x <- tolower(x) ## so Crazy and crazy the same
x <- x[!(x %in% stopwords("en"))]
word_counts <- table(x)
word_counts <- word_counts[word_counts >= 20] ## remove rare words
word_counts[101:110]
wordcloud(names(word_counts), word_counts)


library(stringr)
a <- c("apples x4", "bag of flour", "bag of sugar", "milk x2")
str_extract(a, "\\d") ## looking for digits

a <- c("apple", "banana", "pear", "pineapple")
str_detect(a, "a")
str_detect(a, "^a") ## starts with a
str_detect(a, "apple")
str_detect(a, "e$") ## ends in e

a <- c("one apple", "two pears", "three bananas")
str_replace(a, "[aeiou]", "-")


a <- c(
  "apples and oranges and pears and bananas",
  "pineapples and mangos and guavas"
)
str_split(a, " and ")


library(janeaustenr)
data("emma")
emma[1:4]
emma[106:108]

count <- 0 
for(i in length(emma)){
  if (str_detect(emma, "Emma")){
    count <- count + 1
  }

}


x <- strsplit(emma, "\\s+")
length(x)
emma <- unlist(emma)
emma
count <- 0 

for(i in length(emma)){
  if (str_detect(emma, "Emma")[i] == TRUE){
    count <- count + 1
  }
}
count

checks <- str_detect(emma, "Emma")

for(i in checks){
  
}




