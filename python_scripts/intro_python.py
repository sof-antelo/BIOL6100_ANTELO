# INTRO TO PYTHON
#################
# Sof Antelo
# Comp Bio 6100
# 3/12/2026





###############################################################################
# INTALLING REQUIRED LIBRARIES
###############################################################################
import numpy as np
import scipy as sp
import pandas as pd
import matplotlib.pyplot as plt
import statsmodels.api as sm
import statsmodels.formula.api as smf





###############################################################################
# OBJECTS, METHODS, and FUNCTIONS
###############################################################################

print("I love Python!") # the print function

greeting = "Hello!" # character string as an object

scaler = 6 # integer value

out = scaler * 3 # multiply by 3 to create a new object

myList = [34, 7, 98] # a list

myList.append(33) # a method of a list object

len(myList) # function performed on the object






###############################################################################
# DATA STRUCTURES AND INDEXING
###############################################################################


# ------ LISTS ------ #

# make a list of colors
a_list = ["blue", "green", "red"]

# indexing
first_element = a_list[0]

print(a_list)
print(first_element)

# how long is the list?
len(a_list)

# data types
nums = [1, 3, 5, 8]
chars = ["a", "b", "c"]
boolean = [True, True, False, True, False]

# a mixed list
mixed = [1, 3, True, "blue", 5]

type(mixed) # what type of object is this

# negative indexing
mixed[-1] # last
mixed[-3] # third from the right

# ranged indexing
mixed[1:4] # 1 through 4
mixed[:4] # the start through 4
mixed[2:] # 2 to the end

# is an item in my list?
1 in mixed

# change blue to green
mixed[3] = "green"

# the insert method
mixed.insert(0, "start")

# other methods....
# extend
# remove
# pop
# clear
# and others


# List Comprehension
print(mixed)

# make a list from all items in mixed
[x for x in mixed]

# print each item in list
[print(x) for x in mixed]

# make a new list of just string items
[x for x in mixed if isinstance(x,str)]

# the syntax
# [expression for item in iterable if condition == True]


# 2d array
rows, cols = (3, 3)

arr = [[2]*cols]*rows

arr[2][2] # indexing




# ------ DICTIONARIES ------ #

# making a dictionary - key:value
myDict = {
  "first": "John",
  "last": "Smith",
  "year": 2017,
  "status": "active"
}


# dictionary constructor
myDict = dict(first = "john", last = "Smith", year = 2017, status = "active")

myDict


# data types inside a dictionary
dataTypes = {
  "string": "thing",
  "intager": 3,
  "float": 3.1434256,
  "list": [1,2,3,"a"]
}

# exploring the dictionary

# what object type?
type(myDict)

# length?
len(myDict) 

# value by key
myDict["year"] 

# or....
myDict.get("year")

# get the keys
myDict.keys()

# get the values
myDict.values()

# get pairs = list of tuples
myDict.items()

# add a key pair
myDict["age"] = 36

# change a key pair
myDict["year"] = 2021

# other methods...
# pop
# copy
# delete
# update
# clear and others

# copy the dictionary
newDict = myDict.copy()
newDict






###############################################################################
# NUMPY
###############################################################################

# create a numpy array (1D)
arr1 = np.array([0,1,2,3,4,5,6,7,8,9])

# indexing on a 1D array
arr1[3] # fourth item
arr1[-1] # last item
arr1[:3] # behaves like standard lists
arr1[1:5] # slicing 
arr1[1:8:3] # slicing with step (every other place)

# create a numpy array (2D)
arr2 = np.array([[0,1,2], [3,4,5], [6,7,8]])

# indexing on a 2D array
arr2[2,2] # item in row 3 column 3
arr2[:,2] # third column
arr2[2,:] # third row
arr2[0:2,0:2] # a 2D subset with slicing


# create a numpy array (3D)
arr3 = np.array([[[1, 2], [3, 4]], [[5, 6], [7, 8]]])

# 3D indexing
arr3[1,0,1] # layer, row, column

