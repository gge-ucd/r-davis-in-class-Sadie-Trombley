library(tidyverse) #loaded package to get started

gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")
#Saved data set in data folder


ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()
#change in life expectancy over time


ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()


ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

#scale_x_log10 is log tranforming the data so it has a normal distribution  for the linear regression

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  theme_bw()

#geom_smooth () specifies the characteristics for the best fit line for the regression


#Challenge
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent,size=pop,alpha=.3)) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()


