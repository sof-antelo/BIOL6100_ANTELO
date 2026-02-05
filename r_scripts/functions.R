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
