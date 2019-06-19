library(tidyverse)
library(ggmap)
vino <- read.csv("../data/vino.csv", header = T)
wine_map <- read.csv("../data/wine_map.csv", header = T)

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
        plot.title=element_text(face="bold", hjust=0.5)
        )

ditch_axes <- theme(
    axis.text = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    panel.border = element_blank(),
    panel.grid = element_blank(),
    axis.title = element_blank()
    )

server=function(input,output) {
  output$table <- renderTable(
    vino %>%
      select(binned, price) %>%
      group_by("Rating" = binned) %>%
      summarise("Average price (USD)" = mean(price, na.rm = TRUE))
      )
  
  getdata <- reactive({ get(input$map_input,'package:datasets') })
  
  output$map <- renderPlot({
    ggplot()+
      borders("world", colour="gray80", fill="gray80") +
      geom_polygon(data = wine_map, 
                   aes_string(x="long", y = "lat", group = "group", fill = input$map_input)) +
      ditch_axes +
      coord_fixed() +
      scale_fill_viridis_c(alpha = 1, begin = 0, end = 1,
                           direction = 1, option = "D", aesthetics = "fill")
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
