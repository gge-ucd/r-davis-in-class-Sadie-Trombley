#Week 8
install.packages("lubridate")

library(lubridate)
library(tidyverse)


load("data/mauna_loa_met_2001_minute.rda")

as.Date("02-01-1998", format ="%m-%d-%Y")

mdy("02-01-1998")

tm1 <- as.POSIXct("2016-07-24 23:55:26 PDT")

tm1



tm2 <- as.POSIXct("25072016 8:32:07", format = "%d%m%Y %H:%M:%S")
tm2

tm3 <- as.POSIXct("2010-12-01 11:42:03", tz = "GMT")
tm3

#specifying time zone and date format in the same call
tm4 <- as.POSIXct(strptime("2016/04/04 14:47", format = "%Y/%m/%d %H:%M"), tz = "America/Los_Angeles")
  
tz(tm4)  


Sys.timezone()  #default timezone on your computer
  
#Do the same thing with lubridate 

ymd_hm("2016/04/04 14:47", tz= "America/Los_Angeles")



ymd_hms("2016-05-04 22:14:11", tz = "GMT")

nfy <- read_csv("Data/2015_NFY_solinst.csv", skip=12)

view(nfy)
glimpse(nfy)
#Use skip to get rid of first rows that are not useful

#Tangent
nfy2 <- read_csv("Data/2015_NFY_solinst.csv", skip=12, col_types = cols(Date = col_date())) #read everything as normal, but just read the column Date as a different thing 
view(nfy2)
glimpse(nfy2)


nfy2<- read_csv("Data/2015_NFY_solinst.csv", skip =12, col_types = "ccidd")
glimpse(nfy2)

nfy2$datetime <- paste(nfy2$Date, " ", nfy2$Time, sep = ",")
glimpse(nfy2)


#When you want to check what a function does put ? function in consol ex ?paste

nfy2$datetime_test <- ymd_hms(nfy2$datetime, tz = "America/Los_Angeles")
glimpse(nfy2)


tz(nfy2$datetime_test)


summary(mloa_2001)

mloa_2001$datetime <- paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, " ", mloa_2001$hour24, ":", mloa_2001$min)

glimpse(mloa_2001)

mloa_2001$datetime <- ymd_hm(mloa_2001$datetime)

mloa2 <- mloa_2001 %>% 
  filter(rel_humid != -99, rel_humid != -999) %>% 
  filter(temp_C_2m!= -99, temp_C_2m != -999) %>% 
  filter(windSpeed_m_s!= -99, windSpeed_m_s != -999)


mloa3 <- mloa2 %>%
  mutate(which_month = month(datetime, label = TRUE))
glimpse(mloa3)


mloa3 <- mloa2 %>%
  mutate(which_month = month(datetime, label = TRUE)) %>% 
  group_by(which_month) %>% 
  summarise(avg_temp = mean(temp_C_2m))


mloa3 %>% 
  ggplot()+
  geom_point(aes(x=which_month, y = avg_temp), size =3, color = "blue") + 
  geom_line(aes(x=which_month, y = avg_temp))
#Michael will get back on this


###FUNCTIONS###

log(5)

my_sum <- function(a=1, b=2){
 the_sum <- a + b
  return(the_sum)
}

#nothing shows up in console but shows up in environment

my_sum(a=5, b=8)

#Create a function that converts the temp in k to the temp in C (subtract 273.15 from k to get C)

convert <- function(K,C){
  C<- 273.15
  convert <- K - C
  return(convert)
}

convert(100)

#OR 

convert <- function(K){
  C <- K - 273.15
  return(C)
}
convert(100)


###Iteration### - if you think you will repeat something then use iteration
x <- 1:10
log(x)

# for loops 

for(i in 1:10){
  print(i)
}
  
#for each value i in vector 1 through 10 I want you to do whatever is specified in curly brackets. Prints each iteam one at a time 

print(1)
print(2)
print(3)

for (i in 1:10){
  print (i)
  print (i^2)
}
  
#we can use the "i" value as an index 

for(i in 1:10) {
  print(letters [i])
  print(mtcars$wt[i])
}


#mt cars is a built in dataset in R that you can use and play around with 
#the loop changes the value iteratively, can call your letter whatever you want, often called i
#four loops are not slow

results <- rep(NA, 10)

for(i in 1:10) {
  results[i] <- letters[i]
}

results
#;dskjfnsjan


















































