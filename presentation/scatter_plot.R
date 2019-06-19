plotly::ggplotly

vino_plot1 <- vino %>% 
  filter(country == "Germany") %>% 
  ggplot(aes(x = stars, y = price))+
  geom_jitter(width = 0.2, height = 0.2, 
              shape=21,size=3,stroke=0.8,fill="white", color = "#29B00E")+
  geom_smooth(aes(fill="red"),method="loess",se=F,color="red",size=0.6)+  
  labs(title = "Wine rating per price")+
  xlab("Rating")+
  ylab("Price (USD)") +
  xlim(0,5)+
  theme


# V2 ---------- with top groups 


vino %>% 
  filter(country == "Germany") %>% 
  group_by(variety) %>% 
  summarise(n=n(),
          mean_price = mean(price, na.rm = TRUE),
          mean_stars = mean(stars, na.rm = TRUE)) %>% 
  arrange(desc(n))


unique(vino$country)

top <- vino %>% 
  filter(country == "Spain") %>% 
  group_by(variety) %>% 
  summarise(n=n(),
            mean_price = mean(price, na.rm = TRUE),
            mean_stars = mean(stars, na.rm = TRUE)) %>% 
  top_n(n=3, wt=n) %>% pull(variety)

vino %>% 
  filter(country == "Spain")  %>% 
  group_by(variety) %>% 
  mutate(n=n(),
        mean_price = round(mean(price, na.rm = TRUE),digits = 2),
        mean_stars = round(mean(stars, na.rm = TRUE), digits = 1),
        color = case_when(variety == top[1] ~ paste("1",variety, mean_price, "/", mean_stars, sep = " "),
                          variety == top[2] ~ paste("2",variety, mean_price, "/", mean_stars, sep = " "),
                          variety == top[3] ~ paste("3",variety, mean_price, "/", mean_stars, sep = " "),
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
  