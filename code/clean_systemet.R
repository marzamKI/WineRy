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

systemet_vin$APK <- parse_number(as.character(systemet_vin$Alkoholhalt))/systemet_vin$PrisPerLiter

write.csv(systemet_vin, "systemet_vin.csv")


## Vino
vino <- read.csv("data/vino.csv", header = T)
vino$binned <- cut(vino$points, breaks = 6, labels = 0:5)
vino$stars <- (vino$points-80)/(20) *5
