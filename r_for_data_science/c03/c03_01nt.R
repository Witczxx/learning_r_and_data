# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Notes 01
# #dplyr #VarliableTypes #filter() #is.na(x) #Operators

install.packages("nycflights13")
library(nycflights13)
head(flights)
filter(flights, day == 1, month == 1)
(jan1 <- filter(flights, day == 1, month == 1))
# == does not work, when results are infinte -> use near() then
# Comparison Operators: >=, <, <=, != (not equal), and == (equal).
# Boolean Operators: & is “and” ; | is “or” ; ! is “not”
# %in% -> select every row where x is one of the values in y.
(nov_dec <- filter(flights, month %in% c(11, 12))) # 55.403 rows
(nov_dec <- filter(flights, month == c(11, 12))) # 27.702 rows
# De Morgan’s law: !(x & y) is the same as !x | !y /// !(x | y) is the same as !x & !y.
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)
# Normal calculation for NA (missing values) is not working. We have to use is.na(x) instead of "= na"
(df <- tibble(x = c(1, NA, 3)))
filter(df, x > 1) 
filter(df, is.na(x) | x > 1)