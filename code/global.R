# global.R contains all code and scripts necessary for the app
library(tidyverse)
library(shiny)
library(plotly)
library(ggmap)
library(maps)
library(viridis)
library(magrittr)
library(fmsb)
library(shinythemes)
library(RColorBrewer)
#library(available)

# data for map
vino <- read_csv("../data/vino.csv")
wine_map <- read_csv("../data/wine_map.csv")

systemet <- read_csv("../data/systemet_vin.csv")

# data for spider plot
demo=read.csv('../data/vinmonopolet_taste.csv')
demo <- demo[128,2:6]

theme <-theme_bw(base_family="Helvetica")+
  theme(legend.position = "none",
        panel.grid.minor=element_blank(),
        panel.grid.major.x=element_blank(),
        panel.background=element_blank(),
        panel.border=element_blank(),
        legend.title=element_blank(),
        axis.title=element_text(face="italic"),
        axis.ticks.y=element_blank(),
        axis.ticks.x=element_line(color="grey60"),
        plot.title=element_text(face="bold", hjust=0.5)
  )

ditch_axes <- theme(
  axis.text = element_blank(),
  axis.line = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(),
  panel.grid = element_blank(),
  axis.title = element_blank()
)

