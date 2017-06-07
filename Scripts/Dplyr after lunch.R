
#dplyr

rep("this is an example", times=3)

"this is an example" %>% rep(times=3)

#Pipe symbol mac: Shift + cmn + m 


#Making a new dataset from the original one with fewer variables/coloumns
year_country_gdp <- select(gapminder, year, country, gdpPercap)

year_country_gdp

#head commando - only shows the first 6 rows of a dataset
head(year_country_gdp)

#Skjønte ikke dette med select function/pipe it 
year_country_gdp <- gapminder %>% select(year, country, gdpPercap)

#I took the gapminder dataset and piped it to the filter function --> hva betyr det?
## OBS: Må være dobbelt == før 2002. Vil bare ha med data hvor 2002  = sant
gapminder %>% 
  filter(year==2002) %>% 
  ggplot(mapping =aes(x=continent, y=pop))+    #det vi skriver her blir gjeldende for følgende linjer
  geom_boxplot()


year_country_gdp_euro <- gapminder %>% 
  filter(continent =="Europe") %>% 
select(year, country, gdpPercap)


year_country_gdp_euro

year_lifeExp_gdpPercap_Norway <- gapminder %>% 
filter(country=="Norway") %>% 
select(year, lifeExp, gdpPercap)

#Gruppere på variabel: group_by 
gapminder %>% 
  group_by(continent)


gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdpPercap=mean(gdpPercap))
#Her: Laget ny variabel - mean_gdpPercap per kontinent 

gapminder %>% 
  summarize(mean_gdpPercap_allcontinents=mean(gdpPercap))

gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdpPercap=mean(gdpPercap)) %>% 
  ggplot(mapping =aes(x=continent, y=mean_gdpPercap))+    #det vi skriver her blir gjeldende for følgende linjer
  geom_point()


#Feil?
averagelife_asia <- gapminder %>% 
  filter(continent=="Asia") %>% 
  summarize(averagelife_asia = mean(lifeExp))

#Fasit - også feil. 
#  NB: alt + 7 gir vertical bar 
gapminder %>% 
  filter(continent=="Asia") %>% 
  group_by(country) %>% 
  summarize(meanlifeExp=mean(lifeExp)) %>%


gapminder %>% 
filter(continent=="Asia") %>% 
group_by(country) %>% 
summarize(meanlifeExp=mean(lifeExp)) %>%  
ggplot(mapping = aes(x=country, y=meanlifeExp))+
geom_point()+
coord_flip()

gapminder %>% 
  mutate(gdp_billion=gdpPercap*pop/10^9) %>% 
  head()

gapminder %>% 
  mutate(gdp_billion=gdpPercap*pop/10^9) %>% 
  group_by(continent, year) %>% 
  summarize(mean_gdp_billion=mean(gdp_billion))

#Both the mutate and the summarize create new variables. 
#The mutate does not do anything to the size of our dataset, but the summarize 
#summarizes datapoints into one variable

gapminder_country_summary <- gapminder %>% 
group_by(country) %>% 
  summarize(mean_lifeExp = mean(lifeExp))


library(maps)
         
         
         
         
         
         
map_data("world") %>% 
 rename(country=region) %>% 
  left_join(gapminder_country_summary, by="country") %>% 
  ggplot()+
  geom_polygon(aes(x=long, y=lat, group=group,fill = mean_lifeExp))+
  scale_fill_gradient(low="blue", high="red")+
  coord_equal()
















