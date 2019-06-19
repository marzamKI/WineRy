##########
### Script for matching wines from systembolaget to Vinmonopolet
### 
### 
###
### Anders K. Krabberoed 19. june 2019
###########
library(readr)
library(tidyverse)

#monopolet_selection<-read_csv("data/vinmonopolet.csv")
#systemet_selection<-read_csv("data/systembolaget_with_scores.csv")

# Initiate the variables
systemet_selection$taste_bitternes <- NA
systemet_selection$taste_body <- NA
systemet_selection$taste_freshness <- NA
systemet_selection$taste_sweetnes <- NA
systemet_selection$taste_tanins <- NA


start<-Sys.time()

for (i in 1:10) {
  
  first_selection<-grep(systemet_selection[i,]$name_1,monopolet_selection$product_name)
  # print("first\n")
  # print(length(first_selection))
  # #second_selection<-grep(systemet_selection[i,]$name_2,monopolet_selection[first_selection,]$title) #CHEKC FOR NA
  # second_selection<-grep(systemet_selection[i,]$name_2,monopolet_selection[first_selection,]$product_name)
  # print("second")
  # print(length(second_selection))
  
  
  systemet_selection[i,]$taste_bitternes <- monopolet_selection[first_selection[1],]$taste_bitternes
  systemet_selection[i,]$taste_body <- monopolet_selection[first_selection[1],]$taste_body
  systemet_selection[i,]$taste_freshness <- monopolet_selection[first_selection[1],]$taste_freshness
  systemet_selection[i,]$taste_sweetnes <- monopolet_selection[first_selection[1],]$taste_sweetnes
  systemet_selection[i,]$taste_tanins <- monopolet_selection[first_selection[1],]$taste_tanins

}
end<-Sys.time()

#write_csv(systemet_selection,"data/wine_data_score_taste.csv")