# dimensions of arrays
arr1.ndim # 1 dimension
arr2.ndim # 2 dimensions
arr3.ndim # 3 dimensions

# shapes...
arr1.shape
arr2.shape
arr3.shape

# data types...
arr2.dtype # what is our data type?
arr2.astype(str) # convert to another type

# reshaping
arr1.shape # a 1D array
arr1.reshape(2,5) # make it a 2D array

arr3.shape # a 3d array
arr3.reshape(4,2) # make it a 2D array




# joining arrays ------------
first = np.array([1,2,3])
second = np.array([4,5,6,7,8,9])

longArray = np.concatenate((first, second)) # concatenate arrays

# 2D arrays - lets examine the axis argument
np.concatenate((arr2, arr2), axis=0)

# stacking arrays - creates a new axis - try: dstack, vstack
np.stack((arr2, arr2))




# splitting arrays ------------
np.array_split(arr1, 2) # 1D array

np.array_split(arr3, 2, axis=0) # 2D array on axis

# hsplit
np.hsplit(arr3, 2) # split into two arrays




# filtering and searching ------------

# create boolean list
tf = [True, True, False, False, True, True, False, True, False, False]

# pulls out values that coincide with True places
arr1[tf]

# make boolean array
tf2 = arr1 == 5 
arr1[tf2]

# search for values returns place
np.where(arr1 == 6)
np.where(arr1 == 12)



# random numbers -----------
from numpy import random

random.seed(seed = 100) # set seed

random.randint(50) # from 0 to 50

random.rand(50) # 50 from 0 to 1

random.rand(50, 5, 10) # 50  in 2D array

random.choice(arr1) # random number from arr1

random.choice(arr1, size = (3,3)) # random number from arr1 in new array

y = random.choice([0, 1], p=[.3, .7], size=(100)) # random choice with weights

x = random.normal(loc=5, scale=3, size=(100)) # normal dist

#### 3/24/26

# look at the distribution
plt.hist(x) 
plt.show()

# a binomial distribution
random.binomial(n=10, p=0.5, size=20)

# uniform dist
random.uniform(low=1, high=10, size = (50))



# math ------------

# math between arrays
y - x # subtraction
y + x # addition
y / x # division
y * x # multiplication

x * 100 # multiply by a scalar

arr2 * arr2 # multiply two arrays

# functions
np.mean(arr2)
np.max(arr2)





###############################################################################
# LOGIC STRUCTURES
###############################################################################

# if statements
a = 3

# if statements
if a >= 5:
  print("a is greater than or equal to 2")


# else statement
if a >= 5:
  print("a is greater than or equal to 2")
else:
  print("a is less than 2")
  


# building a more complicated statement

a = 3
b = 3
operation = "exp"

if operation == "mult":
  y = a * b
elif operation == "div":
  y = a/b
elif operation == "add":
  y = a + b
elif operation == "sub":
  y = a - b
else:
  y = "I don't know what that means. I only know four operations!"
  
  
  
y
  
  
  
###############################################################################
# LOOPS
###############################################################################

# the structure of a for loop:

# for index in someRange:   <-  sets up the index and how many times the loop will go for
#  out[i] = do a thing.     <-  does the thing for that many times and store it in an obj using the index


l = [10,20]

# a simple loop where we print an output
for i in range(2):
  print(l[i])


# iterating on the loop directly
x = ["blue", "red", "green"]

for i in x:
  print(i)
  


# using the index to iterate
rnd = random.uniform(low=1, high=5, size = (10))

outList = [] # ermpty list

for i in range(len(arr1)):
  outList.append(rnd[i] + 100)

outList




# nested loop with if statment 
rnd2D = random.uniform(low=0, high=1, size = (3,3)) # a random 2d array
matOut = np.empty(shape = (3, 3)) # empty matrix for storage
shp = rnd2D.shape # get shape


for i in range(shp[0]):
  for j in range(shp[1]):
    
    if rnd2D[i,j] >= 0.5:
        matOut[i,j] = rnd2D[i,j] * 1000
    else:
       matOut[i,j] = rnd2D[i,j] / 1000



