##########
### Script for importing and cleaning data from Systembolaget
### 
### 
###
### Anders K. Krabberød 19. june 2019
###########


library(readr)
library(tidyverse)

systemet <- read_delim("data/systemet.csv", 
                       ";", escape_double = FALSE, trim_ws = TRUE)

colnames(systemet)
#### renaming columns ####
systemet$Alkoholhalt<-systemet$Alkoholhalt %>% str_replace_all(.,pattern = "%", replacement = "") %>% as.numeric()
systemet_renamed<-systemet %>% rename(product_id=Artikelid,
                                        product_num=Varnummer,
                                        name_1=Namn,
                                        name_2=Namn2,
                                        price_sek=Prisinklmoms,
                                        recycling=Pant,
                                        volume=Volymiml,
                                        price_pr_litre_sek=PrisPerLiter,
                                        sale_start=Saljstart,
                                        expired=Utgått,
                                        sortiment=Varugrupp,
                                        type=Typ,
                                        style=Stil,
                                        packaging=Forpackning,
                                        seal=Forslutning,
                                        region=Ursprung,
                                        country=Ursprunglandnamn,
                                        producer=Producent,
                                        distribution=Leverantor,
                                        year=Argang,
                                        test_year=Provadargang,
                                        alcohol=Alkoholhalt,
                                        assortment=Sortiment,
                                        assortment_2=SortimentText,
                                        organic=Ekologisk,
                                        ethical=Etiskt,
                                        ethical_2=EtisktEtikett,
                                        koscher=Koscher,
                                        made_of=RavarorBeskrivning)

#### rename countries ####
systemet_renamed$country <- systemet_renamed$country %>% 
  str_replace("Antigua & Barbuda","Antigua & Barbuda")  %>% 
  str_replace("Argentina","Argentina")  %>% 
  str_replace("Armenien","Armenia")  %>% 
  str_replace("Australien","Australia")  %>% 
  str_replace("Barbados","Barbados")  %>% 
  str_replace("Belgien","Belgium")  %>% 
  str_replace("Belize","Belize")  %>% 
  str_replace("Bosnien-Hercegovina","Bosnia Herzegovina")  %>% 
  str_replace("Brasilien","Brazil")  %>% 
  str_replace("Bulgarien","Bulgaria")  %>% 
  str_replace("Chile","Chile")  %>% 
  str_replace("Colombia","Colombia")  %>% 
  str_replace("Cypern","Cyprus")  %>% 
  str_replace("Danmark","Denmark")  %>% 
  str_replace("Dominikanska Republiken","Dominican Republic")  %>% 
  str_replace("Ecuador","Ecuador")  %>% 
  str_replace("Eritrea","Eritrea")  %>% 
  str_replace("Estland","Estonia")  %>% 
  str_replace("EU","EU")  %>% 
  str_replace("Fiji","Fiji")  %>% 
  str_replace("Filippinerna","Philippines")  %>% 
  str_replace("Finland","Finland")  %>% 
  str_replace("Folkrepubliken Kina","China")  %>% 
  str_replace("Frankrike","France")  %>% 
  str_replace("Georgien","Georgia")  %>% 
  str_replace("Grekland","Greece")  %>% 
  str_replace("Grenada","grenada")  %>% 
  str_replace("Guatemala","Guatemala")  %>% 
  str_replace("Guyana","Guyana")  %>% 
  str_replace("Haiti","Haiti")  %>% 
  str_replace("Indien","India")  %>% 
  str_replace("Indonesien","Indonesia")  %>% 
  str_replace("Internationellt märke","International brand")  %>% 
  str_replace("Irland","Ireland")  %>% 
  str_replace("Island","Iceland")  %>% 
  str_replace("Israel","israel")  %>% 
  str_replace("Italien","Italy")  %>% 
  str_replace("Jamaica","Jamaica")  %>% 
  str_replace("Japan","Japan")  %>% 
  str_replace("Kanada","Canada")  %>% 
  str_replace("Kenya","Kenya")  %>% 
  str_replace("Kroatien","Croatia")  %>% 
  str_replace("Kuba","Cuba")  %>% 
  str_replace("Lettland","Latvia")  %>% 
  str_replace("Libanon","Lebanon")  %>% 
  str_replace("Litauen","Lithuania")  %>% 
  str_replace("Luxemburg","Luxembourg")  %>% 
  str_replace("Marocko","Morocco")  %>% 
  str_replace("Mauritius","mauritius")  %>% 
  str_replace("Mexiko","Mexico")  %>% 
  str_replace("Moldavien","Moldova")  %>% 
  str_replace("Montenegro","Montenegro")  %>% 
  str_replace("Namibia","Namibia")  %>% 
  str_replace("Nederländerna","Netherlands")  %>% 
  str_replace("Nigeria","Nigeria")  %>% 
  str_replace("Nordmakedonien","Macedonia")  %>% 
  str_replace("Norge","Norway")  %>% 
  str_replace("Nya Zeeland","New Zealand")  %>% 
  str_replace("Okänt ursprung","Unknown origin")  %>% 
  str_replace("Österrike","Austria")  %>% 
  str_replace("Övriga ursprung","Other origins")  %>% 
  str_replace("Panama","Panama")  %>% 
  str_replace("Paraguay","Paraguay")  %>% 
  str_replace("Peru","Peru")  %>% 
  str_replace("Polen","Poland")  %>% 
  str_replace("Portugal","Portugal")  %>% 
  str_replace("Rumänien","Romania")  %>% 
  str_replace("Ryssland","Russia")  %>% 
  str_replace("Saint Kitts & Nevis","Saint Kitts")  %>% 
  str_replace("Serbien och Montenegro","Serbia and Montenegro")  %>% 
  str_replace("Serbien","Serbia")  %>%
  str_replace("Slovakien","Slovakia")  %>% 
  str_replace("Slovenien","Slovenia")  %>% 
  str_replace("Spanien","Spain")  %>% 
  str_replace("Sri Lanka","Sri Lanka")  %>% 
  str_replace("St Lucia","St Lucia")  %>% 
  str_replace("Storbritannien","UK")  %>% 
  str_replace("Sverige","Sweden")  %>% 
  str_replace("Sydafrika","South Africa")  %>% 
  str_replace("Sydkorea","South Korea")  %>% 
  str_replace("Thailand","thailand")  %>% 
  str_replace("Tjeckien","Czech Republic")  %>% 
  str_replace("Trinidad","Trinidad")  %>% 
  str_replace("Tunisien","Tunisia")  %>% 
  str_replace("Turkiet","Turkey")  %>% 
  str_replace("Tyskland","Germany")  %>% 
  str_replace("Ukraina","Ukraine")  %>% 
  str_replace("Ungern","Hungary")  %>% 
  str_replace("Uruguay","uruguay")  %>% 
  str_replace("USA","US")  %>% 
  str_replace("Varierande ursprung","Varying origin")  %>% 
  str_replace("Venezuela","venezuela")  %>% 
  str_replace("Vietnam","Vietnam")
