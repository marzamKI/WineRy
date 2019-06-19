# global.R contains all code and scripts necessary for the app
library(tidyverse)
library(shiny)
library(plotly)
library(ggmap)
library(maps)
library(viridis)
library(magrittr)
#library(available)

vino <- read_csv("../data/vino.csv")
wine_map <- read_csv("../data/wine_map.csv")



