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
load("data/mauna_loa_met_2001_minute.rda")

#datetime column
mloa_2001$datetime <- paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, "-", mloa_2001$hour24, ":", mloa_2001$min)

glimpse(mloa_2001)

#datetime format
mloa_2001$datetime <- ymd_hm(mloa_2001$datetime)

#removing NAs 
mloa2 <- mloa_2001 %>% 
  filter(rel_humid != -99, rel_humid != -999) %>% 
  filter(temp_C_2m!= -99, temp_C_2m != -999) %>% 
  filter(windSpeed_m_s!= -99, windSpeed_m_s != -999)

glimpse(mloa2)

#the function
plot_temp <- function(monthtoimput, dat = mloa2){
  df <- filter(dat, month == monthtoimput)
  plot <- df %>% 
    ggplot()+ geom_line(aes(x=datetime, y = temp_C_2m), color = "red")+
    theme_bw()
  return(plot)
}

plot_temp(3)
#Whe writing the function, tell input and what you want to use, we can tell it to use things that do not exist, things that are just in the function

plot_temp <- function(monthtoinput, dat = mloa2 )
  #testing the function, should get a plot for just March temps. You can give no defaults to a function or you can set a default if you will be using it a lot 
  
  plot_temp(3)
#not working...

















