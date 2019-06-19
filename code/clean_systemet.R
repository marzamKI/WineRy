library(tidyverse)
library(maps)
library(mapdata)
library(ggmap)

## Only include wines - system bolaget data
systemet <- read.csv("systemet.csv", header = T, sep = ";")

#Get wine
vin <- grep("vin", x = systemet$Varugrupp, value = T, ignore.case = T)

#Get single bottles/boxes
a_fl <- c(grep("??", x = systemet$Forpackning, value = T, ignore.case = T),
          grep("??", x = systemet$Forpackning, value = T, ignore.case = T))

systemet_vin <- systemet %>% 
  filter(Varugrupp %in% vin) %>%
  filter(!Forpackning %in% a_fl) %>%
  filter(!Typ %in% c("Vodka", "Kryddat br??nnvin", "3 flaskor")) %>%
  select(-c("Saljstart", "Pant", "Leverantor", 
            "nr", "Varnummer", "Utg??tt", "Stil",
            "Provadargang", "Sortiment", "SortimentText"))

# Calc APK
systemet_vin$APK <- parse_number(as.character(systemet_vin$Alkoholhalt))/systemet_vin$PrisPerLiter

write.csv(systemet_vin, "systemet_vin.csv")


## Add star rating - Vino data
vino <- read.csv("data/vino.csv", header = T)
vino$binned <- cut(vino$points, breaks = 6, labels = 0:5)
vino$stars <- (vino$points-80)/(20) *5
levels(vino$country)[levels(vino$country)=="US"] <- "USA"

write.csv(vino, "vino.csv")

## Coord data - Map plot
map_locations <- map_data("world", region = levels(vino$country))
summary_vino <- vino %>% 
  filter(!is.na(country)) %>% 
  filter(!is.na(price)) %>%
  filter(!is.na(stars)) %>%
  group_by(country) %>% 
  summarise(mean_price = mean(price), 
            mean_point = mean(stars),
            size = length(country)) %>%
  rename(region = country)

wine_map <- inner_join(map_locations, summary_vino, by = "region")

write.csv(wine_map, "data/wine_map.csv")
