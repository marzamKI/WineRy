library(tidyverse)
library(shiny)
library(ggmap)

vino <- read.csv("data/vino.csv", header = T)

ui <- fluidPage(
  titlePanel("WineRy"),
  sidebarLayout(
    sidebarPanel(tableOutput("table"),
                 selectInput("in_title",
                             label="Select country", 
                             choices = vino$country),
                 actionButton("btn_go","Go!")),
    mainPanel(plotOutput("map"),
              splitLayout(cellWidths = c("50%", "50%"),
                          plotOutput("price_plot"),
                          plotOutput("stars_plot")
                          )
              )
    )
)
  
