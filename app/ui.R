source("../code/global.R", local = FALSE)

ui <- navbarPage("WineRy",
                 tabPanel("Explore the wine",
                 fluidPage(theme = shinytheme("united"),
                           sidebarLayout(
                             sidebarPanel(
                               #img(src="logo.png",height=200,width=200),
                               fluidRow(
                                 column(3, img(src="logo.png",height=100,width=100)),
                                 column(9, tableOutput("")) #table
                                 ),
                               h3('Settings'),
                               helpText('Please input your wine priorities.'),
                               selectInput("map_input", 
                                           label="Select input for map",
                                           choices = c("Price", "Points", "Size")),
                               fluidRow(
                                 column(12,style=list("padding-right: 5px;"),
                                        selectInput("in_title", label="Select country",
                                                    choices = vino$country,
                                                    selected = 1)
                                 )),
                               fluidRow(
                                 column(6,style=list("padding-right: 5px;"),
                                        selectInput("X", label="X Axis", 
                                                    choices = c("score", "price_sek", "apk", "alcohol", "year"),
                                                    selected = "score")
                                 ),
                                 column(6,style=list("padding-left: 5px;"),
                                        selectInput("Y", label="Y Axis",
                                                    choices = c("score", "price_sek", "apk", "alcohol", "year"),
                                                    selected = "price_sek")
                                 )),
                               plotOutput("grape_plot")
                               
                             ),
                             
                             mainPanel(
                               # map
                               h3('Wines around the world'),
                               plotOutput("map"),
                               # second row
                               fluidRow(
                                 column(7,style=list("padding-right: 5px;"),
                                        plotlyOutput("stars_plot")),
                                 column(5,style=list("padding-left: 5px;"),
                                        div(plotlyOutput("spider"), align='center'),
                                        div(htmlOutput("descr"), align = 'center')
                                            )
                               )
                             )
                             
                           )
                 )
                 )
                 
)

