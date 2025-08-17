# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 03 - Notes 02
# #arrange() #desc() 

library(nycflights13) library(tidyverse)
data(flights) View(flights)
# Arranging with several columns 
arrange(flights, year, month, day)
# Descending Order
arrange(flights, desc(arr_delay))
# Missing values always at the end
df <-tibble(x = c(5, 2, NA)) 
arrange(df, x)