# A demo of user defined functions in r

# Sof Antelo's BIOL 6100 notes
# 2/5/26

########################################

# looking at existing functions 

sum(3,2) #5
3+2  #5
`+`(3,2) #5 <- arithmatic operator

y <- 3
`<-`(yy, 5) #even the <- is a function 

print(read.table) #shows source code in console

# creating a function

#start function called adder_subtracter
#############################################################
adder_subtracter <- function(x = 1, y = 2, z = TRUE){
# Name: adder_subtracter
# Operation: does some random math depending on value of x
# Inputs: (3 inputs):
    # x (numeric scaler value, default = 1): one of the numbers to be operated on
    # y (numeric scaler value, default = 2): one of the numbers to be operated on
    #z (logical, default = TRUE): a switch to decide on subtracting or adding
# Outputs: numeric value resulting from addition or subtraction
  #adding the boolean (if else) gives a toggle switch between + and - 
  if(z == TRUE){
    out <- x + y
  }else{
    out <- x - y
  }

  return(out)
  
}
#############################################################
# end of function

v <- adder_subtracter()
v # [1] 3; not putting parameters uses defaults 

v <- adder_subtracter(x = 7, y = 4, z = TRUE) #if true add, it added ; 11
v

v <- adder_subtracter(x = 7, y = 4, z = FALSE) #false, subtracted; 3
v

v <- adder_subtracter(x = 7, y = 4, operation = "division") #would require more if else's to set up operation options

#biological 'math' in a function 
  #hardy weinburg, p and q are our variables 
  #we will build a function to use the equilibrium equation to find gene frequencies 


#Hardy Weinburg function 
################################################
#START FUNCTION
hardy_weinburg <- function(p = runif(1)){
################################################
    # FUNCTION: hardy_weinburg
    # OPERATION: does a hardy weinburg equalibrium problem
    # INPUT = p: allele frequency of dominant 
    # OUTPUT = q: thre frequencies of the three genotypes (fAA, fAB, fBB)
  q <- 1- p  #defined q
         #print(sum(c(q,p))) # side effect, good for diagnostics
            #print(sum(c(q,p))) should be 1
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2

  #store data for output
  out_vec <- signif(c(q = q, p = p, AA = fAA, BB = fBB, AB = fAB), digits = 3)

  return(out_vec) #return the values
  
}
###############################################
#END

hardy_weinburg(p = 0.3)

################################################
#functions 2 2/9/26

sum(3,2) # a "prefix" function
3 + 2 # an "operator", but it is actually a function
`+`(3,2) # the operator is an "infix" function

y <- 3
print(y)

`<-`(yy,3) # another "infix" function
print(yy)

# to see contents of a function, print it
print(read.table)

sd # shows the code
sd(c(3,2)) # call the function with parameters
# sd() # call function with default values for parameters


#anatomy of a function
functionName <- function(parX=defaultX,parY=defaultY,parZ=defaultZ) { 

# curly bracket open marks the start of the function body

# Body of the function goes here
# Lines of R code and annotations
# May also call functions
# May also create functions
# May also create local variables

return(z)  # returns from the function a single element (z could be a list)

# curly bracket close marks the end of the function body
} 

# prints the function body
functionName 

# calls the function with default values and returns object z
functionName() 

# calls the function with user-specified values for each paramater
functionName(parX=myMatrix,parY="Order",parZ=c(0.3,1.6,2,6))


#Use multiple return()
##################################################
# FUNCTION: hardy_weinberg2
# input: an allele frequency p (0,1)
# output: p and the frequencies of the 3 genotypes AA, AB, BB
#------------------------------------------------- 
hardy_weinberg2<- function(p=runif(1)) {
  if (p > 1.0 | p < 0.0) {
    return("Function failure: p must be >= 0.0 and <= 1.0")
  }
  q <- 1 - p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
 vec_out <- signif(c(p=p,AA=fAA,AB=fAB,BB=fBB),digits=3)
 return(vec_out)
  }
##################################################
  hardy_weinberg2()
  hardy_weinberg2(1.1) # OK, print error to screen
  z <- hardy_weinberg2(1.1) # uggh no error printed
  print(z) # Error message was saved to variable z!

#Use stop 
##################################################  
# FUNCTION: hardy_weinberg3
# input: an allele frequency p (0,1)
# output: p and the frequencies of the 3 genotypes AA, AB, BB
#-------------------------------------------------
hardy_weinberg3<- function(p=runif(1)) {
  if (p > 1.0 | p < 0.0) {
    stop("Function failure: p must be >= 0.0 and <= 1.0")
  }
  q <- 1 - p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
 vec_out <- signif(c(p=p,AA=fAA,AB=fAB,BB=fBB),digits=3)
 return(vec_out)
  }
##################################################  
  hardy_weinberg3()
#  z <- hardy_weinberg3(1.1) 

#Scoping 
my_func <- function(a=3,b=4) {
  z <- a + b
  return(z)
}
my_func()

my_funcBad <-function(a=3) {
  z <- a + b
  return(z)
}
my_func_bad() # crashes because it can't find b
b <- 100
my_func_bad() # OK now because b exists as a global variable

# But it is fine to create variables locally
my_func_ok <- function(a=3) {
  bb <- 100
  z <- a + bb
  return(z)
}

my_func_ok() # no problems now
print(bb) # but this variable is still hidden from the global environment

#regression function
##################################################
# FUNCTION: fit_linear 
# fits simple regression line
# inputs: numeric vector of predictor (x) and response (y)
# outputs: slope and p-value
#------------------------------------------------- 
fit_linear <- function(x=runif(20),y=runif(20)) {
  my_mod <- lm(y~x) # fit the model
  my_out <- c(slope=summary(my_mod)$coefficients[2,1],
             p_value=summary(my_mod)$coefficients[2,4])
  plot(x=x,y=y) # quick and dirty plot to check output
  return(my_out)
}
##################################################
fit_linear()

#complex default value 
##################################################
# FUNCTION: fit_linear2       
# fits simple regression line
# inputs: numeric vector of predictor (x) and response (y)
# outputs: slope and p-value
#------------------------------------------------- 
fit_linear2 <- function(p=NULL) {
  if(is.null(p)) {
     p <- list(x=runif(20),y=runif(20))
  }
  my_mod <- lm(p$x~p$y) # fit the model
  my_out <- c(slope=summary(my_mod)$coefficients[2,1],
             p_value=summary(my_mod)$coefficients[2,4])
  plot(x=p$x,y=p$y) # quick and dirty plot to check output
  return(my_out)
}

##################################################
fit_linear2()
my_pars <-list(x=1:10,y=sort(runif(10)))
fit_linear2(my_pars)

#using do call
z <- c(runif(99),NA)
mean(z) # oops, mean doesn't work if there is an NA
mean(x=z,na.rm=TRUE) # change the default value for na.rm
mean(x=z,na.rm=TRUE,trim=0.05) # check out the "trim" option in help
l <- list(x=z,na.rm=TRUE,trim=0.05) # bundle paramaters as a list
do.call(mean,l) # use the do.call function with the function name and the parameter list
