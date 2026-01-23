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