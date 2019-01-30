#Intro to Dataframes

download.file(url = "https://ndownloader.figshare.com/files/2292169", destfile = "data/portal_daa_joined.csv")

surveys <- read.csv(file = "Data/portal_daa_joined.csv")
surveys

#gives a lot of outputs so we want to slice it so it is easier to work with

head(surveys)
#took top chunk of data. first 6 rows
#dataframe is how r stores/thinks about tabular data. Every column in a dataframe is a vector. Vectors must be the same type of data or it will reassign ie characters. Below each column has one type of data (ie numbers or letters etc)

#let's look at structure
str(surveys)
#observations (34786 below) are rows variables (13 below) are columns. Dollar sign is used to break down the dataframe so you can search

#Below factors refer to the character data
dim(surveys)

nrow(surveys)
ncol(surveys)

tail(surveys)

names(surveys)
#returns a character vector of the names in dataset
row.names(surveys)

#another really useful one, can use summary to see if there is anything screwy with data through summary. A good first step. Notice NA vs blank

summary(surveys)

# subsetting dataframes

#subsetting vectors by giving them a location index

animals_vec <- c("mouse", "rat", "cat")

animals_vec[2]

# dataframes are 2D so you have to specify two areas, column and row

surveys[1,1]
head(surveys)
surveys[2,1]
#above is asking what is in second row first column

surveys[1,6]
#first row 6th column
#can veerify with head

surveys[33000,1]


#whole first column, 1 dimenions, leave other dimension blank, see below, gives whole first column as a vector 
surveys[,1]

surveys[1]

head(surveys[1])

#using a single number with no comma, like above, gives dataframe output with one column

#Below is used to pull out first 3 values in the 6th column

surveys[1:3,6]


animals_vec[c(1,3)]

c(1,3)

#pull out a whole single obeservation, give dataframe 1 row 13 columns
surveys[5,]
#important to know what you get back when you run somehting

#Use negative sign to exclude indices

surveys[1:5,-1]
surveys[-c(10:34786),]
#colon asks it to exapand ecverything into a vector, above excludes 10-34786, give data frame 13 columns and 9 rows
#know if your output is a dataframe or vector

str(surveys[-c(10:34786),])

surveys[c(10,15,20),]
surveys[c(10,15,20,10),]
#this will give row 10 twice but will call it 10.1

#more ways to subset
surveys["plot_id"]
#gives entire plot id column in dataframe

surveys[,"plot_id"]
#gives whole plot id column as a vector

surveys[["plot_id"]]

#think of dataframe as a train and each car is a column, double brackets gives what is inside of "car" column, gives single column as vector. Also single column as a vector
#we will use double brackets again with lists 
surveys$year
#using dollar sign allows you to look inside dataframe, also gives single colummn as vector 

str(surveys)
#Challenge on lesson plan below: what class  


surveys_200 <- surveys[200,]
surveys_200

surveys[nrow(surveys),]
tail(surveys)

surveys_last <- surveys[nrow(surveys),]

surveys_middle <- surveys[nrow(surveys)/2,]
surveys_middle

surveys[-c(7:nrow(surveys)),]
#above just gives first 6

#Finally, factors, when dealiing with characters ie species id or species name
#factors represent catagorical data but stored as integers with labels assigned to them, may or may not have an order associated with them
surveys$sex
#once you create a factor is a pre deteremined number of levels assoiciated with it
#creating our own factor
sex <- factor(c("male","female","female","male"))
sex
class(sex)
typeof(sex)

#levels gives back a charactor vector of the levels
levels(sex)
levels(surveys$)

nlevels(sex)
surveys <- read.csv(file = "Data/portal_daa_joined.csv")
levels(sex)

levels(surveys$genus)

nlevels(sex)

concentration <- factor(c("high","medium","high","low"))
concentration


concentration <- factor(concentration, levels = c("low","medium","high"))
concentration


#let's try adding to a factor, add new entry to a factor by using c function see below
concentration <- c(concentration, "very high")
concentration

# coerces to characters if you add a value that doesn't macth a current level
#let's just make them characters

as.character(sex)
#factors with numeric levels
year_factor <- factor(c(1990, 1923, 1965, 2018))
as.numeric(year_factor) #gives back integer
as.character(year_factor) #gives us back levels 

as.numeric(as.character(year_factor)) #gives what we are looking for an actual numeric vector


# recommended way, levels are where they are actually stored, under the hood of year factor the numbers are stored as integers in some weird alphabetical way 

as.numeric(levels(year_factor))[year_factor]

#renaming factors
sex <- surveys$sex
levels(sex)

levels(sex) [1] <- "undetermined"

levels(sex)

#can use this for example if labeling bar graph axis
head(sex)

#working with dates
#packages in R are collections of.... load using library
library(lubridate)

#installing packages do in console that way you do not keep installing each time you run something

my_date <- ymd("2015-01-01")

my_date
str(my_date)


my_date <- ymd(paste("2015","05", "17", sep = "-"))

my_date

paste(surveys$year, surveys$month, surveys$day, sep = "-")

surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))

is.na(surveys$date)
surveys$date[is.na(surveys$date)]


#why so many factors?

surveys_no_factors <- read.csv(file = "Data/portal_daa_joined.csv, stringsAsFactors = FALSE)


str(surveys_no_factors)















