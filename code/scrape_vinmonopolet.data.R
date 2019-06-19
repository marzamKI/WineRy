##########
### Script for matching wines from systembolaget to Vinmonopolet
### 
### 
###
### Anders K. Krabberoed 19. june 2019
###########
library(readr)
library(tidyverse)
#write_csv(as.data.frame(new_name_syst),"grep.patterns.csv")

start<-Sys.time()

for (i in 1:9007) {
  print(i)
  first_selection<-grep(systemet_selection[i,]$name_1,monopolet_selection$product_name)
  #print(first_selection)
  second_selection<-grep(systemet_selection[i,]$name_2,monopolet_selection[first_selection,]$title) #CHEKC FOR NA
  #second_selection<-grep(systemet_selection[i,]$producer,monopolet_selection[first_selection,]$producer)
  print(second_selection)
  #first_points<-mean(wino[first_selection,]$points)
  #second_points<-mean(wino[second_selection,]$points)
  # cat(
  #   "points: ",points,
  #   "max: ",max(points)," \n",
  #   "min: ",min(points)," \n"
  #   )
  # if (second_points != "NaN"){
  #   systemet_selection[i,]$taste<-second_points
  # }else{
  #   systemet_selection[i,]$taste<-first_points
  # }
}
end<-Sys.time()

#write_csv(systemet_selection,"data/wine_data_score_taste.csv")
