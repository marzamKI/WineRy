source("../code/global.R", local = FALSE)

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
                             selectInput("X", label="X Axis", choices = NULL),
                             selectInput("Y", label="Y Axis", choices = NULL)),
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
                  choices = c("mean_price", "mean_point", "size")),
      plotOutput("map"),
              splitLayout(cellWidths = c("50%", "50%"),
                          plotOutput("price_plot")),
              plotOutput("spider")
              )
    )
)
  
