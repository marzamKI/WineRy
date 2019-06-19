# global.R contains all code and scripts necessary for the app
library(tidyverse)
library(shiny)
library(plotly)
library(ggmap)
library(maps)
library(viridis)
library(magrittr)
#library(available)

vino <- read.csv("../data/vino.csv", header = T)
wine_map <- read.csv("../data/wine_map.csv", header = T)



