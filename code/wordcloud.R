
library("wordcloud")
library("RColorBrewer")


z <- read.csv("systemet.csv")
x <- monopolet_renamed_1$country
y <- as.character(wino$country)

c(x,y) %>% sort() %>% unique()
pal <- brewer.pal(9,"BuGn")
pal <- brewer.pal(12, "Dark2")
wordcloud(c(x,y),vfont=c("gothic english","plain"),color=pal, random.color = T)
                