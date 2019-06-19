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
  
  mapPlot <- eventReactive(input$map_goButton, {
    input_map <- input$map_input
    ggplot() +
      borders("world", colour="gray80", fill="gray80") +
      geom_polygon(data = wine_map, 
                   aes_string(x="long", y = "lat", group = "group", fill = input_map)) +
      ditch_axes +
      coord_fixed() +
      scale_fill_viridis_c(alpha = 1, begin = 0, end = 1,
                           direction = 1, option = "D", aesthetics = "fill")  })
  output$map <- renderPlot(
    mapPlot()
  )
  
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
  
  
  output$stars_plot <- renderPlot ({ 
    top <- vino %>% 
      filter(country == "Spain") %>% 
      group_by(variety) %>% 
      summarise(n=n(),
                mean_price = round(mean(price, na.rm = TRUE),digits = 2),
                mean_stars = round(mean(stars, na.rm = TRUE), digits = 1)) %>% 
      arrange(desc(n)) %>% 
      top_n(n=3, wt=n)
    
    vino %>% 
      filter(country == "Spain") %>% 
      group_by(variety) %>% 
      mutate(color = case_when(variety == top[[1,1]] ~ paste("1",variety, sep = " "),
                               variety == top[[2,1]] ~ paste("2",variety, sep = " "),
                               variety == top[[3,1]] ~ paste("3",variety, sep = " "),
                               TRUE ~ "etc.")) %>% 
      ggplot(aes(x = stars, y = price))+
      geom_jitter(aes(fill= color),
                  width = 0.2, height = 0.2, 
                  shape=21,size=3,stroke=0.8,
                  #fill="white",
                  color = "#29B00E",
                  show.legend = TRUE)+
      geom_smooth(method="loess",se=F,color="red",size=0.6, show.legend = FALSE)+  
      labs(title = "Wine rating per price")+
      xlab("Rating")+
      ylab("Price (USD)") +
      xlim(0,5)+
      guides(color = guide_legend(nrow = 2))+
      scale_fill_manual(values = c("red", "orange", "yellow", "grey60"))+
      theme(legend.position = "bottom",
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
  
  output$spider <- renderPlot ({
    names(demo) <- gsub("taste_", "", names(demo))
    substr(names(demo), 1, 1) <- toupper(substr(names(demo), 1, 1))
    
    demo=rbind(rep(1,5) , rep(0,5) , demo)
    demo[3,] <- demo[3,]/12
    
    radarchart(demo  , axistype=1 , 
               #custom polygon
               pcol= "#F28C26",
               pfcol=rgb(0.949, 0.549, 0.149, 0.3),
               plwd=4 , plty=1,
               #custom the grid
               cglcol="grey", cglty=1, axislabcol="grey", cglwd=0.8,
               #custom labels
               vlcex=0.8 )
  })
}
