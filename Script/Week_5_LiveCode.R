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
summary(surveys_hindfoot_half) #the order of the commands is important for some things to get correct output, ie cannot select hindfoot path before you create it 

#if you want to just filter out something specific
#below we will split up dataframe manipulate parts and put it back together
#group by is good for split-apply -combine, usually use summarize after this
#want mean weight of males and mean weight of females

surveys %>% 
  group_by(sex) %>% #if we just ran this it would not look any different to our eyes but R has grouped the varaibles by sex 
  summarize(mean_weight = mean(weight, na.rm = TRUE)) #This removed nas from calculation to find mean weight, did not remove the nas from the dataframe
#group b y some character value and then summarize specifies what we want to do to those groups, difference between mutate and summarize is that mutate adds new columns to existsing dataframe, summarize spits out entirely new dataframe/tible
#you can group by multiple columns 

surveys %>% 
  group_by(sex) %>% 
  mutate(mean_weight=mean(weight, na.rm = TRUE)) %>% view #a nice weigh to just view without saving

is.na(list(surveys$weight))

list(is.na(surveys$weight))

#to look at all nas in the data frame 

surveys %>% 
  filter(is.na(sex)) %>% 
  view


#makes summary table of what you ask to look at, tells us where the NAs are in the species
surveys %>% 
  group_by(species)
  filter(is.na(sex)) %>% 
  tally()

#you can use group_by with muliplte columns

surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight), min_weight = min(weight)) %>% 
  view
#remove missing value from weight before calculating summary stats
#if you get NAN-not a real number, often happens if you divide by 0
#can group and summarize in multiple ways through pipping

#tally function, when working with datasets we often want to know number of obs found for each variable

surveys %>% 
  group_by(sex, species_id) %>% 
  tally() %>% 
  view
#with tally we are generating a tible, could generate a dataframe if we assign it

tally_df <- surveys %>% 
  group_by(sex, species_id) %>% 
  tally() %>%
  view
#tally is counting, summarize performs a function
#tally () same as group_by(something) %>%  summarize(new_column = n())
#summarize and summarise the same 



#gathering and spreading
#How to get a table that compares mean weight of each species in eaxh plot

#spreading takes long format data frame (many rows, few columns) and spreads it out into a wide dataframe (many columns few rows) Use instead of pivot table on excel

#Spread

surveys_gw <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarise(mean_weight = mean(weight)) %>% 
  view
surveys_gw


surveys_spread <- surveys_gw %>% 
  spread(key = genus, value = mean_weight) %>% 
View

#look over course material and lecture notes for clarifications
#Can change nas into 0's, sometimes you do not want to remove nas because then the whole row goes away

surveys_gw %>% 
  spread(genus, mean_weight, fill = 0) %>% 
  view

#Gathering do not use often because you do not often get long dataframes you want to make wide

surveys_gather <- surveys_spread %>% 
  gather(key = genus, value = mean_weight, -plot.id) %>% 
  view

#above told it to use all the columns other than plot.id to fill up genus
#got error, idk why







































