#2

install.packages("tidyverse")

library(tidyverse)

surveys <- read_csv("Data/portal_daa_joined.csv")

#3

surveys_2 <- filter(surveys, weight >30)
view(surveys_2)
surveys_3 <- filter(surveys_2, weight < 60)
view(surveys_3)

#4

biggest_critters <- surveys_3 %>% 
  group_by(sex, species_id) %>% 
  summarise(max_weight=max(weight))

biggest_critters %>% 
  arrange(max_weight) %>% 
  view()

#5

surveys_3 %>% 
  filter(is.na(sex)) %>% 
  group_by(species_id) %>% 
  tally() %>% 
  arrange()


surveys_3 %>% 
  filter(is.na(sex)) %>% 
  group_by(plot_id) %>% 
  tally() %>% 
  arrange() 


surveys_3 %>% 
  filter(is.na(weight)) %>% 
  tally()

surveys_3 %>% 
  filter(is.na(hindfoot_length)) %>% 
  tally()

surveys_3 %>% 
  filter(is.na(genus)) %>% 
  tally()
  

#6

surveys_3_avg_weight <- surveys_3 %>% 
  filter(!is.na(weight)) %>% 
  group_by(species, sex) %>% 
  mutate(avg_weight = mean(weight)) %>% 
  select(species, sex, weight, avg_weight)

view(surveys_3_avg_weight)

#7
surveys_avg_weight <- surveys_avg_weight %>% 
  mutate(above_average = weight>avg_weight)

?scale


#8

surveys_scaled <- surveys %>% 
  group_by(species) %>% 
  mutate(scaled_weight = scale(weight)) %>% 
  arrange(scaled_weight)

surveys_scaled <- surveys %>% 
  group_by(species) %>% 
  mutate(scaled_weight = scale(weight)) %>% 
  filter(!is.na(scaled_weight)) %>% 
  arrange(scaled_weight) %>% 
  tail()























