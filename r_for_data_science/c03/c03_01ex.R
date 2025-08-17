# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 03 - Notes 01
# #dplyr #VarliableTypes #filter() #is.na(x) #Operators

# 1. Find all flights that: 
data(flights) View(flights) ?flights
#    a. Had an arrival delay of two or more hours 
filter(flights, arr_delay >= 120)
#    b. Flew to Houston (IAH or HOU) 
filter(flights, dest == "IAH" | dest == "HOU")
#    c. Were operated by United, American, or Delta
filter(flights, carrier == "US")
#    d. Departed in summer (July, August, and September) 
filter(flights, month %in% c(7, 8, 9))
#    e. Arrived more than two hours late, but didn’t leave late 
filter(flights, dep_delay >= 0 & arr_delay >= 120)
#    f. Were delayed by at least an hour, but made up over 30 minutes in flight
filter(flights, dep_delay >= 60 & arr_delay <= (dep_delay - 30))
#    g. Departed between midnight and 6 a.m. (inclusive) 
filter(flights, dep_time <= 600 | dep_time >= 2400)

# 2. Another useful dplyr filtering helper is between(). 
#    What does it do? 
#    Can you use it to simplify the code needed to answer the previous challenges? 
### It is the same as writing "x >= left & x <= right"
### The syntax looks like this: between(x, left, right)
?between() # Here is an Example:
filter(flights, between(dep_time, 1300, 1500))

# 3. How many flights have a missing dep_time? 
#    What other variables are missing? 
#    What might these rows represent? 
### By looking at the filtered data, it feels like flights without dep_time were canceled.
### Because also arr_time and air_time are missing for observations with NA in their dep_time.
filter(flights, is.na(dep_time))

# 4. Why is NA ^ 0 not missing? 
### Because it doesn't matter, which value NA has. 
### The result would be the same with every number.
### So R can make sure that the value of NA doesn't matter.
NA ^ 0
#    Why is NA | TRUE not missing? 
NA | TRUE
### If one value is TRUE by using | , the other value does not matter.
### The answer would always be TRUE for this case.
### ### So R can make sure that the value of NA doesn't matter.
#    Why is FALSE & NA not missing? 
FALSE & NA
### If one value is FALSE by using & , the other value does not matter.
### THe answer would always be FALSE for this cas.e
### So R can make sure that the value of NA doesn't matter.
#    Can you figure out the general rule? 
### As long as R can make sure that it doesn't matter, which value NA has.
### As long as this is sure, R won't have any problems to do such operations with NA.