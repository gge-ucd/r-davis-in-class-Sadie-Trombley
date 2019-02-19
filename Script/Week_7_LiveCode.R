#Week 7 Live Code

#Data visualization

#ggplot grammar of graphics

#everything on plot is information people have to understand so make it simple so they can quickly look and understand what you are trying to convey. How much of the ink is converying information. Spend a lot of times on plots/figures some people only concentrate on this when reading your paper.Be thoughtful of colorblind people no red and green. Virdis in ggplot is colorblind friendly and prints well in grayscale. Stay away from rainbow because the colorscale has hard divides. ALso ggthemes package has cool themes, can also color brewer to see color schemes with good propertie, also Rcolorbrewer package that allows for schemes/ scales.

#visualization dos
#make sure each thing on plot expresses something, color to reprsent categories, do not need to label every point, where your scale starts start at zero or wherever it makes sense for your data but usually zero is good. Include all your data. Keep things simple ie do not put two y axis on same plot. Exclude color unless necessary. Avoid 3D plots. If you have more categories than you can express with more than 6 colors find a way other than color to express them. Simple font.
#See link at bottom of course materials tab in visualization dos and don't 50 ggplots to use with code 
#facceting breaks up the same plot base on some category


#Cowplots groups together multiple plots


#How to install a package from Github, (most packages in CRAM-the official R place), other less legit but often useful packages are published on GitHub
#devtools below is from CRAM

install.packages("devtools")
#When installing part of a package use :: and to install from github use below

devtools::install_github("thomasp85/patchwork")

#A lot of links to books on data visualization on Rdavis website
#Use visualization to simply tell the takeaway story



###Data import and export ###
library(tidyverse)
#Use skip in this case the first two rows were not the labels you wanted they were notes

wide_data <- read_csv("Data/wide_eg.csv", skip = 2)

#if you do not see a carrot in console that means something else is running, in this case devtools was running in background so I was getting error. To get rid of this just click into console and click esc

#loaded an RDA file that contained a single R object. RDA files can contain one or more R objects

load("Data/mauna_loa_met_2001_minute.rda")

#write wide_data to an rds file 

saveRDS(wide_data, "Data/wide_data.rds")
# remove wide_data

rm(wide_data)

wide_data_rds <- readRDS("data/wide_data.rds")
#use rds for modeling, if a model will take a long time to run you can save as rds and it will save so you can view it the next day vs csv is best for tables, rds only readable by R but a csv is redaable. RDS will save the steps you took. Also rds is more compact than csv.

#saveRDS() and readRDS() for .rds files, and we use save() and load() for .rds files

#readxl:: will look at all the sheets you have in an excel file, useful for my trapping data where each session is a sheet
#other packages: readxl, googlesheets, and googledrive, forgein::

#rio coontains a bunch of packages from other file extensions and picks the fastest function to read in based on extension file, use to import and export data. SEe their github site

library(rio)


###Talking about Date Time data###
install.packages("lubridate")

library(lubridate)

#three types of dates in R
#date for just dates no times, simplier
#POSIXCT or LT to look at times too, newer version is ct

sample_dates1 <- c("2016-02-01", "2016-03-17", "2017-01-01")

as.Date(sample_dates1)

#as.date looking for data that looks like YYYY MM DD

sample.data2<- c("02-01-2001", "04-04-1991")

as.Date(sample.data2)

#To solve this issue tell computer what you are looking for 

sample.date2<- as.Date(sample.data2, format = "%m-%d-%Y")
#upper case Y dictates for numbers y dictates two

as.Date("2016/01/01", format= "%Y/%m/%d")

#Jul 04, 2017

as.Date("Jul 04, 2017", format = "%b%d, %Y")

#b represents shortened month, B is full month name
#Date calculations

dt1 <- as.Date("2017-07-11")

dt2 <- as.Date("2016-04-22")

#in the above we did not have to specify format because it is written the way as.Date likes it

dt1

print(dt1 - dt2)

#time difference in weeks

print(difftime(dt1, dt2, units = "week"))

#Can create sequences, below it will jump every week for 6 weeks

six.weeks <- seq(dt1, length = 6, by="week")

challenge <- seq(dt1, length = 10, by="14 days")

#using lubridate package to simplify above

ymd("2016/01/01")

dmy("04.04.91")

mdy("Feb 19, 2005")




























