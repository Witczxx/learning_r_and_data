# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 03 - Notes 03
# #select() #HelperFunctions #starts_with() #ends_with() #contains() #all_of() #any_of() #ignore.case= #rename() #everything()

library(nycflights13) 
library(tidyverse)
data(flights) 
View(flights)
# Select columns by year, month and day
select(flights, year, month, day)
# Select all columns between year and day
select(flights, year:day)
# Select all columns except those from year to day (inclusive) 
select(flights, -(year:day))
# Helper functions for select()
starts_with("abc")   # begin with “abc”
ends_with("xyz")     # end with “xyz”
contains("ijk")      # contain “ijk”
matches("(.)\\1")    # match a regular expression
num_range("x", 1:3)  # matches x1, x2, x3.
# select() can rename variables, but not used, cause drops all other variables not expl. mentioned
# rename() is used, it keeps all other variables not explicitly mentioned. It's a variation of select()
rename(flights, tail_num = tailnum)
# everything() helps to move variables to the start of the data frame
select(flights, time_hour, air_time, everything())