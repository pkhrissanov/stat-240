
library(tidyverse)


ggplot(df, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10() +
  theme_classic() 

set.seed(123)
k <- 3
km <- kmeans(df |> select(gdpPercap, lifeExp), centers = k, nstart = 20)
df$cluster <- as.factor(km$cluster)



# Strings! ----------------------------------------------------------------

prices <- c("$12.50", "$7.00", "$105.99")
char_prices <- str_extract(prices, "\\d+\\.\\d+")
as.numeric(char_prices)
library(stringr)

ExampleText <- c("1 - small thing to do",
                 "2 - 2 big things that we're doing",
                 "Some Small things that were done 4 free - 333",
                 "four Things that we've done")
grep("that", ExampleText)
grep("small", ExampleText) #which elements have small (but not Small)   
grep("small", ExampleText, ignore.case = TRUE) #which elements have small or Small
grep("small", ExampleText, ignore.case = TRUE, value = TRUE) 
#which elements contain small, or Small, or smAll,...

grep("my_function", list.files("some_folder", full.names = TRUE), value = TRUE)
## Will return the files that contain "my_function"

fruit[str_detect(fruit, "^.{5}$")]
