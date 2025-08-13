# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Exercise 02
# #arrange() #desc() 

# 1. How could you use arrange() to sort all missing values to the start? 
### We have to make sure that there really are missing values.
arrange(flights, desc(is.na(dep_time)))

# 2. Sort flights to find the most delayed flights. 
#    Find the flights that left earliest. 
### Latest: dep_delay: 1301min // arr_delay: 1272min
arrange(flights, desc(dep_delay), desc(arr_delay))
arrange(flights, desc(arr_delay), desc(dep_delay))
### Earliset: dep_delay: -43min // arr_delay: -86min
arrange(flights, dep_delay, arr_delay)
arrange(flights, arr_delay, dep_delay)

# 3. Sort flights to find the fastest flights. 
### 20min
View(arrange(flights, air_time))

# 4. Which flights traveled the longest? Which traveled the shortest?
# Shortest: 17 miles // Longest: 4983 miles
View(arrange(flights, distance))
View(arrange(flights, desc(distance)))

# Notes I took while reading
library(nycflights13) library(tidyverse)
data(flights) View(flights)
# Arranging with several columns 
arrange(flights, year, month, day)
# Descending Order
arrange(flights, desc(arr_delay))
# Missing values always at the end
df <-tibble(x = c(5, 2, NA)) 
arrange(df, x)