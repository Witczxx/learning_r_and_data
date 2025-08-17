# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 03 - Notes 06
# #Group&Filter #Group&Mutate #GroupedFilters #WindowFunctions

library(nycflights13) 
library(tidyverse)
library(Lahman)
data(flights) 
data(Batting)
# Grouping is most useful in conjunction with summarize(), 
# but you can also do convenient operations with mutate() and filter(): 
# Find the worst members of each group:
flights %>% 
  group_by(year, month, day) %>% 
  filter(rank(desc(arr_delay)) < 10)
# Find all groups bigger than a threshold:
popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365)
# Standardize to compute per group metrics: 
popular_dests %>% 
  filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay)
# A grouped filter is a grouped mutate followed by an ungrouped filter.
# Generally avoid these, because they are not working clean
# Functions that work most naturally in grouped mutates and filters are known as window functions
# Want to see window functions? -> vignette("window-functions")