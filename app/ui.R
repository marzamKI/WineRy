library(shiny)
vino <- read.csv("vino.csv", header = T)

ui <- fluidPage(
  titlePanel("WineRy"),
  sidebarLayout(
    sidebarPanel(tableOutput("table"),
                 selectInput("in_title", label="Select country",choices = vino$country),
                 selectizeInput("variety", "Select variety", vino$variety),
                 splitLayout(cellWidths = c("50%", "50%"),
                             selectInput("X", label="X Axis", choices = colnames(vino)),
                             selectInput("Y", label="Y Axis", choices = colnames(vino))),
                 br(),
                 actionButton("btn_go","Go!"),
                 hr(),
                 plotOutput("full_plot"),
                 hr(),
                 submitButton("Print shopping list")),
    
    mainPanel(plotOutput("map"),
              splitLayout(cellWidths = c("50%", "50%"),
                          plotOutput("price_plot")),
              plotOutput("spider")
              )
    )
)
  
