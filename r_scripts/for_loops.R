#For Loops
###########
#Sof Antelo 
#Comp Bio 6100
#2/12/26


#for (var in seq) { # start of for loop

# body of for loop 
# } # end of for loop

#var is a counter variable that will hold the current value of the loop
#seq is an integer vector (or a vector of character strings) that defines the starting and ending values of the loop

for (i in 1:5) {
  cat("stuck in a loop","\n")
  cat(3 + 2,"\n")
  cat(runif(1),"\n")
}

print(i)

# use a counter variable that maps to the position of each element
my_dogs <- c("chow","akita","malamute","husky","samoyed")
for (i in 1:length(my_dogs)){
  cat("i =",i,"my_dogs[i] =" ,my_dogs[i],"\n")
}

#potential hazard is if the vector we are working with is empty
#So, a safer way is to use seq_along function:
my_bad_dogs <- NULL
for (i in 1:length(my_bad_dogs)){
  cat("i =",i,"my_bad_dogs[i] =" ,my_bad_dogs[i],"\n")
}

for (i in seq_along(my_dogs)){
  cat("i =",i,"my_dogs[i] =" ,my_dogs[i],"\n")
}

#what happens when the vector is empty:
# This time we correctly skip my_bad_dogs and do not make the loop
for (i in seq_along(my_bad_dogs)){
  cat("i =",i,"my_bad_dogs[i] =" ,my_bad_dogs[i],"\n")
}

#constant that we use to define the length of the vector:
zz <- 5
for (i in seq_len(zz)){
  cat("i =",i,"my_dogs[i] =" ,my_dogs[i],"\n")
}


#Tip 1: dont do things in loops that you dont need to 
for (i in 1:length(my_dogs)){
  my_dogs[i] <- toupper(my_dogs[i])
  cat("i =",i,"my_dogs[i] =" ,my_dogs[i],"\n")
}
my_dogs <- tolower(my_dogs)

#Tip 2: Dont change object dimensions in the loop
my_dat <- runif(1)
for (i in 2:10) {
  temp <- runif(1) #temporary, random number
  my_dat <- c(my_dat,temp) # do not change vector size in the loop!
  #cat("loop number =",i,"vector element =", my_dat[i],"\n")
}
print(my_dat)

#Tip 3:  Don't write a loop if you can vectorize an operation
#Even efficients loop will always take longer than vector
my_dat <- 1:10
for (i in seq_along(my_dat)) {
  my_dat[i] <-  my_dat[i] + my_dat[i]^2
  cat("loop number =",i,"vector element =", my_dat[i],"\n")
}
#No loop is needed here
z <- 1:10
z <- z + z^2
print(z)
###
  ##because R is based in math: 
  ###a plain equation will not require a loop, 
  ###will be fast
###

#Tip 4: Always remember the difference between i and z[i]
z <- c(10,2,4)
for (i in seq_along(z)) {
  cat("i =",i,"z[i] = ",z[i],"\n")
}
print(i)

#Tip 5: Use next to skip elements in loop
z <- 1:20
#what if we want to work with only the odd-numbers?
for(i in seq_along((z))){
  if(i %% 2==0) next
  print(i)
}

#next is a control structure that skips, in response to if
# Another method, probably faster (why?)
z <- 1:20
zsub <- z[z %% 2!=0] # contrast with logical expression in previous if statement!
length(z)
for (i in seq_along(zsub)) {
  cat("i = ",i,"zsub[i] = ",zsub[i],"\n")
}

################

# LOGISTIC GROWTH FUNCTION
######################################################
# Function Name: logistic_growth
#
# Purpose:
#   Simulates continuous-time logistic population growth using the
#   closed-form solution to the logistic differential equation.
#   Returns a tidy dataframe suitable for plotting or further analysis.
#
# Inputs:
#   N0 (numeric)  : Initial population size at time t = 0
#   r  (numeric)  : Intrinsic growth rate
#   K  (numeric)  : Carrying capacity
#   t_max (numeric) : Maximum simulation time
#   dt (numeric)  : Time step used to generate the time vector
#
# Output:
#   data.frame containing:
#     time (numeric)        : Time values from 0 to t_max
#     population (numeric)  : Population size N(t) at each time
#     N0 (numeric)          : Initial population parameter used
#     r (numeric)           : Growth rate parameter used
#     K (numeric)           : Carrying capacity parameter used
######################################################
logistic_growth <- function(
  N0 = 10,
  r  = 0.3,
  K  = 100,
  t_max = 50,
  dt = 0.1
){
  
  # time vector
  time <- seq(0, t_max, by = dt)
  
  # logistic equation (closed-form solution)
  N <- K / (1 + ((K - N0) / N0) * exp(-r * time))
  
  # return tidy dataframe
  data.frame(
    time = time,
    population = N,
    N0 = N0,
    r = r,
    K = K
  )
}
######################################################
# END FUNCTION

# look at parameter space of the logistic growth model with loop

r_vec <- seq(0,1,by = .05) #vector of little r's
container_vec <- rep(NA, length(r_vec))

print(r_vec[i])
for(i in seq_along(r_vec)){
  temp_df <- logistic_growth(r = r_vec[i])
  max_n <- max(temp_df$population)
  container_vec[i] <- max_n
  print(max_n)
}

container_vec
growthDF <- data.frame(r = r_vec, N = container_vec)

head(growthDF)

plot(growthDF$r, y = growthDF$N) #kind of like a summary of the model rather than just one run
##############