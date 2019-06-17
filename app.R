library(tidyverse)
vino <- read.csv("vino.csv", header = T)
vino$binned <- cut(vino$points, breaks = 5)

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
                             plotOutput("points_plot"))
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
    
    output$points_plot <- renderPlot({
      data <- filter(vino, vino$country == input$in_title)
      
      ggplot(isolate(data), aes(isolate(data$points))) + 
        geom_bar(fill = "white", color = "#29B00E") +
        labs(title = "Wine rating")+
        xlab("Rating")+
        ylab("")+
        theme_bw(base_family="Helvetica")+
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
    })
    
    output$price_plot <- renderPlot({
      
      data <- filter(vino, vino$country == input$in_title)
      
      ggplot(data,aes(isolate(data$points), isolate(data$price)))+
        geom_smooth(aes(fill="red"),method="lm",formula=y~poly(x,2),se=F,color="red",size=0.6)+
        geom_point(shape=21,size=3,stroke=0.8,fill="white", color = "#29B00E")+
        labs(title = "Wine rating per price")+
        xlab("Rating")+
        ylab("Price (USD)") +
        theme_bw(base_family="Helvetica")+
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
    })
  }
)