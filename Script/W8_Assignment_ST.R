#Week 8 Assignment

library(tidyverse)
library(lubridate)

am_riv <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFA_solinst_08_05.csv", skip = 13)

glimpse(am_riv)


am_riv$datetime <- paste(am_riv$Date, " ", am_riv$Time)
glimpse(am_riv) #Made datetime column using paste 


am_riv$wk <- week(am_riv$datetime) #made week column 


am_riv2 <- am_riv %>% 
  group_by(wk) %>% 
  summarize(mean_wk = mean(Temperature), min_wk = min(Temperature), max_wk = max(Temperature)) #calculated mean, min, and max weekly temps

glimpse(am_riv2)

#Graphing the above
am_riv2 %>% 
  ggplot()+
  geom_point(aes(x=wk, y = mean_wk), color = "blue")+
  geom_point(aes(x=wk, y = min_wk), color = "red")+
  geom_point(aes(x=wk, y = max_wk), color= "dark green")+
  xlab("Week Number")+ ylab("Temperature")+
  theme_bw()

am_riv$hourly <- hour(am_riv$datetime) #hourly column 
am_riv$month <- month(am_riv$datetime) #month column 


am_riv3 <- am_riv %>% 
  filter(month == 4 | month == 5 | month == 6) %>% 
  group_by(hourly, month, datetime) %>% 
  summarize(mean_level = mean(Level)) #Used answer key for this, found mean hourly level for April through June 

#plot 
am_riv3%>% 
  ggplot()+
  geom_line(aes(x=datetime, y = mean_level), color = "red") +
  ylim(1.1, 1.9)+
  theme_bw()
#  got warning message about group aesthetic 


#Part 2 to be continued 


















