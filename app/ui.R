source("../code/global.R", local = FALSE)

<<<<<<< HEAD
ui <- navbarPage("WineRy",
                 tabPanel("WineExplorer",
                          fluidPage(theme = shinytheme("united"),
                                    sidebarLayout(
                                      sidebarPanel(
                                        tableOutput("table"),
                                        h3('Settings'),
                                        helpText('Please input your wine priorities.'),
                                        fluidRow(
                                          column(6,style=list("padding-right: 5px;"),
                                                 selectInput("in_title", label="Select country",
                                                             choices = vino$country,
                                                             selected = 1)
                                          ),
                                          column(6,style=list("padding-left: 5px;"),
                                                 selectizeInput("variety", "Select variety", 
                                                                choices = vino$variety,
                                                                selected = 1)
                                          )),
                                        fluidRow(
                                          column(6,style=list("padding-right: 5px;"),
                                                 selectInput("X", label="X Axis", choices = NULL)
                                          ),
                                          column(6,style=list("padding-left: 5px;"),
                                                 selectInput("Y", label="Y Axis", choices = NULL)
                                          ))
                                        ),
                                      
                                      mainPanel(
                                        # map
                                        selectInput("map_input", 
                                                    label="Select input",
                                                    choices = c("mean_price", "mean_point", "size")),
                                        plotOutput("map"),
                                        # second row
                                        fluidRow(
                                          column(6,style=list("padding-right: 5px;"),
                                                 plotOutput("stars_plot")),
                                          column(6,style=list("padding-left: 5px;"),
                                                 plotOutput("stars_plot2"))
                                        ))
                                      
                                    )
                          )
                 ),
                 # spider plot
                 tabPanel("IndividualWines",
                          fluidRow(
                            column(6,style=list("padding-right: 5px;"),
                                   plotOutput("spider")
                            ),
                            column(6,style=list("padding-left: 5px;"),
                                   plotOutput("descr")
                            ))
                 )
=======
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
      plotOutput("grape_plot"),
      tags$hr(),
      submitButton("Print shopping list")),
    
    mainPanel(
      selectInput("map_input", 
                  label="Select input",
                  choices = c("mean_price", "mean_point", "size")),
      actionButton("map_goButton","Go!"),
      plotOutput("map"),
      fluidRow(
        column(6,style=list("padding-right: 5px;"),
          plotOutput("stars_plot")),
        column(6,style=list("padding-left: 5px;"),
          plotOutput("stars_plot2"))
        ),
      fluidRow(
        column(6,style=list("padding-right: 5px;"),
               plotOutput("spider")
        ),
        column(6,style=list("padding-left: 5px;"),
               plotOutput("price_plot")
        ))
    )
  )
>>>>>>> c58bbc7eca58875f8627f5224450e1b898a9eff3
)

