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