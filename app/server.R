
server=function(input,output) {
  output$table <- renderTable({
    t_temp <- vino_us_large %>%
      select(binned, price) %>%
      group_by("Rating" = binned) %>%
      summarise("Average price (USD)" = mean(price, na.rm = TRUE))
    t_temp2 <- vino_us_large %>%
      filter(country == input$in_title) %>% 
      select(binned, price) %>%
      group_by("Rating" = binned) %>%
      summarise(in_country = mean(price, na.rm = TRUE)) #paste("Average price in", input$in_title,"(USD)", sep = " ")
    bind_cols(t_temp, t_temp2[2]) %>% return()
  })
  
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
