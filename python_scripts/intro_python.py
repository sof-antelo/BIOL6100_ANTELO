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

if a >= 5:
    print("a is greater than or equal to 5")

#better to take multiple situations into account (if else)
if a >= 5:
    print("a is greater than por equal to 5")
else:
    print("a is less than 5")

# more complicated situation:
a = 3
b = 3
operation = "mult"

if operation == "mult":
    y = a * b
elif operation == "div":
    y = a/b
elif operation == "add":
    y = a + b
elif operation == "sub":
    y = a - b
else:
    y = ("I don't know that operation!")

y


########################
# Loops
########################
for i in range(2):
    print(i)

l = [10, 20]
for i in range(2):
    print(l[i])

# loop on an obj. directly 
x = ["blue", "green", "red"]

for i in x:
    print(i)

# more complicated loop
rnd = random.uniform(low = 1, high = 5, size = 10)

outList = [] #truly empty list
rnd
arr1
for i in range(len(arr1)):
    outList.append(rnd[i] + arr1[i])

outList

#nested loop with if else

rnd2D = random.uniform(low = 0, high = 1, size = (3,3))
rnd2D

matOut = np.empty(shape = (3,3)) #why does empty repopulate with old random values?
matOut #same shape as what we wanna fill, empty meant it should have place holders
shp = rnd2D.shape
shp #(3,3)

#nested loop
for i in range(shp[0]):
    for j in range(shp[1]):
        
        if rnd2D[i,j] >= 0.5:
            matOut[i,j] = rnd2D [i,j] * 1000
        else:
            matOut[i,j] = rnd2D [i,j] / 1000
matOut

###################
# Oandas DFs
###################

dates = pd.date_range("20130101", periods = 6)
df = pd.DataFrame(np.random.randn(6, 4), index = dates, columns = list("ABCD"))
df

#df methods
df.head(4)
df.tail(4)
df.index #row names
df.columns #column names
df.describe

df.to_numpy() #convert to numpy

#indexing pandas
df["A"]
df.loc[:, ["A", "B"]]
df["20130102": "20130104"]

#read in csv
ds = pd.read_csv("data/iris.data.csv")

ds["sepal_length"]
ds["sepal_area"] = ds.sepal_length * ds.sepal_width
ds.head()

# fully numeric filter
df[df > .5]

# ---- DF GROUPING AND SUMMARY ---- #

#grouping two variables
mean_table = ds. groupby("species")[["petal_length", "sepal_length"]].mean()

#long form ds
ds_long = pd.melt(ds, id_vars=['species'], value_vars=["sepal_width", "sepal_length", "petal_width", "petal_length"],
           var_name='vars', value_name='vals')
ds_long

# group by on long form
mult_indx = ds_long.groupby(["species", "vars"]).mean()
mult_indx

# pandas pivot tables - another way of grouping
pd.pivot_table(ds_long, values = "vals", index = ["vars"], columns = ["species"], aggfunc = np.mean)
pd.pivot_table(ds_long, values = "vals", index = ["vars"], columns=["species"], aggfunc=np.sum)
# stacking:
mean_table
# stacking:
mult_indx



#########################################################
#Functions
#########################################################
# ---------- Strcture of a user defined function ---------- #
#
# - function name
# - inputs / arguments
# - operations 
# - output
#########################################################
#START OF FUNCTION
def number_adder(a, b):
    #PURPOSE: add two nums and return the sum
    #params: a = numeric, b = numeric
    #output: numeric sum of a and b 
    out = a + b 
    return(out)
###########################################################
#END OF FUNCTION

#return number adde
number_adder(a = 3, b = 6)

#more complex one
#########################################################
#START OF FUNCTION
def number_adder_two(a = None, b = None):
    #PURPOSE: add two nums and return the sum
    #params: a = numeric, b = numeric
    #output: numeric sum of a and b 
    if a == None or b == None:
        out = "please provide inputs for a and b of type numeric"
    else:
        out = a + b     
    return(out)
###########################################################
#END OF FUNCTION
number_adder_two(a = 6, b = 4)
number_adder_two(a = None, b = 4)


#GRAPHICS - seaborn
#start by going to the terminal 
    #in base: use conda install seaborn

#import seaborn
import seaborn as sns

#styles: darkgrid, whitegrid, dark, white, ticks
sns.set_theme(style = "ticks", font_scale = 1.5) #good to keep figures consistent

#scatter plot

#species as column
sns.relplot(
      data=ds,
      x="sepal_width", y="petal_length",
      col="species")
# Species as style and color
sns.relplot(
      data=ds,
      x="sepal_width", y="petal_length",
      style="species", hue="species")

# Species as color - adding some features
f = sns.relplot(
      data=ds,
      x="sepal_width", y="petal_length",
      hue="species", palette="bright")
      
f.set_axis_labels("Sepal Width", "Petal Length", labelpad=10)
f.legend.set_title("Species")
f.ax.margins(.15)

sns.set_theme(style = "white", font_scale = 1.5) #remove ticks

#move the legend, so it doesnt take up too much white space 
sns.move_legend(
    f , "upper cener",
)

#adding a lineary model
f = sns.lmplot(
    data = ds,
    x = "sepal_length", y = "petal_length",
    hue = "species", palette = "bright"
)

#four panel histogram
#col_wrap = 2, makes 2 by 2 grid
f = sns.displot(
    data = ds_long,
    x = "vals", hue = "species",
    col = "vars", col_wrap = 2, height = 3, 
    kde = True,
)

#Bar plot
sns.catplot(data = ds_long, kind = "bar", x = "species", y = "vals", hue = "vars")
