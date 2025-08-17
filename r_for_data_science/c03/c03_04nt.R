# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 03 - Notes 04
# #mutate() #HowToAddColumns #transmute() 
# #ModularArithmetics #%/% #%% 
# #log() #lag() #lead()
# #CummulativeAggregates #RollingAggregates #LogicalComparisons 
# #RankingFunctions #min_rank() #max_rank()

library(nycflights13) 
library(tidyverse)
data(flights) 
View(flights)
# Create a new dataset to show how to add columns
(flights_sml <-select(flights, year:day, ends_with("delay"), distance, air_time ))
mutate(flights_sml, gain = arr_delay-dep_delay, speed = distance / air_time * 60)
# You can refer to just created columns
mutate(flights_sml, gain = arr_delay-dep_delay, hours = air_time / 60, gain_per_hour = gain / hours)
# Instead of adding columns, you can create a result with just the new columns
transmute(flights, gain = arr_delay-dep_delay, hours = air_time / 60, gain_per_hour = gain / hours )
# Arithmetic operators [+, -, *, /, ^] are KEY here -> later with Aggregate Functions
# Modular arithmetics %/% (integer division) and %% (remainder)
# Allow us to break integer into pieces - like a shortcut for round()
# If we have 517 - %/%100 creates 5 - and %%100 creates 17
transmute(flights, dep_time, hour = dep_time %/% 100, minute = dep_time %% 100 )
# log(), lag() and lead() -> Let's just know they exist first [need group_by()]
# Cummulative/Rolling Aggreagtes: Provides Functions for running Sums
# cumsum(), cumprod(), cummin(), cummax() cummean()
# If needed rolling aggregates, try the RcppRoll packages
x <- c(1:10)
cumsum(x)
cummean(x)
cummin(x)
cummax(x)
# Logical Comparisons [<, <=, >, >=, !=] - Store interim values in new variables [Best Practice]
# Ranking Functions - Each row gets a Rank_NR, and he is listing the numbres of the Rank
# Naturally in ascending oder - and if we want to - in descending order
# There is a lot of Ranking Functions -> reading ?min_rank is really worth!
?min_rank
y <-c(1, 2, 2, NA, 3, 4) 
min_rank(y)
min_rank(desc(y))
row_number(y) 
dense_rank(y) 
percent_rank(y) 
cume_dist(y)
ntile(y)