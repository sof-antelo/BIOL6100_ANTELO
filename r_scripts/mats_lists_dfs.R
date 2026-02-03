# Sof Antelo notes on lists, matrices, and data frames lecture 1/29/26
###############################################################

###creating a matrix from a vector 
my_vec <- 1:12
my_vec
#numbers by rows
m <- matrix(data = my_vec, nrow = 4)
m
#by filling matrix the other way 
m <- matrix(data = my_vec, ncol = 3, byrow = T)
m
#matrix can only have one variable type at a time 

### lists: 
my_list <- list(1:10, matrix(1:8, nrow = 4, byrow = T), letters[1:3], pi)
print(my_list)

###########[[n]] = number of the element in the command (list then matrix, then rows, etc.)

#indexing a list
my_list[1] #shows the element
str(my_list[1]) #struture

x <- my_list[[1]] #double braket for object within list
str(x)

#indexing into a matrix
my_list[[2]][1,2]

#naming a list 
my_list2 <- list(tester = FALSE, little_m = matrix(1:9, nrow = 3)) #tester is a boolean value, little is the matrix
print(my_list2)

#accessing named objects in lists
my_list2$little_m
my_list2$little_m[2,3] #indexing in little

#looking at empty place indexing
my_list2$little_m[1,]  #gives us the first row
my_list2$little_m[,1] #gives us the column
my_list2$little_m[1] #makes it treat it like a vector, so it would give you the first thing 

# unlist
#takes everything out of a list and coerces it into a vector
unrolled <- unlist(my_list2)
unrolled

#unoacking complex lists 
#make sure to call ggplot2 library(ggplot2)

#create random vars
y_var <- runif(10)
x_var <- runif(10)

#regress (linear regression)
my_model <- lm(y_var~x_var)

#plot it 
qplot(x=x_var, y = y_var) #qplot is a shorthand way of using basic ggplot 

print(my_model)
summary(my_model)

str(summary(my_model)) #structure

#extracting pvalue
summary(my_model)$coefficients[1,1] #can also use the names 

u <- unlist(summary(my_model))
print(u)
u$coefficients2


#data frames

#making variables
var_a <- 1:12
var_b <- rep(c("A", "B", "C"),4)
var_c <- runif(12)

#creating frame
df <- data.frame(var_a, var_b, var_c)
df
str(df)

#accessing within a df
df$var_a
df[1,1] #treating it like a matrix but isnt very informative

#expanding the data frame 
new_data <- list(var_a = 13, var_b = "D", var_c = 0.77)
#use rbind to append
df2 <- rbind(df, new_data)
df2

View(df2) #lookinf at data frame in the viewer

#adding a new column to a df
df2

#using cbind
new_var <- rnorm(13)
df3 <- cbind(df2,new_var)

#using assignment operator 
char_var <- rep("T", 13)
df3$charV <- char_var

#writing data frames
write.csv(df3, "data/my_dataframe.csv")

## class 2/3/26
#distinctions between DFs and Mat Dims 

z_mat <- matrix(data = 1:30, ncol = 3, byrow = T)
z_dframe <- as.data.frame(z_mat) #coerces matrix into data frame

head(z_mat)

z_dframe$V2 #correct for DF [1]  2  5  8 11 14 17 20 23 26 29

#column ref
z_dframe[,3]
z_mat[,3]

#one demension reference 
z_mat[2] #4
z_dframe[2] #shows the second vector

#missing data in dfs and mats 
zd <- runif(10)
zd
#add missing by values 
zd[c(5,7)] <- NA #indexes og vector at 5th and 7th places and puts NA in those spots
zd

#complete cases
complete.cases(zd)
#filter for only true
zd[complete.cases(zd)]

#which positions are missing
which(complete.cases(zd)) #[1]  1  2  3  4  6  8  9 10

which(!complete.cases(zd)) #[1] 5 7

#missing data in a matrix 
m <- matrix(1:20, nrow = 5)
#add missing data 
m[1,1] <- NA
m[5,4] <- NA
#can do this in one line like this:
m[c(1,5),c(1,4)] <- NA

m[complete.cases(m),] 

#get complete cases for only certain columns 
m[complete.cases(m[c(1,2)]),] #drops first row 
m[complete.cases(m[,c(2,3)]),]#no drops
m[complete.cases(m[,c(3,4)]),] #drops row 4 (has NAs)
m[complete.cases(m[,c(1,4)]),] #drops 1&4

#subsetting mats and dfs 
m <- matrix(data=1:12,nrow=3)
dimnames(m) <- list(paste("species", LETTERS[1:nrow(m)],sep=""), paste("site",1:ncol(m), sep=""))

print(m) #site1 site2 site3 site4
          #speciesA     1     4     7    10
          #speciesB     2     5     8    11
          #speciesC     3     6     9    12

#element-wise subsetting
m[1:2, 3:4] #first and second rows in third and fourth columns 
m[c("speciesA", "speciesB"), c("site3", "site4")] #does the same thing just more readable

m[1:2,] #columns 
m[,3:4] #rows

# using logical for subsetting
colSums(m) #sums of each column for that matrix
colSums(m) > 15
colSums(m) >= 15
sums <- colSums(m) #create sums object
sums[sums > 15]

m[rowSums(m)==22, ]

#we can use character string names 
m[,"site1"] #gives us all species in row for site 1
m[,"site1"]<3 #gives us the ones that are less than 3

#data curation
#first level is having a place where everything is 
#second level is metadata 
my_data <- read.table(file="data/testdata.csv",
            header = TRUE,
            sep = ",",
            comment.char="#")
head(my_data)

#other than csv, we can write out an r object as a rds file 
#great for huge models that can take a long time, allows it to keep running 
z_dframe #this is an r object, saving an object as an rds lets us save the whole model so you dont have to run it again 

saveRDS(z_dframe, file = "data/zData.RDS") #.RDS suffix is not needed but its good to put for readablility
#important to save rds as you go incase anything gets lost

z_dframe

#have to open r 
unfrozen_Z <- readRDS("data/zData.RDS")
unfrozen_Z
