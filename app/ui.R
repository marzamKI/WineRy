source("../code/global.R", local = TRUE)

vino <- read.csv("../data/vino.csv", header = T)
wine_map <- read.csv("../data/wine_map.csv", header = T)

ui <- fluidPage(
  titlePanel("WineRy"),
  sidebarLayout(
    sidebarPanel(tableOutput("table"),
                 selectInput("in_title", label="Select country",choices = vino$country),
                 selectizeInput("variety", "Select variety", vino$variety),
                 br(),
                 splitLayout(cellWidths = c("50%", "50%"),
                             selectInput("X", label="X Axis", choices = colnames(vino)),
                             selectInput("Y", label="Y Axis", choices = colnames(vino))),
                 br(),
                 br(),
                 actionButton("btn_go","Go!"),
                 hr(),
                 plotOutput("full_plot"),
                 hr(),
                 submitButton("Print shopping list")),
    
    mainPanel(
      selectInput("map_input", 
                  label="Select input",
                  choices = colnames(wine_map)),
      plotOutput("map"),
              splitLayout(cellWidths = c("50%", "50%"),
                          plotOutput("price_plot")),
              plotOutput("spider")
              )
    )
)
  
