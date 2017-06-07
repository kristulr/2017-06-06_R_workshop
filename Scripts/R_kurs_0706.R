

gapminder_plus %>% 
  group_by(continent) %>% 
  summarize(averagelife = mean(lifeExp),
  min_life = min(lifeExp),
  max_life = max(lifeExp))
  
  
gapminder_plus %>% 
  ggplot()+
  geom_line(mapping=aes(x=year, y=lifeExp, color=continent, group=country))+
  geom_smooth(mapping=aes(x=year, y=lifeExp), method="lm", color="black")+
  facet_wrap(~continent)

#going to manually fit the model. Blant annet visualise the residuals 





gapminder_plus %>% group_by(continent, country) %>% 
  nest()





#we assign it to a list
by_country <- gapminder_plus %>% group_by(continent, country) %>% 
  nest()

by_country$data

#siden nr 1, kun Afghanistan (nummer 1 i lista)
by_country$data[[1]]

#Her, afghanistan nr 1 
by_country

#map(list, function)


map(1:3, sqrt)

#map and apply is pretty much the same, but map is less ambigous. Map always provides a list
library(purrr)

model_by_country <- by_country %>% 
  mutate(model=purrr::map(data, ~lm(lifeExp~year, data=.x))) %>% 
  mutate(summr=purrr::map(model, broom::glance)) %>% 
  unnest(summr) %>% arrange(r.squared) %>% 
  ggplot()+
  geom_jitter(mapping=aes(x=continent, y=r.squared))

model_by_country

model_by_country$summr[[1]]

warnings()

#denne funka?
model_by_country<- by_country %>% 
  mutate(model=purrr::map(data, ~lm(lifeExp~year, data=.x))) %>% 
  mutate(summr=purrr::map(model, broom::glance)) %>% 
  unnest(summr) %>% arrange(r.squared) %>% filter(r.squared<0.6) %>% 
  select(country) %>% left_join(gapminder_plus) %>% 
  ggplot()+
  geom_line(mapping=aes(x=year, y=lifeExp, color=continent, group=country))
    facet_wrap(~continent)

    
by_country %>% 
      mutate(model=purrr::map(data, ~lm(lifeExp~year, data=.x))) %>% 
      mutate(summr=purrr::map(model, broom::glance)) %>% 
      unnest(summr) %>% arrange(r.squared) %>% filter(r.squared<0.3) %>% 
      select(country) %>% left_join(gapminder_plus) %>% 
      ggplot()+
      geom_line(mapping=aes(x=year, y=lifeExp, color=continent, group=country))
    facet_wrap(~continent)
         
    
#Denne ble riktig 
   by_country %>% 
      mutate(model=purrr::map(data, ~lm(lifeExp~log(gdpPercap), data=.x))) %>% 
      mutate(summr=purrr::map(model, broom::glance)) %>% 
      unnest(summr) %>% arrange(r.squared) %>% filter(r.squared<0.1) %>% 
      select(country) %>% left_join(gapminder_plus) %>% 
      ggplot()+
      geom_point(mapping=aes(x=log(gdpPercap), y=lifeExp, color=country))


   #Lagre data og figur slik:
   
   
saveRDS(by_country, "by_country_tibble.rds")

         #kan da få andre til å laste det opp slik:

#my_fresh_by_country  <- readRDS("by_country_tibble.rds")

#RDS = a generalized data saving tool, only readable in R 

write_csv(gapminder_plus, "gapminder_plus_for_professor.csv")








































  