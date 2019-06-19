
server=function(input,output) {
  output$table <- renderTable(
    vino_us %>%
      select(binned, price) %>%
      group_by("Rating" = binned) %>%
      summarise("Average price (USD)" = mean(price, na.rm = TRUE))
  )
  
  output$grape_plot <- renderPlot(
    vino_us_large %>% 
      group_by(country) %>%
      filter(!is.na(country)) %>% 
      mutate(n=n(),
             mean_price = mean(price, na.rm = TRUE),
             mean_stars = mean(stars, na.rm = TRUE)) %>% 
      ggplot(aes(x = reorder(country, n), y = price, color = stars))+
      geom_jitter()+
      xlab("Wine producing countries")+
      ylab("Price in (USD)") +
      scale_y_log10()+
      coord_flip()+
      scale_color_gradient(low = "#FFF5EB", high = "#D94801")
  )
  
  map_plot <- reactive({
    p <- ggplot() +
      borders("world", colour="gray80", fill="gray80") +
      geom_polygon(data = wine_map, 
                   aes_string(x="long", y = "lat", 
                              group = "group", fill = input$map_input)) +
      ditch_axes +
      coord_fixed() +
      scale_fill_gradient(low = "#FFF5EB", high = "#D94801")
    return(p)
  })
  
  output$map <- renderPlot({map_plot()})
  
  output$stars_plot <- renderPlotly ({ 
    # top <- vino %>% 
    #   filter(country == input$in_title) %>% 
    #   group_by(type) %>% 
    #   summarise(n=n(),
    #             mean_price = round(mean(price_sek, na.rm = TRUE),digits = 2),
    #             mean_stars = round(mean(stars, na.rm = TRUE), digits = 1)) %>% 
    #   arrange(desc(n)) %>% 
    #   top_n(n=3, wt=n)
    
    
    dat <- vino %>% 
      filter(country == input$in_title) %>% 
      group_by(type) %>% 
      select(x=input$X,y=input$Y)
    dat <- na.omit(dat)
    dat %>% plot_ly(x = ~x, y = ~y, type = "scatter", source = 'select',
                    color = ~type, colors = c("#D94801", "#FDAE6B", "#FFDFC1"),
                    marker = list(size = 10,
                                  line = list(color = 'rgba(0, 0, 0, .4)',
                                              width = 2))) %>%
      layout(xaxis = list(title = paste(input$X)),
             yaxis = list(title = paste(input$Y))
      ) 
    # add_lines(y = ~fitted(loess(y ~ x)),
    #           line = list(color = 'red'),
    #          name = "Loess Smoother", showlegend = TRUE) 
    
    # ggplot(data = dat, aes(x = x, y = y), source = "select")+
    #   geom_jitter(aes(fill= color),
    #             width = 0.2, height = 0.2, 
    #             shape=21,size=3,stroke=0.8,
    #             color = 'black',
    #             show.legend = TRUE)+
    #   geom_smooth(method="loess",se=F,color="red",size=0.6, show.legend = FALSE)+
    # labs(title = paste("Wine", input$X, "per", input$Y, sep=" "))+
    # xlab(paste(input$X))+
    # ylab(paste(input$Y, "(USD)", sep = " ")) +
    # guides(color = guide_legend(nrow = 2))+
    # scale_fill_manual(values = c("red", "orange", "yellow", "grey60"))+
    # theme(legend.position = "bottom",
    #       panel.grid.minor=element_blank(),
    #       panel.grid.major.x=element_blank(),
    #       panel.background=element_blank(),
    #       panel.border=element_blank(),
    #       legend.title=element_blank(),
    #       axis.title=element_text(face="italic"),
    #       axis.ticks.y=element_blank(),
    #       axis.ticks.x=element_line(color="grey60"),
    #       plot.title=element_text(face="bold", hjust=0.5))
  })
  
  output$spider <- renderPlotly ({
    click <- event_data("plotly_click", source = "select")
    if(is.null(click)) return(NULL)
    vars <- c(click[["x"]], click[["y"]])
    
    var1 <- input$X
    var2 <- input$Y
    vars <- which(vino[,var1] == vars[1] & vino[,var2] == vars[2])
    
    demo <- vino[vars, grep("taste_", names(vino))]
    demo <- demo[!apply(demo, 1 , function(x) all(is.na(x))), ]
    
    names(demo) <- gsub("taste_", "", names(demo))
    substr(names(demo), 1, 1) <- toupper(substr(names(demo), 1, 1))
    
    p <- plot_ly(
      type = 'scatterpolar',
      r = as.numeric(demo[1,]),
      theta = names(demo),
      fill = 'toself',
      color = '#D94801'
    ) %>%
      layout(
        polar = list(
          radialaxis = list(
            visible = T,
            range = c(0,12)
          )
        ),
        showlegend = F
      )
    return(p)
  })
  
  output$descr <- renderText({ 
    click <- event_data("plotly_click", source = "select")
    if(is.null(click)) return(NULL)
    vars <- c(click[["x"]], click[["y"]])
    
    var1 <- input$X
    var2 <- input$Y
    vars <- which(vino[,var1] == vars[1] & vino[,var2] == vars[2])
    
    description <- vino[vars, c("name_1", "name_2", "year")]
    description <- description[!apply(description, 1 , function(x) all(is.na(x))), ]
    if (nrow(description)>1) {description <- description[1,]}
    
    return(paste('<b><i>', as.character(description), '</i></b>'))
  })
  
  output$link <- renderText({
    click <- event_data("plotly_click", source = "select")
    if(is.null(click)) return(NULL)
    vars <- c(click[["x"]], click[["y"]])
    
    var1 <- input$X
    var2 <- input$Y
    vars <- which(vino[,var1] == vars[1] & vino[,var2] == vars[2])
    description <- vino[vars, "url"]
    if (nrow(description)>1) {description <- description[1,]}
    
    return(paste0("<a href='", as.character(description), "'>Link to your wine.</a>"))
  })
}
