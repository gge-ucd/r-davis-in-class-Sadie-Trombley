#Load packages to get started 

library(tidyverse)

####finishing up dplyr========================


surveys <- read_csv("Data/portal_daa_joined.csv")

#we will learn how to create a plot to look at how species abundances have changed overtime, we need to get rid of NA values and get rid of "rare" species (those seen less than 50 times)


#take all NAs out of weight column, hindfoot_length, and sex column

surveys_complete <- surveys %>% 
  filter(!is.na(weight), !is.na(hindfoot_length), !is.na(sex))

 #remove the species that have less than 50 observations

species_counts <- surveys_complete %>% 
  group_by(species_id) %>% 
  tally() %>% 
  filter(n >= 50)


surveys_complete <- surveys_complete %>% 
  filter(species_id %in% species_counts$species_id)

#%in% says to take species id in specified columns, can also use to 
#use $ to call columns from dataframes 
#asking if this value is somewhere in species counts, species id will give a true or false

species_keep <- c("DM", "DO")

#writing a dataframe to a .csv this is good for saving so you can send to people and they can easily view, specify path of where you want it saved and after / is name, you can name it whatever you want

write_csv(surveys_complete, path = "Output/surveys_complete.csv")


####ggplot time! =========================================== 
#the above format can be used to quickly navigate to different sections, use ts tab to timestamp like below 
# Tue Feb 12 14:31:25 2019 ------------------------------

#rather than sending things through a pipe like we did last week, ggplot is a blank canvas that you build on 

#ggplot(data = DATA, mapping = aes(MAPPING)) + 
#geom_function()
#mapping is anyway that your data is going to get translated onto the plot, anything that requires translation of data into graph use mapping 
#geom put points lines etc on your (plot?)

ggplot(data = surveys_complete)



#define a mapping, first row is setting up canvas and after the + we are specifyiing what we want to put on it

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()


#saving a plot object
surveys_plot <- ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))

surveys_plot +
  geom_point()


#Challenge
install.packages("hexbin")

surveys_plot +
  geom_hex()

#shows density of points
#click plots in lower right panel and then click zoom to make large

#we are going to build plots from the ground up

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))

surveys_complete %>% 
  ggplot(aes(x = weight, y= hindfoot_length)) +
  geom_point(alpha =0.1, color= "tomato")
#alpha defines...

#global vs within geom

#using data in geom
surveys_complete %>% 
  ggplot(aes(x=weight, y = hindfoot_length))+
  geom_point(alpha = 0.1, aes (color = species_id))

#geom point goes into dataframe and 
#putting color as a global aesthetic 
surveys_complete %>% 
  ggplot(aes(x=weight, y=hindfoot_length, color = species_id)) +
  geom_point(alpha=0.1)


#using a little jitter, prevents over crowding of points, prevents them from laying right on top of each other

surveys_complete %>% 
  ggplot(aes(x=weight, y=hindfoot_length, color = species_id)) +
  geom_jitter(alpha=0.1)
#ggplot can make a lot of types of plots we aare covering basics
#moving to boxplots

surveys_complete %>% 
  ggplot(aes(x= species_id, y = weight)) +
  geom_boxplot()

#adding points to boxplot

surveys_complete %>% 
  ggplot(aes(x= species_id, y = weight)) +
  geom_jitter(alpha=0.01, color= "tomato") +
  geom_boxplot(alpha = 0)

#order matters, if you paint over the boxplots you won't be able to see them, try to twaek parameters to see thw best display of datd 

#plotting time series 
yearly_counts <- surveys_complete %>%
  count(year, species_id)

yearly_counts %>% 
  ggplot(aes(x=year, y =n, group = species_id, color=species_id)) +
  geom_line()

#geom line pulls out specfifc... 

#facetting, small digestable figures
yearly_counts %>% 
  ggplot(aes(x = year, y = n, color=species_id)) +
  geom_line() +
  facet_wrap(~species_id)

# including sex
yearly_sex_counts <- surveys_complete %>% 
  count(year, species_id, sex)

yearly_sex_counts %>% 
  ggplot(aes(x=year, y=n, color=sex)) +
  geom_line() +
  facet_wrap(~ species_id)

#Changing theme in ggplot so your grpah does not look so basic
yearly_sex_counts %>% 
  ggplot(aes(x=year, y=n, color=sex)) +
  geom_line() +
  facet_wrap(~ species_id) +
  theme_bw() +
  theme(panel.grid = element_blank())

ysx_plot <- yearly_sex_counts %>% 
  ggplot(aes(x=year, y=n, color=sex)) +
  geom_line() +
  facet_wrap(~ species_id) 
  
  #Can save a plot and aadd things on, check out ggthemes

ysx_plot + theme(minimal)

#ctrl Z to undo

yearly_sex_weight <- surveys_complete %>% 
  group_by(year, sex, species_id) %>% 
  summarise(avg_weight = mean (weight))

yearly_sex_weight %>% 
  ggplot(aes(x=year, y=avg_weight,color=species_id)) +
  geom_line() +
  facet_grid(sex ~ .)

#above sex is a row and . shows we want all columns, if you want to specify some otehr binary variable you can put that instead of . then each row would be male or female and the column would be the other things
#facet_grid uses rows ~ columns for facetting. the "." indictes nothing in this dimension

yearly_sex_weight %>% 
  ggplot(aes(x=year, y=avg_weight,color=species_id)) +
  geom_line() +
  facet_grid(. ~ sex)

#Adding labels and stuff
yearly_sex_counts %>% 
  ggplot(aes(x=year, y=n, color=sex)) +
  geom_line() +
  facet_wrap(~ species_id) +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  labs(title = "observed species through time", X= "Year of observation", y = "number of sppecies") +
  theme (text = element_text(size = 16)) +
  theme(axis.text.x = element_text(color = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5))
  
  
  #can save ggplot that you like and call it again
  ggsave("figures/my_test_facet_plot.tiff")




























