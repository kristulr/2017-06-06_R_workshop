download.file(url = "https://raw.githubusercontent.com/dmi3kno/SWC-tidyverse/master/data/gapminder_plus.csv", 
              destfile = "Data/gapminder_plus.csv")

library("tidyverse")

gapminder_plus <- read_csv(file = "Data/gapminder_plus.csv")

gapminder_plus


#filter to africa
#mutate - make new variable - infant mortality rate (number of babies dead)
#filter: only year 2007
#join gapminder plus with first gapminder dataset



#1e3 er snarvei for 1000 :) 
#Inner join: Selects only the data that are matcihng/overlapping in two data sets. 
#Full join: Bring all data into one table
#Lefft join: Retaining everything we have on the left side (like in this function - the countries)
#while we drop the rest. In this case - we drop most of the data, we just retain the data belonging to the countries selected
#Semijon? 

#In order for gather to work, u need to specify key (columns) and values (datapunktene)
#Når bruker gather: key/columns, altså variabelens navn, gjentatt nedover på hver rad.

gapminder_plus %>% 
  filter(continent=="Africa", year==2007) %>% 
  mutate(babiesDead=infantMort*pop/1e3) %>% #delt på 1000
  filter(babiesDead>2e6) %>%  #kun de som har over 2 mill døde babyer
  select(country, babiesDead) %>%  
  left_join(gapminder_plus) %>% 
  mutate(babiesDead=infantMort*pop/1e3, 
         gdp_bln=gdpPercap*pop/1e9,
         pop_mln=pop/1e6) %>% 
  select (-c(continent, pop, babiesDead)) %>% 
  gather(key= variables, value= values, -c(country, year)) %>% #skjønte ikke helt dette?
  ggplot(.) +  #Punktum --> all data listet over inn her hvor punktum er (men er også default, altså uten punkum og bare tom parates er dette default)
  geom_text(data=. %>% filter(year==2007) group_by(variables) %>% 
              mutate(max_value=max(values)) %>% 
              filter(values==max_value),
            aes(x=year, y=values, label=country, color=country))+
  geom_line(mapping=aes(x=year, y=values, color=country))+
  facet_wrap(~variables, scales="free_y")+
  labs(title="ettellerannet", 
       subtitle="noeannet",
       caption="cPTION", y=NULL, x="YEAR")+
  theme_minimal()+
  theme(legend.position="none")
  

  
#de to siste kolonnene i tabellen som lages av denne funksjonen: meaning of the variable and the value of the variable

#Cheat function: View()
#Viser dataene i spreadsheet







































