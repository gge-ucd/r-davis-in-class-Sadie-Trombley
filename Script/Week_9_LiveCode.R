#Week 9 Live Code

m
### Back to Iteration ###

# a seriees of functions that have "apply" in them, all the applies do slightly different things, sapply give a the simplest output
#first arguement is the data/ thing you want to iterate ACROSS, and the second argument is the function you want to APPLY to each thing 

sapply(1:10, sqrt)
sqrt(1:10)


#for loop first
result <- rep(NA, 10)

for (i in 1:10) {
  result[i] <- sqrt(i) / 2
}
result


#now to use sapply
result_apply <- sapply(1:10, function(x) sqrt(x)/2)

result_apply


#additional arguments in apply
mtcars_na <- mtcars
mtcars_na[1, 1:4] <- NA

sapply(mtcars_na, mean)

sapply(mtcars_na, mean,, na.rm = T)

#type ?function and ctrl enter in console to check what it does. EX ?mean

mean(mtcars_na$hp, na.rm = T)

#backto tidyverse

library(tidyverse)

mtcars %>%
  map(mean)


mtcars %>% 
  map_dbl(mean)


mtcars %>% 
  map_chr(mean)

#map2_for two sets of inputs

map2_chr(rownames(mtcars), mtcars$mpg, function(x,y) paste(x, "gets", y, "miles per gallon"))

#chr tells maps we want everything we get  back to be a character 

#complete workflow
#attempt to scale our weights of mtcars
(mtcars$wt[1] - min(mtcars$wt)) / (max(mtcars$wt) - min(mtcars$wt))

#generalize 

(x - min(x)) / (max(x) - min(x))

#make that into a function
rescale_01 <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

rescale_01(mtcars$wt)


map_df(mtcars, rescale_01)























