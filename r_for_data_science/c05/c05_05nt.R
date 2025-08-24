# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Note 05
# #Covariations #2ContinuousVariables #geom_bin2D #geom_hex

library(tidyverse)
library(nycflights13)
library(magick)
data(diamonds)
data(flights)

# We've seen one great way already: Scatterplots
ggplot(data = diamonds) + geom_point(mapping = aes(x = carat, y = price))
# Become less useful as the dataset grows
# Adding transparency can help:
ggplot(data = diamonds) + geom_point( mapping = aes(x = carat, y = price), alpha = 1 / 100)
# Another is to use geom_bin2d() and geom_hex()

# geom_bin2d() and geom_hex() divide the coordinate plane into 2D bins 
# and then use a fill color to display how many points fall into each bin.
# geom_bin2d() creates rectangular bins. geom_hex() creates hexagonal bins.
library(hexbin)
ggplot(data = diamonds) + geom_bin2d(mapping = aes(x = carat, y = price)) 
ggplot(data = diamonds) + geom_hex(mapping = aes(x = carat, y = price))
# Another option is to bin one continuous variable so it acts like a cat‐ egorical variable. 
# Then you can use one of the techniques for visualizing the combination of a categorical & continuous.
ggplot(data = diamonds, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1))) # cut_width(x, width) divides x into bins of width
# Make the width of the boxplot proportional to the number of points with varwidth = TRUE :
ggplot(data = diamonds, mapping = aes(x = carat, y = price)) + geom_boxplot(mapping = aes(group = cut_number(carat, 20)))