# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Note 06
# #

library(tidyverse)
library(nycflights13)
library(magick)
data(diamonds)
data(flights)

# Patterns provide one of the most useful tools for data scientists because they reveal covariation. 
# If you think of variation as a phe‐ nomenon that creates uncertainty, covariation is a phenomenon that reduces it.
# Predicting Price from Model (computing residuals - actual/predicted value) :
library(modelr) 
mod <-lm(log(price) ~ log(carat), data = diamonds) 
diamonds2 <-diamonds %>% 
  add_residuals(mod) %>% 
  mutate(resid = exp(resid))
ggplot(data = diamonds2) + geom_point(mapping = aes(x = carat, y = resid))

# Once we remove the strong relationship of carat and price, things are more clear now:
# The relation between cut and price is much more clear now:
ggplot(data = diamonds2) + geom_boxplot(mapping = aes(x = cut, y = resid))

# In the following chapters we will shorten the code of ggplot:
ggplot(data = faithful, mapping = aes(x = eruptions)) + geom_freqpoly(binwidth = 0.25)
ggplot(faithful, aes(eruptions)) + geom_freqpoly(binwidth = 0.25)
# Sometimes the end of a pipe will be turned into a plot:
diamonds %>% 
  count(cut, clarity) %>% ggplot(aes(clarity, cut, fill = n)) + 
  geom_tile()