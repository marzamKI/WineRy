source("../code/global.R", local = FALSE)

ui <- fluidPage(
  titlePanel("WineRy"),
  sidebarLayout(
    sidebarPanel(
      tableOutput("table"),
      h3('Settings'),
      fluidRow(
        column(6,style=list("padding-right: 5px;"),
               selectInput("in_title", label="Select country",choices = vino$country)
        ),
        column(6,style=list("padding-left: 5px;"),
               selectizeInput("variety", "Select variety", vino$variety)
        )),
      fluidRow(
        column(6,style=list("padding-right: 5px;"),
               selectInput("X", label="X Axis", choices = NULL)
        ),
        column(6,style=list("padding-left: 5px;"),
               selectInput("Y", label="Y Axis", choices = NULL)
        )),
      tags$br(),
      actionButton("btn_go","Go!"),
      tags$hr(),
      plotOutput("full_plot"),
      tags$hr(),
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

