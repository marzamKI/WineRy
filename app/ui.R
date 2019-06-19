source("../code/global.R", local = FALSE)

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
                                                 selectInput("X", label="X Axis", 
                                                             choices = c("stars", "price"),
                                                             #colnames(vino)[c(18,8)],
                                                             selected = "stars")
                                          ),
                                          column(6,style=list("padding-left: 5px;"),
                                                 selectInput("Y", label="Y Axis",
                                                             choices = c("stars", "price"),
                                                             #choices = colnames(vino)[c(18,8)],
                                                             selected = "price")
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
)
