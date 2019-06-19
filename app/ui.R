source("../code/global.R", local = FALSE)

ui <- navbarPage("WineRy",
                 fluidPage(theme = shinytheme("united"),
                           sidebarLayout(
                             sidebarPanel(
                               fluidRow(
                                 column(7, tableOutput("table")),
                                 column(5, img(src="logo.png",height=140,width=140))),
                               h3('Settings'),
                               helpText('Please input your wine priorities.'),
                               selectInput("map_input", 
                                           label="Select input for map",
                                           choices = c("Price", "Points", "Size")),
                               h4('Have a deeper look'),
                               fluidRow(
                                 column(12,style=list("padding-right: 5px;"),
                                        selectInput("in_title", label="Select country",
                                                    choices = vino$country,
                                                    selected = 1)
                                 )),
                               fluidRow(
                                 column(6,style=list("padding-right: 5px;"),
                                        selectInput("X", label="X Axis", 
                                                    choices = c("score", "price_sek", "apk"),
                                                    selected = "score")
                                 ),
                                 column(6,style=list("padding-left: 5px;"),
                                        selectInput("Y", label="Y Axis",
                                                    choices = c("score", "price_sek", "apk"),
                                                    selected = "price_sek")
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
                                        div(plotlyOutput("spider"), align='center'),
                                        div(textOutput("descr"), align = 'center')
                                            )
                               )
                             )
                             
                           )
                 )
                 
)