#---------++++++++++----------#
#--------Let's Explore--------#
#---------++++++++++----------#

# let's take apply this information to look at while loops and break




###############################################################################
# PANDAS
###############################################################################

# ------ CREATING A DATA FRAME ------ #

# make a date vec
dates = pd.date_range("20130101", periods=6)

# create a data frame with 4 numeric columns of length 6 named A, B, C, and, D
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))
df



# ------ DF INFO ------ #

df.head(4) # top 4 rows
df.tail(4) # bottom 4 rows

df.index # look at index variables
df.columns # look at the columns
df.describe() # summary stats for each row

# convert to numpy array
df.to_numpy()




# ------ DF INDEXING ------ #

# selecting rows and columns - BY LABELS
df["A"] # column
df.loc[:, ["A", "B"]] # columns
df["20130102":"20130104"] # rows

# slicing on both axises using the date labels
df.loc["20130102":"20130104", ["A", "B"]]

# selecting rows and columns - BY LOCATION
df.iloc[3,2] # value at index 3,2
df.iloc[[1, 2, 4], [0, 2]] # rows 1,2,4 and cols 0 and 2
df.iloc[1:3, :] # First two rows all cols




# ------ DF MANIPULATION ------ #

# read in data sets
ds = pd.read_csv("iris.data.csv")
ds["sepal_length"] # pull sepal width out of data set

ds.head() # examine the data set

# adding a new columns
ds["sepal_area"] = ds.sepal_length * ds.sepal_width
ds["petal_area"] = ds["petal_length"] * ds["petal_width"]

# boolean operations
ds[ds["sepal_length"] > 7] #  all rows where sepal length is greater than 7

# fully numeric data frame
df[df > .5] # values in the data frame greater than 2 - everythin else is nan






# ------ DF GROUPING AND SUMMARY ------ #           

# mean of petal length and petal width for each species
mean_table = ds.groupby("species")[["petal_length", "petal_width"]].mean()

# let's make a long form data set and use hhierarchical indexing

# make wide format to long
ds_long = pd.melt(ds, id_vars=['species'], value_vars=["sepal_width", "sepal_length", "petal_width", "petal_length"],
           var_name='vars', value_name='vals')


# table with two indexes; species and variable
mult_indx = ds_long.groupby(["species", "vars"]).mean()


# pivot tables - another way of grouping
pd.pivot_table(ds_long, values="vals", index=["vars"], columns=["species"], aggfunc=np.mean)
pd.pivot_table(ds_long, values="vals", index=["vars"], columns=["species"], aggfunc=np.sum)


# stacking:
mean_table # original table
mean_table.stack() # stacked table

# stacking:
mult_indx # original table
mult_indx.unstack() # unstacked table






###############################################################################
# FUNCTIONS
###############################################################################

# ------ The structure of a user-defined function ------ #
#
# - function name
# - inputs / arguments
# - operations 
# - output
#


# defining a basic function
def number_adder(a, b): # name and inputs
    out = a + b # operation
    return(out) # outputs

added = number_adder(a = -3, b = 3)

# calling the function without inputs
number_adder(a = 1, b = 1)




# ------ Defaults and added complexity ------ #

# adding defaults and an if else statement 
def number_adder(a = None, b = None): # add defaults to the arguments
  
  if a == None or b == None: # does a or b have an input?
    out = "Please provide numeric inputs for a and b!" # no it doesn't
  else:
    out = a + b # yes it does
  return(out) 


number_adder() # calling the function without inputs
number_adder(a = 2, b = 3) # providing inputs


# it just adds things? How about adding other operators

def math_doer(a = None, b = None, operation = "add"): # add another argument
  
  if a == None or b == None: # does a or b have an input?
    out = "Please provide numeric inputs for a and b!" # no it doesn't
  else:
    
    if operation == "add":
      out = a + b 
    if operation == "sub":
      out = a - b 
    if operation == "mult":
      out = a * b 
    if operation == "div":
      out = a / b 

  return(out) 

