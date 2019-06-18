library(shiny)
vino <- read.csv("vino.csv", header = T)

ui <- fluidPage(
  titlePanel("WineRy"),
  sidebarLayout(
    sidebarPanel(tableOutput("table"),
                 selectInput("in_title", label="Select country",choices = vino$country),
                 selectInput("X", label="X Axis", choices = colnames(vino)),
                 selectInput("Y", label="Y Axis", choices = colnames(vino)),
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
  
