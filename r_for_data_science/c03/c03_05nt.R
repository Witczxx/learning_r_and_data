# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Notes 05
# #summarize() #GroupedSummaries #Pipes #na.rm() #n() #median() #MeasuresOfSpread #MeasuresOfPosition
# #GroupingMultipleVariables #ungroup()

library(nycflights13) 
library(tidyverse)
data(flights) 
View(flights)
# Summarize() can collapse a data frame into a single row:
summarize(flights, delay = mean(dep_delay, na.rm = TRUE))
# It becomes much more useful, when using it with group_by()
# Called: Gouped Summaries
by_day <-group_by(flights, year, month, day) 
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))
# Introduction to usage of Pipes:
# We can make codes much shorter and easier to read by using pipes
# Until now we would write codes like this:
by_dest <-group_by(flights, dest) 
delay <-summarize(by_dest, count = n(),
                    dist = mean(distance, na.rm = TRUE), 
                    delay = mean(arr_delay, na.rm = TRUE) ) 
delay <-filter(delay, count > 20, dest != "HNL")
ggplot(data = delay, mapping = aes(x = dist, y = delay)) + 
  geom_point(aes(size = count), alpha = 1/3) + 
  geom_smooth(se = FALSE)
# We have three steps: group_by(), summarize() and filter()
# A little frustrating - every time we have to come up with new variables
# We can use Pipes! (%>%) Imagine it like saying "then" while speaking out the code:
delays <-flights %>%
  group_by(dest) %>% 
  summarize( count = n(),
             dist = mean(distance, na.rm = TRUE), 
             delay = mean(arr_delay, na.rm = TRUE) ) %>% 
  filter(count > 20, dest != "HNL")
ggplot(data = delays, mapping = aes(x = dist, y = delay)) + 
  geom_point(aes(size = count), alpha = 1/3) + 
  geom_smooth(se = FALSE)
# Why do we need na.rm ? Let's test:
flights %>% 
  group_by(year, month, day) %>% 
  summarize(mean = mean(dep_delay))
# 99% of the mean column turns into NA!
# That’s because aggregation functions obey the usual rule of missing values: 
# if there’s any missing value in the input, the output will be a missing value.
# We need an na.rm argument, which removes missing values prior computation.
flights %>% 
  group_by(year, month, day) %>% 
  summarize(mean = mean(dep_delay, na.rm = TRUE)) # Here it is !
# We could also tackle the problem by first removing the missing values:
not_cancelled <-flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay)) 
not_cancelled %>% 
    group_by(year, month, day) %>% 
    summarize(mean = mean(dep_delay))
# It is also good to include counts (n()). Make sure that your conclusions are not based on a small set of data.
delays <-not_cancelled %>% 
  group_by(tailnum) %>% 
  summarize( delay = mean(arr_delay) ) 
ggplot(data = delays, mapping = aes(x = delay)) + geom_freqpoly(binwidth = 10)
# Now to see, how many flights are really over 200 or 300 minutes:
delays <-not_cancelled %>% 
  group_by(tailnum) %>% 
  summarize( delay = mean(arr_delay, na.rm = TRUE), n = n() )  # Here we add n() to count
ggplot(data = delays, mapping = aes(x = n, y = delay)) + geom_point(alpha = 1/10) # We use a plot to illustrate density 
# Here the variation looks completely different now.
# Now let's filter out the extreme numbers to get a better picture. We only want counts that appear more than 25 times:
delays %>% 
  filter(n > 25) %>% 
  ggplot(mapping = aes(x = n, y = delay)) + geom_point(alpha = 1/10)
# The delay doesn't go up until 300 anymore. It goes up until a maximum of 60 minutes
# Let's work with the Lahman Package and work with baseball data
install.packages("Lahman")
library(Lahman)
data(Batting)
View(Batting)
# Let's create a tibble and find out the relationship of hitting a bat and how often the player is allowed to play at bats:
batting <- as_tibble(Batting) 
batters <- batting %>% 
  group_by(playerID) %>% 
  summarize( ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE), ab = sum(AB, na.rm = TRUE) )
batters %>% 
  filter(ab > 100) %>% 
  ggplot(mapping = aes(x = ab, y = ba)) + geom_point() + geom_smooth(se = FALSE)
# The batters with the best batting averages are lucky, not skilled - look at their ranking:
batters %>% arrange(desc(ba))

# Other useful summary functions
# There are more than means counts and sums.
# median(x) is the sum divided by the length. It is where 50% of x is above it, 50% of x is below it
# Measures of rank min(x), quantile(x, 0.25), max(x)
# Sometimes it is useful to combine aggregation with logical subsetting (new):
# ( I guess it is the possibility to add things with [ ] )
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize( 
    avg_delay1 = mean(arr_delay), # average delay
    avg_delay2 = mean(arr_delay[arr_delay > 0]) ) # average positive delay
# Measures of spread sd(x), IQR(x), mad(x)
# sd(x) : mean squared deviation or standard deviation (sd) - is the standard measure of spread
# IQR(x) : interquatile range | mad(x) : median absolute deviation mad(x)
# Example: Why is distance to some destinations more variable than to others? 
not_cancelled %>% 
  group_by(dest) %>% 
  summarize(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))
# Measures of position first(x), nth(x, 2), last(x)
# similar to x[1], x[2], x[length(x)]
# Let you set a default value if that position does not exist 
# e.g. you're trying to get a third element from a group that only has 2 elements
# For example, we can find the first and last departure of each day
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize( first_dep = first(dep_time), last_dep = last(dep_time) )
# Check: This is complementary to the ranking functions!
# Filtering gives you all variables, each in a separate row:
not_cancelled %>% 
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time))) %>% filter(r %in% range(r))
?range # Returns a vector containing the minimum and maximum of all given arguments
# So instead of having the values in 2 columns, we have them every time in 2 rows.
# To count the number of non-missing val‐ ues, use sum(!is.na(x)). 
# To count the number of distinct (unique) values, use n_distinct(x):
# Which destinations have the most carriers? 
not_cancelled %>% 
  group_by(dest) %>% 
  summarize(carriers = n_distinct(carrier)) %>% 
  arrange(desc(carriers))
# Counts are so useful that dplyr provides a simple helper if all you want is a count: 
# It generates automatically a column with n - where it counts a number of rows appearin in a column
not_cancelled %>% count(dest)
# Counts and proportions of logical values sum(x > 10), mean(y == 0) 
# When used with numeric functions, TRUE is converted to 1 and FALSE to 0. 
# This makes sum() and mean() very useful: 
# sum(x) gives the number of TRUEs in x, and mean(x) gives the proportion:
# How many flights left before 5am? (these usually indicate delayed flights from the previous day) 
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize(n_early = sum(dep_time < 500))
# What proportion of flights are delayed by more than an hour? 
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize(hour_perc = mean(arr_delay > 60))
# Grouping by multiple variables - each summary peels off one level of the grouping.
# That makes it easy to progressively roll up a dataset:
daily <- group_by(flights, year, month, day) 
(per_day <-summarize(daily, flights = n()))
(per_month <-summarize(per_day, flights = sum(flights))) # Removed days to months !!!
(per_year <-summarize(per_month, flights = sum(flights))) # Removed months to years !!!
# Be careful - it's a little dirty working - doesn't work for rank-based statistics and medians !!!
# Ungrouping - If you need to remove grouping, and return to operations on ungrouped data, use ungroup():
daily %>% 
  ungroup() %>% # no longer grouped by date 
  summarize(flights = n()) # all flights