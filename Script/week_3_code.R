#week_3_class_code


read.csv("Data/Tidy.csv")

x <- 4


# vectors


weight_g <- c(50, 60, 31, 89)

weight_g


#now characters

animals <- c("mouse", "rat", "dog", "cat")
animals


#vetor exploration tools
length(weight_g)

length(animals)

class(weight_g)

class(animals)


#str is go to first tool for looking at an object

str(x)


str(weight_g)

# be careful when adding values and running this line multiple times

weight_g <- c(weight_g, 105)
weight_g

weight_g <- c(25, weight_g)
weight_g

# six types of atomic vectors: "numeric" ("double"), "character", "logical" (true or false), "integer" (whole round numbers, any decimals is a double), "complex", "raw"

# first four listed are thee main ones we work with

typeof(weight_g)


weight_integer <- c(20L, 21L, 85L)
class(weight_integer)
typeof(weight_integer)

num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

class(num_char)
class(num_logical)
class(char_logical)
class(tricky)

#if you put a single character into vector whole things is classified as character, num_logical converted true into 1 and false 0 therefore numeric, char_logiccal turned into all characters because of qoutations


num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)
class(combined_logical)

#R will swicthed all the values in vector to be the same type, startinbg as simplest "character" and then goes to "numbers", then integers then true false, must be TRUE FALSE in all caps can be turned into 0 and 1 or characters 



# subsetting vectors
animals


animals[3]

animals[2, 3]

animals[c(2, 3)]

animals[c(3, 1, 3)]


#conditional subsetting
weight_g
weight_g[c(T, F, T, T, F, T, T)]


weight_g > 50

weight_g[weight_g > 50]

#multiple conditions
weight_g[weight_g < 30 | weight_g > 50]

# for "or" shift backslash = |

weight_g[weight_g >= 30 & weight_g == 89]


#searching for characters

animals[animals== "cat" | animals== "rat"]

animals %in% c("rat", "antelope", "hippogriff")

#challenge

"four" > "five"
"six" > "five"
"eight" > "five"

"a" > "b"
# it is ranking alphabetical order above....

#missing values 

hieghts <- c(2, 4, 4, NA, 6)
str(hieghts)

mean(weight_g)

mean(hieghts)
max(hieghts)


mean(x = hieghts,na.rm = TRUE)
max(hieghts,na.rm = TRUE)


is.na(hieghts)
na.omit(hieghts)
complete.cases(hieghts)



























































