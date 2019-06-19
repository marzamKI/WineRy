library(fmsb)

data=read.csv('data/vinmonopolet_taste.csv')
data <- data[128,2:6]

names(data) <- gsub("taste_", "", names(data))
substr(names(data), 1, 1) <- toupper(substr(names(data), 1, 1))

data=rbind(rep(1,5) , rep(0,5) , data)
data[3,] <- data[3,]/12

p <- radarchart( data  , axistype=1 , 
                 #custom polygon
                 pcol= "#F28C26",
                 pfcol=rgb(0.949, 0.549, 0.149, 0.3),
                 plwd=4 , plty=1,
                 #custom the grid
                 cglcol="grey", cglty=1, axislabcol="grey", cglwd=0.8,
                 #custom labels
                 vlcex=0.8 )

