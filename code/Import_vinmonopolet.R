##########
### Script for importing and cleaning data from Vinmonopolet
### The original data in csv-format can be found here:
### https://www.vinmonopolet.no/datadeling
###
### Anders K. Krabberoedd 18. june 2019
###########

library(readr)
library(tidyverse)

monopolet <- read_delim("data/Vinmonopolet_norwegian.csv",
                        ";", escape_double = FALSE, 
                        locale = locale(decimal_mark = ",",encoding = "WINDOWS-1252"), 
                        trim_ws = TRUE)

#### renaming columns ####
monopolet_renamed<-monopolet %>% rename(date=Datotid,
                                        product_number=Varenummer,
                                        product_name=Varenavn,
                                        volume=Volum,
                                        price_nok=Pris,
                                        price_pr_litre_nok=Literpris,
                                        type=Varetype,
                                        product_assortment=Produktutvalg,
                                        store_assortment=Butikkategori,
                                        taste_body=Fylde,
                                        taste_freshness=Friskhet,
                                        taste_tanins=Garvestoffer,
                                        taste_bitternes=Bitterhet,
                                        taste_sweetnes=Sodme,
                                        color=Farge,
                                        aroma=Lukt,
                                        taste=Smak,
                                        goes_with=Passertil01,
                                        goes_with2=Passertil02,
                                        goes_with3=Passertil03,
                                        country=Land,
                                        district=Distrikt,
                                        region=Underdistrikt,
                                        year=Argang,
                                        base_material=Rastoff,
                                        method=Metode,
                                        alcohol=Alkohol,
                                        sugar=Sukker,
                                        acidity=Syre,
                                        storage=Lagringsgrad,
                                        producer=Produsent,
                                        retailer=Grossist,
                                        distributor=Distributor,
                                        packaging=Emballasjetype,
                                        corg=Korktype,
                                        product_url=Vareurl,
                                        organic=Okologisk,
                                        biodynamic=Biodynamisk,
                                        fairtrade=Fairtrade,
                                        env_package=Miljosmart_emballasje,
                                        gluten=Gluten_lav_pa,
                                        kosher=Kosher,
                                        mainGTIN=HovedGTIN,
                                        otherGTIN=AndreGTINs)


