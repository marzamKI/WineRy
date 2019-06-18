library(tidyverse)
library(shiny)
library(ggmap)

wine_sub <- select(wine, -c("X", "taster_name", "taster_twitter_handle"))

vino <- read.csv("vino.csv", header = T)
vino$binned <- cut(vino$points, breaks = 6, labels = 0:5)
vino$stars <- (vino$points-80)/(20) *5

theme <-theme_bw(base_family="Helvetica")+
  theme(legend.position = "none",
        panel.grid.minor=element_blank(),
        panel.grid.major.x=element_blank(),
        panel.background=element_blank(),
        panel.border=element_blank(),
        legend.title=element_blank(),
        axis.title=element_text(face="italic"),
        axis.ticks.y=element_blank(),
        axis.ticks.x=element_line(color="grey60"),
        plot.title=element_text(face="bold", hjust=0.5))

shinyApp(
  ui <- fluidPage(
    titlePanel("WineRy"),
    
    sidebarLayout(
      sidebarPanel(tableOutput("table")
      ),
      mainPanel(selectInput("in_title",label="Select country", choices = vino$country),
                actionButton("btn_go","Go!"),
                splitLayout( cellWidths = c("50%", "50%"),
                             plotOutput("price_plot"),
                             plotOutput("stars_plot")),
                plotOutput("map")
      )
    )
  ),
  
  
  server=function(input,output) {
    output$table <- 
      renderTable(vino %>%  
                    select(binned, price) %>% 
                    group_by("Rating" = binned) %>% 
                    summarise("Average price (USD)" = mean(price, na.rm = TRUE))
      )
    
    output$stars_plot <- renderPlot({
      data <- filter(vino, vino$country == input$in_title)
      
      ggplot(isolate(data), aes(isolate(data$stars))) + 
        geom_bar(fill = "white", color = "#29B00E") +
        labs(title = "Wine rating")+
        xlab("Rating")+
        ylab("")+
        xlim(0,5)+
        theme
    })
    
    output$price_plot <- renderPlot({
      
      data <- filter(vino, vino$country == input$in_title)
      
      ggplot(data,aes(isolate(data$stars), isolate(data$price)))+
        geom_smooth(aes(fill="red"),method="lm",formula=y~poly(x,2),se=F,color="red",size=0.6)+
        geom_point(shape=21,size=3,stroke=0.8,fill="white", color = "#29B00E")+
        labs(title = "Wine rating per price")+
        xlab("Rating")+
        ylab("Price (USD)") +
        xlim(0,5)+
        theme
    })
    
    output$map <- renderPlot({
      ggplot()+
        borders("world", colour="gray50", fill="gray50")
    })
  }
)