# lets explore the results
math_doer(a = 1, b = 4, operation = "mult")



# ------ The return statement ------ #

# multiple outputs
def random_array(length1 = 1, length2 = 1):
  
  out1 = np.random.random(length1)
  out2 = np.random.random(length2)
  
  return(out1, out2)



# single or multiple objects on the function call
x, y = random_array(length1 = 2, length2 = 4)



#---------++++++++++----------#
#--------Let's Explore--------#
#---------++++++++++----------#

# let's build a function that takes an array and returns a either the min or the max






###############################################################################
# DATA ANALYSIS - statsmodels 
###############################################################################
# https://www.statsmodels.org/devel/stats.html#module-statsmodels.sandbox.stats.runs


# read in data sets
#ds = pd.read_csv("/Users/pburnham/Desktop/iris.data.csv")


# ------ linear regression ------ #

# here is our model
results = smf.ols('sepal_length ~ petal_width + petal_length + sepal_width', data=ds).fit()

results.summary() # check the results


# plot a 4 panel scatter plot for the four variables
fig, axs = plt.subplots(2, 2)
axs[0, 0].plot(ds["sepal_length"], ds["petal_length"], 'o')
axs[0, 0].set(ylabel='petal length')
axs[0, 1].plot(ds["sepal_width"], ds["petal_length"], 'o', color = "orange")
axs[1, 0].plot(ds["sepal_width"], ds["petal_width"], 'o', color = "green")
axs[1, 0].set(xlabel='sepal width', ylabel='petal width')
axs[1, 1].plot(ds["sepal_length"], ds["petal_width"], 'o', color = "red")
axs[1, 1].set(xlabel='sepal length')

plt.show()




# ------ ANOVA ------ #

# our ANOVA model
anova_mod = smf.ols('petal_width ~ species', data=ds).fit()

anova_mod.summary() # check results

sm.stats.anova_lm(anova_mod, typ=2) # get ANOVA table



# plotting a boxplot using matplot lib

# create arrays by sepcies
setosa = ds[ds['species'] == "setosa"]["petal_width"] 
versicolor = ds[ds['species'] == "versicolor"]["petal_width"] 
virginica = ds[ds['species'] == "virginica"]["petal_width"] 

# list of arrays
data_plotting = [setosa, versicolor, virginica]

# creating plot
plt.clf()
plt.boxplot(data_plotting, labels = ["setosa", "versicolor", "virginica"])
plt.xlabel('Petal Width', fontsize=17)
plt.ylabel('Iris Species', fontsize=17)
plt.show()




# ------ POST HOC ------ #

# lets use statsmodels to run a post hoc test
from statsmodels.stats.multicomp import pairwise_tukeyhsd

# run the tukeyHSD
tukey_results = pairwise_tukeyhsd(endog=ds['petal_width'],
                          groups=ds['species'],
                          alpha=0.05)
print(tukey_results)




###############################################################################
# SCIPY - SIR models - using odeint
###############################################################################
from scipy.integrate import odeint


# input params annd run model
def run_SIR(N = 1000, I0 = 1, R0 = 0, beta = .2, gamma = .1, time = 150):

  # initial suceptible
  S0 = N - I0 - R0

  # time vec
  t = np.linspace(0, time, time)

  # The SIR model
  def deriv(y, t, N, beta, gamma):
      S, I, R = y
      dSdt = -beta * S * I / N
      dIdt = beta * S * I / N - gamma * I
      dRdt = gamma * I
      return dSdt, dIdt, dRdt

  # Initial conditions vector
  y0 = S0, I0, R0

  # Integrate the SIR equations over the time grid, t.
  ret = odeint(deriv, y0, t, args=(N, beta, gamma))
  S, I, R = ret.T
  
  return S, I, R, t, N