#### renaming countrynames ####
# It's not pretty, but it works
monopolet_renamed$country <- monopolet_renamed$country %>% 
  str_replace("Amer. Jomfru??y.","U.S. Virgin Islands") %>% 
  str_replace("Antillene","Antilles") %>% 
  str_replace("Argentina","Argentina") %>% 
  str_replace("Australia","Australia") %>% 
  str_replace("Barbados","Barbados") %>% 
  str_replace("Belgia","Belgium") %>% 
  str_replace("Bermuda","Bermuda") %>% 
  str_replace("Bosnia-Herceg.","Bosnia Herzegovina") %>% 
  str_replace("Brasil","Brazil") %>% 
  str_replace("Bulgaria","Bulgaria") %>% 
  str_replace("Canada","Canada") %>% 
  str_replace("Chile","Chile") %>% 
  str_replace("Colombia","colombia") %>% 
  str_replace("Costa","Costa") %>% 
  str_replace("Croatian Republic of Herzeg-Bosnia","Bosnia Herzegovina") %>% 
  str_replace("Cuba","Cuba") %>% 
  str_replace("Danmark","Denmark") %>% 
  str_replace("England","England") %>% 
  str_replace("Estland","Estonia") %>% 
  str_replace("EU","EU") %>% 
  str_replace("Finland","Finland") %>% 
  str_replace("Frankrike","France") %>% 
  str_replace("Georgia","Georgia") %>% 
  str_replace("Guatemala","Guatemala") %>% 
  str_replace("Guyana","Guyana") %>% 
  str_replace("Haiti","Haiti") %>% 
  str_replace("Hellas","Greece") %>% 
  str_replace("India","India") %>% 
  str_replace("Irland","Ireland") %>% 
  str_replace("Island","Island") %>% 
  str_replace("Israel","Israel") %>% 
  str_replace("Italia","Italy") %>% 
  str_replace("Jamaica","Jamaica") %>% 
  str_replace("Japan","Japan") %>% 
  str_replace("Kina","China") %>% 
  str_replace("Kroatia","Croatia") %>% 
  str_replace("Latvia","Latvia") %>% 
  str_replace("Libanon","Lebanon") %>% 
  str_replace("Litauen","Lithuania") %>% 
  str_replace("Luxemburg","Luxemburg") %>% 
  str_replace("Makedonia","Macedonia") %>% 
  str_replace("Marokko","Morocco") %>% 
  str_replace("Martinique","Martinique") %>% 
  str_replace("Mexico","Mexico") %>% 
  str_replace("Moldova","Moldova") %>% 
  str_replace("Montenegro","Montenegro") %>% 
  str_replace("Nederland","Netherlands") %>% 
  str_replace("Nevis","Nevis") %>% 
  str_replace("New Zealand","New Zealand") %>% 
  str_replace("Nicaragua","Nicaragua") %>% 
  str_replace("Norge","Norway") %>% 
  str_replace("ovrige","other") %>% 
  str_replace("Panama","Panama") %>% 
  str_replace("Paraguay","Paraguay") %>% 
  str_replace("Peru","Peru") %>% 
  str_replace("Polen","Poland") %>% 
  str_replace("Portugal","Portugal") %>% 
  str_replace("Puerto","Puerto") %>% 
  str_replace("Romania","Romania") %>% 
  str_replace("Russland","Russia") %>% 
  str_replace("Skottland","Scotland") %>% 
  str_replace("Slovakia","Slovakia") %>% 
  str_replace("Slovenia","Slovenia") %>% 
  str_replace("Spania","Spain") %>% 
  str_replace("Storbritannia","United Kingdom") %>% 
  str_replace("Sveits","Switzerland") %>% 
  str_replace("Sverige","Sweden") %>% 
  str_replace("S??r-Afrika","South Africa") %>% 
  str_replace("S??r-Korea","South Korea") %>% 
  str_replace("Taiwan","Taiwan") %>% 
  str_replace("Thailand","Thailand") %>% 
  str_replace("Trinidad,Tobago","Trinidad, Tobago") %>% 
  str_replace("Tsjekkia","Czech Republic") %>% 
  str_replace("Tyrkia","Turkey") %>% 
  str_replace("Tyskland","Germany") %>% 
  str_replace("Ukraina","Ukraine") %>% 
  str_replace("Ungarn","Hungary") %>% 
  str_replace("Uruguay","Uruguay") %>% 
  str_replace("USA","US") %>% 
  str_replace("Venezuela","Venezuela") %>% 
  str_replace("Wales","Wales") %>% 
  str_replace("??sterrike","Austria") %>% 
  str_replace("St. Chr.& Nevis","Saint Kitts") %>% 
  str_replace("Dominik. rep.","Dominican Republic") %>% 
  str_replace("Trinidad, Tobago","Trinidad and Tobago")  %>% 
  str_replace("Bosnia-Herceg.","Croatian Republic of Herzeg-Bosnia")
monopolet_renamed$country %>% sort() %>% unique()

#### Translating the names of wine types ####
monopolet_renamed$type <-monopolet_renamed$type %>% 
  str_replace("Aromatisert vin ","Flavored wine")  %>% 
  str_replace("Barley wine","Barley wine")  %>% 
  str_replace("Champagne extra brut","Champagne")  %>% 
  str_replace("Champagne, annen","Champagne")  %>% 
  str_replace("Champagne, brut","Champagne")  %>% 
  str_replace("Champagne, ros??","Champagne")  %>% 
  str_replace("Champagne, sec","Champagne")  %>% 
  str_replace("Fruktvin","Fruit wines")  %>% 
  str_replace("Hvitvin","White wine")  %>% 
  str_replace("Musserende vin ","Sparkling wine")  %>% 
  str_replace("Musserende vin, ros??","Sparkling wine")  %>% 
  str_replace("Perlende vin, hvit","Beading wine")  %>% 
  str_replace("Perlende vin, ros??","Beading wine")  %>% 
  str_replace("Perlende vin, r??d ","Beading wine")  %>% 
  str_replace("Ros??vin","Ros?? wine")  %>% 
  str_replace("R??dvin","Red wine")
#### calculate apk ####

monopolet_renamed$apk<-monopolet_renamed$alcohol/monopolet_renamed$price_pr_litre_nok



#### selecting the wines only ####
selection.list <- paste(c("Champagne", "White wine", 
                          "Red wine","Beading wine",
                          "Sparkling wine","Ros?? wine"), collapse = '|')

monopolet_selection<-monopolet_renamed %>% filter(grepl(selection.list,type))

#### Selecting the columns of interest ####

monopolet_selection<-monopolet_selection %>% select("product_name","district",
                                                    "region","year","type","producer",
                                                    "volume","price_nok","price_pr_litre_nok", 
                                                    "apk","alcohol","product_url","taste_body","taste_freshness","taste_tanins",
                                                    "taste_bitternes","taste_sweetnes","country")


#### exporting the cleaned and selected data in csv-format ####
#write_csv(monopolet_selection, "data/vinmonopolet.csv")





