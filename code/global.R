# global.R contains all code and scripts necessary for the app
library(tidyverse)
library(shiny)
library(plotly)
library(ggmap)
library(maps)
library(viridis)
library(magrittr)
library(fmsb)
#library(available)

vino <- read_csv("../data/vino.csv")
wine_map <- read_csv("../data/wine_map.csv")


demo=read.csv('../data/vinmonopolet_taste.csv')
demo <- demo[128,2:6]



