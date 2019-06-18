library(tidyverse)
library(ggmap)
vino <- read.csv("vino.csv", header = T)

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


server=function(input,output) {
  output$table <- renderTable(
    vino %>%
      select(binned, price) %>%
      group_by("Rating" = binned) %>%
      summarise("Average price (USD)" = mean(price, na.rm = TRUE))
      )
    
  output$map <- renderPlot({
    ggplot()+
      borders("world", colour="gray50", fill="gray50") +
      borders("world", regions = vino$country, colour="red", fill="red")
  })
  
  go_plot <- eventReactive(input$btn_go, {
    data <- filter(vino, vino$country == input$in_title)
    ggplot(isolate(data), aes(isolate(data$stars))) + 
      geom_bar(fill = "white", color = "#29B00E") +
      labs(title = "Wine rating")+
      xlab("Rating")+
      ylab("")+
      xlim(0,5)+
      theme
  })
  
  output$stars_plot <- renderPlot(go_plot())
  
  
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
}
