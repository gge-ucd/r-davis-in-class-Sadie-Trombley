#Week 5 Code

install.packages("tidyverse") # the red arrows and text in console okay it is just warning about things named the same thing 

library(tidyverse)

surveys <- read_csv("Data/portal_daa_joined.csv") #assigned it to surveys and inmported dataset by specifying path to where I saved it. Used underscore because tidyverse

str(surveys) #tibal dataframe- a tidyverse thing, displays datatype under each column, columns are characters, never converted to factors 
#use view(surveys) to actually view in a table form in new window 

#select is used when we want to select columns 

select(surveys,plot_id, species_id, weight) #first entry is what dataset/dataframe you want to pull from then sepcify columns you want 
#gives a tible, which is a fancy name for a table or dataframe 

#use filter to filter/select rows

filter(surveys, year == 1995) #double equal signs one equal sign wont work
 #if you want to select and filter you have to create a new dataframe

surveys2 <- filter(surveys, weight < 5)
view(surveys2)

survey_sml <- select(surveys2, species_id, sex, weight)
view(survey_sml)

#pipes %>% on a PC use control-shift-M  takes all the information from left of pipe and passes to right of pipe. EX if we want to filter to weights less than five and select just first 3 columns

surveys %>% 
  filter(weight <5) %>%  #do not have to specifiy because it is done by pipping
  select(species_id, sex, weight)
#pipes combine things and keep organized, can think of a pipe as the word 'then'

#Challenge! Subset surveys to include individuals collected before 1995 and retain only the columns year, sex, and weight

challenge <- surveys %>% 
  filter(year<1995) %>% 
  select(year, sex, weight)
#in above example we can select before we filter but if yu do a lot of pipes in a row it is best to keep the same order 

#mutate is used to create new columns ex convert weigt from grams to kilograms

surveys<- surveys %>% 
  mutate(weight_kg = weight/1000) %>% 
  mutate(weight_kg2 = weight_kg * 2)
view(surveys)

#whole column will get this operation
view(surveys)
#can do multiple mutates on top of each other
#if you did not rename it to kg2 it would replace the kg column 

surveys %>% 
  mutate(weight_kg = weight/1000) %>% 
  mutate(weight_kg2 = weight_kg * 2)
#can remove NA's, is.na asks if it is a na use ! to exclude na, gets rid of all the ros that have nas in weight

surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000) %>% 
  summary()

#"complete cases" to filter out all the NAs
#CHallenge 2 on course material



surveys_hindfoot_half <- surveys%>% 
  filter(!is.na(hindfoot_length)) %>%
  mutate(hindfoot_half = hindfoot_length / 2) %>% 
  filter(hindfoot_half < 30) %>% 
  select(species_id, hindfoot_half)
summary(surveys_hindfoot_half)







































