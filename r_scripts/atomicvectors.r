# this is a document describing vectors in R 
# 22 January 26
# Sof Antelo
#----------------------------------------------
#Start
#assignment operator is <- 

x <- 5 #cmd retun makes it run 
print (x) #function: command that does a specific thing, has input and output, (arguments) specify parameters of command
y = 3 #this also created the Y object and assigned it 3 and printed it

plant_height_and_weight <- 3 #snake case
plantHeight <- 4 #camel case 
plant.height <- 2 #not preferred, r automatically does it some time but its not good
#whichever case you start with, use that for the whole script
# . reserve for temp variable 

# homogenous data type: homogeneous(everythings the same eg. all integers), heterogeneous (multiple types eg. integers, leters, etc. erogenous)
# DIMS, homo, hetero
# 1D, Vector, list
# 2D, matrix, data frame 
# ND, array, list of lists 

#character strings, 1d atomic vector
z <- c(3.2, 5, 5, 6) #c() makes the vector
print(z)
typeof(z) #what type variable 

z <- c(c(3.2,3),c(3,5)) 
print(z)
z
is.character(z) #confirms it is variable type by tru or false

#character strings 
t <- "perch"
print(t)

t <- c("perch", "bass", "trout") #looks like one but its two, use t[number], to show which one u want
print(t)
t[3] #other languages start at 0 as the first position, in r it starts at 1

# logical/boolean --- True v False 
z <- c(TRUE, FALSE, TRUE)
print(z)

is.logical(z) #proves its boolean is says TRUE
typeof(z) #will tell is its logical

c(T, F) #can work instead of full word, but can get tricky with variable names
mean(z)

#properties of a vector 
# type, length, naming 

# type 
z <- c(1.1, 1.2, 3, 4.4)
typeof(z) #gives type
is.numeric(z) #is. gives logical response
d <- as.character(z) #as. coerces variable, so now this is a character string not numeric
print(d)
typeof(d) 
#if there are any " " in your vector R will automatically coerce it to character eg. c(1,2,"3",4)


# length
length(d) #number of things in vector, important for looping

#naming 
#random number generator
w <- runif(5) #uniform, with number of outputs requesting 
names(w) #gave us a null, we havent created any names yet
print (w) #just values, no names

names(w) <- c("A", "B", "C", "D", "E") #gave names, doesnt afect numeric status of variable
print(w) 
mean(w)
print(w) <- NULL #resets the names

# special data types 
z <- c(3.2, 3, 3, NA) #NA is a special
print(z)
typeof(z) #double (numerics with integer and decimal)
length(z) #4
typeof(z[4])
sum(z) #cant sum because NA is a missing value
sum(z, na.rm=TRUE) #removes any NA that might be present, NA IS NOT 0, 0 IS A VALUE, NA IS LACK OF VALUE

z <- 0/0
z #NaN, missing 
z <- 1/0
z #infinity

# vectorization
z <- c(10, 20, 30)
z + 1 #everything gets 1 added to it

y <- c(1, 2, 3)

z + y

#recycling
x <- c(1, 2)
z + x #because there is uneven terms (z has 3 and x has 2) the terms recycle


################################################################
#atomic vectors pt 2 1/27/26

z <- vector(mode = "numeric", length = 0) # mode logical, numeric, etc. length = length
print(z)


z <- c(z, 5) #dynamic creation, made the legnth 5 (don't do in in R, but do it in python)
print(z)

#predefined length 
z <- rep(0, 100) #rep takes what you wanna repeat and how many times you want to repeat it
length(z) 

#we can also create an empty vector 
z <- rep(NA, 100) #vector of NA is always logical rather than numeric making it easier to manipulate later
z

typeof(z)

z[1] <- "Vermont"
head(z)
#creating a large vector with NAs but having a predefined length is easier than dynamic creation 

#efficiently naming in large vectors 

my_vector <- runif(n=100)
#sequence "seq" function can help assign names to the random numbers 
my_names <- paste("Species", seq(1:length(my_vector)), sep = "") #sep is how to separate them, we did nothing 
print(my_names)

names(my_vector) <- my_names

head(my_vector)
str(my_vector)

#using the rep function
rep(0.5, 6) #less readable in future
rep(x = 0.5, times = 6) #more readable in future 

my_vec <- c(1,2,3)
#repeat a vector 
rep(x = my_vec, times = 2) #repeat vector 2 times

rep(my_vec, times = 2, each = 2) #each repeats each element two times

# sequencing vectors 
seq(from = 2, to = 4) 
2:4 #commonly used shorthand in r

x <- seq(from = 2, to = 4, length = 7) #sequence between 2 and 4 with 7 values, evenly spaced

my_vec <- 1:length(x) #commonly used in other languaged but is slow
my_vec 

#better to use in R : sequence along 
seq_along(my_vec)

#generating random vectors

runif(5) #five values from 0 to 1
#paramaters
runif(n = 3, min = 100, max = 101)

set.seed(123) #takes any number and gives you the same progression of random numbers
runif(n = 1, min = 0, max = 1) 

#those are uniform distributions, lets do a normal distribution
out <- rnorm(n = 500, mean = 100, sd = 30) 
hist(out) #makes a histogram 

#random sampling

long_vec <- seq_len(10)
sample(x=long_vec, size = 2) #takes 2 values (size = 2) from the 10 values in long_vec

sample(x=long_vec, size = 2, replace = T)

sample(x=long_vec, size = 100, replace = F)  

#weighted samping from a vec
weights <- c(rep(10,5), rep(90,5)) #vector with 2 repeated 5 times and 100 printed 5 times

sample(x=long_vec, replace = TRUE, prob = weights)
#this is good to use when you need random sampling from normal dist where you know there are some values more likely than others

z <- c(3.1, 9.2, 1.3, 0.4, 7.5)
print(z)

#indexing
z[1] #gives the first value of z
z[c(2,3)] #this gives you a vector of which to do the indexing (so this would take the second adn third values). called slicing

#using logicals 
z[z < 3] #selects the indexes that are less than 3

z[!z<3] #selects the values that are not (!) less than 3

#relational operators
# < less than
# > greater than
# <= less than or equal to
# >= greater than or equal to
# == equal to

#logical operators
# ! not
# & and (vector)
# | or (vector)
# xor(x,y) #"exclusive or" wants only one to be true, will have outcome of "FALSE" if they are both true or both false

x <- 1:5
y <- c(1:3,7,7)

x == 2
x != 2

x == 1 & y == 7 #using and

x == 1 | y == 7 #using or
x == 3 | y == 7
x == 3 | y == 3

x == 3 & y == 3

xor(x==3, y==3)

# subscripting with missing values 
set.seed(90)
z <- runif(10)

z < 0.5
z[z < 0.5]

which (z < 0.5) #gives which indexes are < 0.5 

zd <- c(z, c(z,NA, NA)) #added the 2 NA's to the z vector
zd

zd[zd < 0.5] #NA's are included, this is the boolean version, looking for true or false

#dropping NAs with which to index
zd[which(zd < 0.5)] #gives us values but not NAs, 