# plot results
def SIR_plotter(susceptible, infected, recovered, number, time):

  # Plot the data on three separate curves for S(t), I(t) and R(t)
  fig = plt.figure(facecolor='w')
  ax = fig.add_subplot(111, facecolor='w', axisbelow=True)
  ax.plot(time, susceptible/number, 'b', alpha=0.5, lw=4, label='Susceptible')
  ax.plot(time, infected/number, 'r', alpha=0.5, lw=4, label='Infected')
  ax.plot(time, recovered/number, 'g', alpha=0.5, lw=4, label='Recovered')
  ax.set_xlabel('Time /days')
  ax.set_ylabel('Proportion')
  legend = ax.legend()

  plt.show()



# run these functions
S, I, R, t, N = run_SIR(I0 = 1, R0 = 0, beta = .6, gamma = .3, time = 150, N = 1000) # run models
SIR_plotter(susceptible = S, infected = I, recovered = R, time = t, number = N) # plot results


# let's explore the parameter space of beta and gamma
# how granular is the param sweep?
fidelity = 100 

beta = np.linspace(0, 1, num=fidelity) # 100 beta values
gamma = np.linspace(1, 0, num=fidelity) # 100 gamma values



# initialize a storage array
storage = np.empty((fidelity, fidelity))

# let's loop through for each pair-wise combo
for b in range(len(beta)):
  for g in range(len(gamma)):
    
    S, I, R, t, N = run_SIR(I0 = 1, R0 = 0, beta = beta[b], gamma = gamma[g], time = 150, N = 1000) # run models
    I_max = np.nanmax(I)
    storage[g, b] = I_max/N


# plot the values for beta and gamma
plt.clf()
plt.imshow(storage, extent=[0, 1, 0, 1])
plt.xlabel('beta', fontsize=20)
plt.ylabel('gamma', fontsize=20)
plt.colorbar(fraction=0.046, pad=0.04)
plt.title("Proportion of infected by beta and gamma", fontsize=15)
plt.show()





###############################################################################
# GRAPHICS - seabourne 
###############################################################################

# tutorial 
# https://seaborn.pydata.org/tutorial/introduction.html#a-high-level-api-for-statistical-graphics

# palettes
# https://seaborn.pydata.org/tutorial/color_palettes.html

# library
import seaborn as sns

# set theme
sns.set_theme(style = "ticks", font_scale = 1.5) # styles: "darkgrid" "whitegrid" "dark" "white" "ticks"




# ------ SCATTER PLOTS ------ #


# Species as column
sns.relplot(
      data=ds,
      x="sepal_width", y="petal_length",
      col="species")
plt.show()



# Species as style and color
sns.relplot(
      data=ds,
      x="sepal_width", y="petal_length",
      style="species", hue="species")
plt.show()



# Species as color - adding some features
f = sns.relplot(
      data=ds,
      x="sepal_width", y="petal_length",
      hue="species", palette="bright")
      
f.set_axis_labels("Sepal Width", "Petal Length", labelpad=10)
f.legend.set_title("Species")
f.ax.margins(.15)
plt.show()




# lets move the legend
sns.set_theme(style = "white", font_scale = 1.5)

# Species as color - adding some features
f = sns.relplot(
      data=ds,
      x="sepal_width", y="petal_length",
      hue="species", palette="bright")
      
f.set_axis_labels("Sepal Width", "Petal Length", labelpad=10)

# 'upper right', 'upper left', 'lower left', 'lower right', 'right', 'center left', 'center right', 'lower center', 'upper center', 'center'
sns.move_legend(
    f, "upper center",
    bbox_to_anchor=(.5, 1), ncol=3, title=None, frameon=False,
)

plt.show()



# ------ LINEAR FITS ------ #


f = sns.lmplot(
      data=ds,
      x="sepal_width", y="petal_length",
      hue="species", palette="bright")
      
f.set_axis_labels("Sepal Width", "Petal Length", labelpad=10)

plt.show()






# ------ A 4 PANEL HISTOGRAM ------ #

f = sns.displot(
    ds_long,
    x="vals", hue="species",
    col="vars", col_wrap=2, height=3,
    kde=True,
)
plt.show()




# ------ A BAR PLOT ------ #

sns.catplot(data=ds_long, kind="bar", x="species", y="vals", hue="vars")
plt.show()