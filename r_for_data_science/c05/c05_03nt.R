# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Note 03
# #Covariation #geom_boxplot() #reorder()

library(tidyverse)
library(nycflights13)
library(magick)
data(diamonds)
data(flights)

# Covariation
# If variation describes the behavior within a variable, covariation describes the behavior between variables.
# Covariation is the tendency for the values of two or more variables to vary together in a related way.
# The best way to spot covariation is to visualize the relationship between two or more variables.

# A Categorical and Continuous Variable

# Exploring distribution of a continuous variable broken down by a categorical variable:
# The default appearance of geom_freqpoly() is not that useful for that sort of comparison.
# That means if one of the groups is much smaller than the others, it’s hard to see the differences in shape.
ggplot(data = diamonds, mapping = aes(x = price)) + geom_freqpoly(mapping = aes(color = cut), binwidth = 500)

# Instead of displaying count, we’ll display density, which is the count standardized so that the area under each frequency polygon is one:
ggplot( data = diamonds, mapping = aes(x = price, y = ..density..) ) + geom_freqpoly(mapping = aes(color = cut), binwidth = 500) # Check ..density..

# Another alternative to display the distribution of a continuous variable broken down by a categorical variable is the boxplot.

# Each boxplot consists of: 
#    A box that stretches from the 25th percentile of the distribution to the 75th percentile, 
#    a distance known as the interquartile range (IQR). 
#    In the middle of the box is a line that displays the median, i.e., 50th percentile, of the distribution. 
#    These three lines give you a sense of the spread of the distribution 
#    and whether or not the distribution is symmetric about the median or skewed to one side.
#    Visual points that display observations that fall more than 1.5 times the IQR from either edge of the box. 
#    These outlying points are unusual, so they are plotted individually. 
#    A line (or whisker) that extends from each end of the box and goes to the farthest nonoutlier point in the distribution.
library(magick)
c05_ex03_pic01 <- image_read("screenshots/c05_03ex_pic01.png")

# Let’s take a look at the distribution of price by cut using geom_box plot(): 
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) + geom_boxplot()

# If you want to reorder the distribution to show patterns better: use reorder()
# Example for using reorder() :
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + geom_boxplot()
# Chaotic - reorder based on median:
ggplot(data = mpg) + geom_boxplot( mapping = aes( x = reorder(class, hwy, FUN = median), y = hwy ) )
# With long variable names to compare - it looks even better flipped
ggplot(data = mpg) + geom_boxplot( mapping = aes( x = reorder(class, hwy, FUN = median), y = hwy ) ) + coord_flip()

# How to get information about a package
sessionInfo() # → zeigt dir, welche Packages gerade geladen sind, inkl. Version.
packageDescription("ggstance") # → Infos wie Titel, Version, Author, Maintainer.
help(package = "ggstance") # → Übersicht über alle Funktionen des Pakets.
library(help = ggstance) # → Übersicht über alle Funktionen des Pakets.
?ggplot() # → Doku zu einer Funktion, z. B. ?mutate.