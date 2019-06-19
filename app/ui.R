source("../code/global.R", local = FALSE)

ui <- navbarPage("WineRy",
                 fluidPage(theme = shinytheme("united"),
                           sidebarLayout(
                             sidebarPanel(
                               tableOutput("table"),
                               h3('Settings'),
                               helpText('Please input your wine priorities.'),
                               selectInput("map_input", 
                                           label="Select input for map",
                                           choices = c("Price", "Points", "Size")),
                               h4('Have a deeper look'),
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
                                        selectInput("X", label="X Axis", 
                                                    choices = c("stars", "price", "points"),
                                                    selected = "stars")
                                 ),
                                 column(6,style=list("padding-left: 5px;"),
                                        selectInput("Y", label="Y Axis",
                                                    choices = c("stars", "price", "points"),
                                                    selected = "price")
                                 )),
                               plotOutput("grape_plot")
                               
                             ),
                             
                             mainPanel(
                               # map
                               h3('Wine properties in the world'),
                               plotOutput("map"),
                               # second row
                               fluidRow(
                                 column(6,style=list("padding-right: 5px;"),
                                        plotlyOutput("stars_plot")),
                                 column(6,style=list("padding-left: 5px;"),
                                        div(plotOutput("spider"), align='center'),
                                        div(textOutput("descr"), align = 'center')
                                            )
                               )
                             )
                             
                           )
                 )
                 
)

