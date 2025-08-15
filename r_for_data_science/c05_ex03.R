# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Exercise 03
# #select() #HelperFunctions #starts_with() #ends_with() #contains() #all_of() #any_of() #ignore.case= #rename() #everything()

# 1. Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights. 
select(flights, dep_time, dep_delay, arr_time, arr_delay)
select(flights, starts_with("dep"), starts_with("arr_"))
select(flights, ends_with("_delay"), ends_with("_time"), -contains("sched"), -contains("air"))
select(flights, contains("dep_"), contains("arr_"), -starts_with("sched"), -starts_with("air"), -starts_with("time"))

# 2. What happens if you include the name of a variable multiple times in a select() call? 
### It is still going to appear only once. I don't have to worry about writing helper functions, which overlap in results.
  select(flights, dep_time, dep_time, dep_time)

# 3. What does the one_of() function do? 
#    Why might it be helpful in conjunction with this vector? 
#    vars <-c( "year", "month", "day", "dep_delay", "arr_delay" ) 
### There are new functions: all_of() and any_of()
### We can create a variable for a vector
### With all_of()/any_of() we can make select() search for variables with the vector names.
### all_of() is a strict selection. If any cariables is missing, an error is thrown.
### any_of() doesn't check for missing variables.
vars <-c( "year", "month", "day", "dep_delay", "arr_delay" )
select(flights, all_of(vars))
select(flights, any_of(vars))

# 4. Does the result of running the following code surprise you? 
#    How do the select helpers deal with case by default? 
#    How can you change that default?
### Actually it does not suprise me. The selection looks correct. I didn't know that select(contains()) is not so strict about Capslocks.
### By default we would get an error that the column `TIME` does not exist of course. contains() makes the code much shorter and the task easier.
### If we don't want that, we can add: ignore.case = FALSE
select(flights, contains("TIME"))
select(flights, TIME)
select(flights, contains("TIME"), ignore.case = FALSE)
?select() ?contains()



# Notes I took while reading
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