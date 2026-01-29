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
