# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 01 - Exercise 01
# #GGplots #ContinuousVariables #CategoricalVariables #Aesthetics

# I'll do the exercises with the following layout
# The questions will have one hastag "#"
# My answer will have three hashtags "###"
# First I will copy thq question, then my answer and then add the code

### Loading needed packages -----
library(tidyverse)

# 1. What’s gone wrong with this code? 
#    Why are the points not blue? 
#    ggplot(data = mpg) + 
#     geom_point(mapping = aes(x = displ, y = hwy, color = "blue")
### Loading data to be able to run the plot
### This function was missing one closing parenthesis.
### color="blue" must be written outside of aes()
### aes() gathers the aesthetics of the mapping
### outside aes() it focusses geom_point, so it affects the points
data(mpg) 
View(mpg)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# 2a) Which variables in mpg are categorical? 
#     Which variables are continuous? 
#     How can you see this information when you run mpg?
#     (Hint: type ?mpg to read the documentation for the dataset.) 
### Categorical Variables (manufacturer, model, year, cyl, trans, drv, fl, class)
###  - describe qualities
###  - belong to a finite set of categories
###  - often used to segment data
###  - e.g. gender, blood type, car color, etc.
### Continuous Variables (displ, cty, hwy)
###  - numeric with meaningful arithmetic
###  - can be fractiona/decimal
###  - usually come from measurements
###  - e.g. height, temperature, weight, time
### ?mpg introduces the unit of each variable, if existing
### If you see a unit, you can be quite sure that these are continuous variables
### Only years are not continuous variables in this context in my opinion 
### They are limited from ~98' to ~08' and used as categorical variables
?mpg

# 3. Map a continuous variable to color, size, and shape. 
#    How do these aesthetics behave differently for categorical versus contin‐ uous variables?
### It is quite interesting. Every numeric response is seen as a continuous variable by the system.
### Even though it's a very limited range of answers like for number of cylinders.
### The color and size arguments can work with categorical and continuous variables.
### Either they display the data grouped or they use gradients in sizing or coloring. 
### The shape= argument requires categoric data and gives errors, if the number of groups exceeds 6. 

### 3x Categorical Variables -----
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = cyl))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = year))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = manufacturer))
### 3x Continuous Variables ----
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = cty))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = hwy))

# 4. What happens if you map the same variable to multiple aesthetics?
### It works perfectly and can improve the communication of the message.
### But it generates 2 legends. I would combine them. 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ, size = displ))

# 5. What does the stroke aesthetic do? 
#    What shapes does it work with? 
#    (Hint: use ?geom_point.)
### The aesthetic stroke allows to set a fixed size for all points of the scatterplot
### It requires numeric arguments like 1, 2, 3, 4, 5
?geom_point
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), stroke = 1)

# 6. What happens if you map an aesthetic to something other than a variable name, like aes(color = displ < 5)?
### This is interesting! It recognised the conditions and adjusted the coloring to it.
### All points meeting the condition have an own color and TRUE written in the legend.
### All points not meeting the condition have an own color and FALSE written in the legend.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))
