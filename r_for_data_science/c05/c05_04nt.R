# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Note 04
# #Covariations #CategoricalVariables #geom_count #geom_tile

library(tidyverse)
library(nycflights13)
library(magick)
data(diamonds)
data(flights)

# Two Categorical Variables
# To search for covariations with 2 categorical variables
# We need to count the number of observations for each combination
# geom_count() is our way to go
ggplot(data = diamonds) + geom_count(mapping = aes(x = cut, y = color))
# The size of a circle gives us information about the number of observations
# Another approach is to compute the count with dplyr:
diamonds %>% count(color, cut)
# And then use geom_tile() to visualise:
diamonds %>% count(color, cut) %>% ggplot(mapping = aes(x = color, y = cut)) + geom_tile(mapping = aes(fill = n))
# If the categorical variables are unordered, 
# you might want to use the seriation package to simultaneously reorder the rows and columns.
# For larger plots, you might want to try the d3heatmap or heatmaply packages, which create interactive plots.