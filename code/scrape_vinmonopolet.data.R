##########
### Script for matching wines from systembolaget to Vinmonopolet
### 
### 
###
### Anders K. Krabberoed 19. june 2019
###########


library(readr)
library(tidyverse)

x<-list()
for (i in dim(wino)[1]) {
  x[i]<-grep(monopolet_selection$product_name[i], monopolet_renamed_1$product_name)
  
}
x<-grep("Faustino", monopolet_selection$product_name)
wino[123175,]$title


(s<-grep("Amarone della Valpolicella Classico", systemet_selection$name_2))
(v<-grep("Amarone della Valpolicella Classico", monopolet_selection$product_name))


View(wino[w,])
View(systemet_selection[s,])
View(monopolet_selection[v,])

new_name_syst<-paste(systemet_selection$name_1,systemet_selection$name_2) %>% str_remove(" NA")
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

systemet_selection$taste
grep(new_name_syst[112],monopolet_selection$product_name)

new_name_syst[112]
write_csv(systemet_selection,"data/systembolaget.csv")
