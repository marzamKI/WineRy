
server=function(input,output) {
  output$table <- renderTable(
    vino %>%
      select(binned, price) %>%
      group_by("Rating" = binned) %>%
      summarise("Average price (USD)" = mean(price, na.rm = TRUE))
      )
  
  output$grape_plot <- renderPlot(
  vino %>% 
    group_by(country) %>% 
    mutate(n=n(),
           mean_price = mean(price, na.rm = TRUE),
           mean_stars = mean(stars, na.rm = TRUE)) %>% 
    ggplot(aes(x = reorder(country, n), y = price, color = stars))+
    #geom_point()+
    geom_jitter()+
    scale_y_log10()+
    coord_flip()+
    scale_color_viridis()
  )
  
  map_plot <- reactive({
    p <- ggplot() +
      borders("world", colour="gray80", fill="gray80") +
      geom_polygon(data = wine_map, 
                   aes_string(x="long", y = "lat", 
                              group = "group", fill = input$map_input)) +
      ditch_axes +
      coord_fixed() +
      scale_fill_viridis_c(alpha = 1, begin = 0, end = 1,
                           direction = 1, option = "D", aesthetics = "fill")
    return(p)
  })
  
  output$map <- renderPlot({map_plot()})
  
  output$stars_plot <- renderPlot ({ 
    top <- vino %>% 
      filter(country == input$in_title) %>% 
      group_by(variety) %>% 
      summarise(n=n(),
                mean_price = round(mean(price, na.rm = TRUE),digits = 2),
                mean_stars = round(mean(stars, na.rm = TRUE), digits = 1)) %>% 
      arrange(desc(n)) %>% 
      top_n(n=3, wt=n)
    
    vino %>% 
      filter(country == input$in_title) %>% 
      group_by(variety) %>% 
      select(x=input$X,y=input$Y) %>% 
      mutate(color = case_when(variety == top[[1,1]] ~ paste("1",variety, sep = " "),
                               variety == top[[2,1]] ~ paste("2",variety, sep = " "),
                               variety == top[[3,1]] ~ paste("3",variety, sep = " "),
                               TRUE ~ "etc.")) %>% 
      ggplot(aes(x = x, y = y))+
        geom_jitter(aes(fill= color),
                  width = 0.2, height = 0.2, 
                  shape=21,size=3,stroke=0.8,
                  #fill="white",
                  color = 'black',
                  show.legend = TRUE)+
        geom_smooth(method="loess",se=F,color="red",size=0.6, show.legend = FALSE)+
      labs(title = paste("Wine", input$X, "per", input$Y, sep=" "))+
      xlab(paste(input$X))+
      ylab(paste(input$Y, "(USD)", sep = " ")) +
      #xlim(0,5)+
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
  
  output$descr <- renderText({ 'The description will go here'})
}