systemet_renamed$country %>% sort() %>% unique()
#c(systemet_renamed$country,monopolet_renamed_1$country) %>% sort() %>% unique()

systemet_renamed$apk<-systemet_renamed$alcohol/systemet_renamed$price_pr_litre_sek

#### Translating the winetype ####
#systemet_renamed$type %>% sort() %>% unique()
systemet_renamed$sortiment %>% sort() %>% unique()
systemet_renamed$type <-systemet_renamed$sortiment %>% 
  str_replace("Blå stilla","Blue wine")  %>%
  str_replace("Röda - lägre alkoholhalt","Red wine")  %>%
  str_replace("Rött vin","Red wine")  %>%
  str_replace("Rosé - lägre alkoholhalt","Rosé wine")  %>%
  str_replace("Rosévin","Rosé wine")  %>%
  str_replace("Blå mousserande","Sparkling blue")  %>%
  str_replace("Vita - lägre alkoholhalt","White wine")  %>%
  str_replace("Vitt vin","White wine") 
  

#### selecting the wines only ####
selection.list <- paste(c("Champagne", "White wine", 
                          "Red wine","Beading wine",
                          "Sparkling wine","Rosé wine","Blue wine","Sparkling blue"), collapse = '|')

systemet_selection<-systemet_renamed %>% filter(grepl(selection.list,type))

#### Selecting the intersting columns ####
systemet_selection<-systemet_selection %>% select("name_1","name_2",
                                                  "region","country","year","type","producer",
                                                  "volume","price_sek","price_pr_litre_sek", 
                                                  "apk","alcohol","product_num")

#write_csv(systemet_selection, "data/systembolaget.csv")

