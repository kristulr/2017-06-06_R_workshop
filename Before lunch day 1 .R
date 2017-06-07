# We are loading the tidyerse package by this command (remember cmd + enter to execute)

library("tidyverse")

# ggsave er kommandoen for å lagre plots/figurer

# We load the gapminder dataset by the following command 
gapminder <- read_csv(file = "data/gapminder-FiveYearData.csv")

gapminder

# The + indicates that the command continues in the next line 
## But why did we have to specify the path in the previous command (read_csv) and not in this one? 
ggplot(data = gapminder) + 
  geom_point(mapping = aes(x = gdpPercap, y = lifeExp))

# Same plot, but with an extra variable added (now 3 variables)
ggplot(data = gapminder) + 
  geom_jitter(mapping = aes(x = gdpPercap, y = lifeExp, color = continent))

# Same plot, but added log function to gdpPercap, to make the data more normally distributed.
## Again, log of gdpPercap (to increase normality) AND continent dot size decided by POPULATION numbers
## Her har vi representert 4 dimensjoner. Forventet levealder, kontinent, str kontinent, gdpPercap
ggplot(data = gapminder) + 
  geom_point(mapping = aes(x = log(gdpPercap), y = lifeExp, color = continent, size = pop))


ggplot(data = gapminder) + 
  geom_point(mapping = aes(x = log(gdpPercap), y = lifeExp), alpha=0.1, size = 2, color ="blue")


# grafer 
ggplot(data = gapminder) + 
  +   geom_line(mapping = aes(x = year, y = lifeExp, group = country, color = continent))


ggplot(data = gapminder) + 
  geom_boxplot(mapping = aes(x = continent, y = lifeExp))

# boxplot og jitter i samme figur 
ggplot(data = gapminder) + 
  geom_jitter(mapping= aes(x = continent, y = lifeExp, color = continent)) +
  geom_boxplot(mapping = aes(x = continent, y = lifeExp, color = continent))

# Det er rekkefølgen på kommandolinjene som bestemmer hvilket plot som er øverst 
ggplot(data = gapminder) + 
  geom_boxplot(mapping = aes(x = continent, y = lifeExp, color = continent)) +
  geom_jitter(mapping= aes(x = continent, y = lifeExp, color = continent))

# Samme kommando som nr 38 - 40, bare mer effektivt skrevet. Altså linje 48 
# angir hvordan variablene defineres, linje 50 og 51 forteller hvordan de skal fremstilles
ggplot(data = gapminder,mapping= aes(x = continent, y = lifeExp, color = continent)) +
  geom_jitter()+
  geom_boxplot()


# geom_jitter: sprer punktene litt mer utover for mindre overlapp, altså ikke 
# helt presis gjengivelse av data?
## geom_smooth og "lm" står for lineær modell 
### alt som står inni parantesene etter funksjon for fremstilling (jitter/smooth) gjelder kun denne funksjonen
ggplot(data = gapminder,
       mapping= aes(x = log(gdpPercap), y = lifeExp, color = continent)) +
  geom_jitter(alpha=0.5)+
  geom_smooth(method = "lm")




ggplot(data = gapminder,
       mapping= aes(x = log(gdpPercap), y = lifeExp)) +
  geom_jitter( color = continent, alpha=0.5)+
  geom_smooth(method = "lm")


# En linær modell som ikke deler kontinentene på farge. Tar derfor ut color = continent
# fra første kommando-linje , legger den kun inn på jitter. 
## NB: må da spesifisere hvor color = continent kommer fra, altså legge inn mapping = aes også
ggplot(data = gapminder,
       mapping= aes(x = log(gdpPercap), y = lifeExp)) +
  geom_jitter(mapping=aes (color = continent), alpha=0.5)+
  geom_smooth(method = "lm")


# Når du kjører denne kommandoen, skjønner ikke R at vi trenger å se på year
# som kategoriske variabler og behandler year som kontinuerlig varaibel
ggplot(data = gapminder) + 
  geom_boxplot(mapping = aes(x = year, y = lifeExp))

# Må derfor fortelle R at skal behandle "year" som kategorisk. SLIK
ggplot(data = gapminder) + 
  geom_boxplot(mapping = aes(x = as.character(year), y = lifeExp))


ggplot(data = gapminder) + 
  geom_boxplot(mapping = aes(x = as.character(year), y = log(gdpPercap)))


ggplot(data = gapminder) + 
  geom_density2d(mapping = aes(x = lifeExp, y = log(gdpPercap)))


# eksperimenter med geoms. Sjekk ut cheat sheet 


# This SPLIT THE DATA BY CONTINENT, show them in separate graphs
ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point()+
  geom_smooth()+
  scale_x_log10()+
  facet_wrap(~ continent) #tilda, dvs lille slangen, er alt-knappen + ¨^-knappen


# Her har vi fortalt R at vi ønsker linær modell. Eller velger R by default 
# ikke-lineær modell (i hvert fall så lenge vi har ikke-lineær data)
ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point()+
  geom_smooth(method = "lm")+
  scale_x_log10()+
  facet_wrap(~ year)


# by mapping we mean "mapping data to visual properties of the graph".
# derfor setter vi x og y og size og alpha o gcolor osv etter mapping
ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point()+
  geom_smooth(method = "lm")+
  scale_x_log10()+
  facet_wrap(~ continent)


#Her ser vi kun på data fra 2007, dvs reduserer datasettet til kun ett år. Snapshot av ett år 
# må ha dobbel ==
filter(gapminder, year == 2007)


#bar chart med kun 2007-data Kun en variabel - continent 
# i denne kommandoen ligger count/antall som skjult funskjon 
# In the bar-function, stat = Count is set by default 
ggplot(data = filter(gapminder, year ==2007))+
  geom_bar(mapping = aes(x = continent))


ggplot(data = filter(gapminder, year==2007, continent=="Oceania"))+
  geom_bar(mapping = aes(x = country, y = pop), stat = "identity")


  # ???? Hvorfor er bare Oceania i parantereser? 
ggplot(data = filter(gapminder, year ==2007, continent =="Oceania"))


ggplot(data = filter(gapminder, year==2007, continent=="Oceania"))+
  geom_bar(mapping = aes(x = country, y = pop), stat = "identity")





ggplot(data = filter(gapminder, year==2007, continent=="Asia"))+
  geom_col(mapping = aes(x = country, y = pop))



ggplot(data = filter(gapminder, year==2007, continent=="Asia"))+
  geom_col(mapping = aes(x = country, y = pop))+
  coord_flip()
## FIN KOMMANDO - coord_flip snur koordinatene y blir x og x blir y. Bra hvis 
## mange/navne navn/faktoerer på den horisontale linja (y?)


ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/10^6)) +
  geom_point()+
  scale_x_log10()+
  facet_wrap(~ year)

#Få det til å se pent ut : labs

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/10^6)) +
  geom_point()+
  scale_x_log10()+
  facet_wrap(~ year)+
  labs(title="Life Expectancy vs GDP per capita over time",
       subtitle= "in the last 50 years, life expectancy has improved in most countries of the world",
       caption="Source: Gapminder foundation, gapminder.com",
       x="GDP per capita, in USD",
       y = "life Expectancy in years",
       color = "continent",
       size = "population in millions")

#Altså: Title, subtitle, caption (sistnevnte er eks datakilde)


##slik lagrer vi figuren 

ggsave("my_fancy_plot.png")


f









































































  















              
