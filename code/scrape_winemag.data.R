##########
### Script for matching wines from systembolaget to Winemag data
### 
### 
###
### Anders K. Krabber??d 19. june 2019
###########


library(readr)
library(tidyverse)

# import the winemag data: 
wino <- read_csv("data/wine_rating.csv")

# import the systembolaget data (see Import_systembolaget.R)

start<-Sys.time()

#systemet_selection$score <- NA

# A loop that first looks up the name from Systembolaget from the winemag data
# then does a nested search with producer name for a better match
# The average score is recorded for wines that match

for (i in 1:9007) {
  print(i)
  first_selection<-grep(systemet_selection[i,]$name_1,wino$title)
  second_selection<-grep(systemet_selection[i,]$producer,wino[first_selection,]$title)
  
  first_points<-mean(wino[first_selection,]$points)
  second_points<-mean(wino[second_selection,]$points)
  if (second_points != "NaN"){
    systemet_selection[i,]$score<-second_points
  }else{
    systemet_selection[i,]$score<-first_points
  }
}
end<-Sys.time()
end-start #Time: 37.28418 mins

# Write the data
#write_csv(systemet_selection,"data/systembolaget.csv")
