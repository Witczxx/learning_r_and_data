# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Exercise 05
# #summarize() #GroupedSummaries #Pipes #na.rm() #n() #median() #MeasuresOfSpread #MeasuresOfPosition
# #GroupingMultipleVariables #ungroup()

# 1. Brainstorm at least five different ways to assess the typical delay characteristics of a group of flights. 
#    Consider the following scenarios:
#      A flight is 15 minutes early 50% of the time, and 15 minutes late 50% of the time. 
#      A flight is always 10 minutes late. 
#      A flight is 30 minutes early 50% of the time, and 30 minutes late 50% of the time. 
#      99% of the time a flight is on time. 1% of the time it’s 2 hours late. 
#      Which is more important: arrival delay or departure delay? 
### Brainstorming: 
### 01 - Comparing years/months - are dep_delay // arr_delay at different times stronger/weaker?
### 02 - Comparing arr_delay/dest or dep_delay/origin - Are some airports more likely having delays?
### 03 - Comparing distances - Are higher distances reducing arr_delays?
### 04 - Comparing hours - Are there rush hours, where delays are higher?
### 05 - Comparing tailnum - Are there some planes types being more likely delayed?
### Scenarios:
### 01 - I could work with median() of arr_delay/dep_delay to check this characteristic.
### 02 - I could work with mean() of arr_delay/dep_delay to check this characteristic.
### 03 - I could work with median() of arr_delay/dep_delay to check this characteristic.
### 04 - I could use a filter and mean() of arr_delay/dep_delay to check this characteristic.
### 05 - I could compare dep_delay - arr_delay to search for relations. The arr_time is most important for the passenger.

# 2. Come up with another approach that will give you the same output (without using count()) as:
not_cancelled %>% 
  count(dest) # and 
not_cancelled %>% 
    count(tailnum, wt = distance) # if wt, computes sum(wt) for each group
### 01 Solution
not_cancelled |> 
  filter(!is.na(dep_delay), !is.na(arr_delay)) |> 
  group_by(dest) |> 
  summarize(n = n()) # or summarize(n = length(dest))
                     # or   tally() 
                     # count() is a shortcut for group_by() & tally()
### 02 Solution
not_cancelled |> 
  filter(!is.na(dep_delay), !is.na(arr_delay)) |> 
  group_by(tailnum) |> 
  summarize(n = sum(distance)) # or tally(distance)

# 3. Our definition of cancelled flights (is.na(dep_delay) | is.na(arr_delay) ) is slightly suboptimal. 
#    Why? Which is the most important column? 
### If a flight never departs, then it won’t arrive. 
### A flight could also depart and not arrive if it crashes,
### or if it is redirected and lands in an airport other than its intended destination. 
### So the most important column is arr_delay, which indicates the amount of delay in arrival.
filter(flights, is.na(dep_delay) | is.na(arr_delay))
filter(flights, is.na(arr_delay))

# 4. Look at the number of cancelled flights per day. 
#    Is there a pattern? 
#    Is the proportion of cancelled flights related to the average delay? 
### Cancelling number increases with number of flights
### There is a strong increasing relationship between both average departure delay
### and average arrival delay and the proportion of cancelled flights.
cancelled_per_day <- 
  flights %>%
  mutate(cancelled = (is.na(arr_delay) | is.na(dep_delay))) %>%
  group_by(year, month, day) %>%
  summarise(
    cancelled_num = sum(cancelled),
    flights_num = n())
ggplot(cancelled_per_day) +
  geom_point(aes(x = flights_num, y = cancelled_num)) 

cancelled_and_delays <- 
  flights %>%
  mutate(cancelled = (is.na(arr_delay) | is.na(dep_delay))) %>%
  group_by(year, month, day) %>%
  summarise(
    cancelled_prop = mean(cancelled),
    avg_dep_delay = mean(dep_delay, na.rm = TRUE),
    avg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  ungroup()
ggplot(cancelled_and_delays) +
  geom_point(aes(x = avg_dep_delay, y = cancelled_prop))

# 5. Which carrier has the worst delays? Challenge:
#    Can you disentangle the effects of bad airports versus bad carriers? 
#    Why/why not? [I had many mistakes - I used the solution]
#    (Hint: think about flights %>% group_by(carrier, dest) %>% summarize(n()).) 
### Worst Delay Carrier - Frontier Airlines Inc. - with 21.9 minutes delay
flights |> 
  group_by(carrier) |> 
  summarize(arr_delay = mean(arr_delay, na.rm = TRUE)) |> 
  arrange(desc(arr_delay))
### What airline has the airline code F9
filter(airlines, carrier == "F9")
# You can get part of the way to disentangling the effects of airports versus bad carriers 
# by comparing the average delay of each carrier to the average delay of flights within a route 
# (flights from the same origin to the same destination). 
# Comparing delays between carriers and within each route disentangles the effect of carriers and airports. 
# A better analysis would compare the average delay of a carrier’s flights to the average delay of all other carrier’s flights within a route.
flights %>%
  filter(!is.na(arr_delay)) %>%
  group_by(origin, dest, carrier) %>% 
  summarise( # Total delay by carrier within each origin, dest
    arr_delay = sum(arr_delay),
    flights = n()
  ) %>%
  group_by(origin, dest) %>% 
  mutate( # Total delay within each origin dest
    arr_delay_total = sum(arr_delay),
    flights_total = sum(flights)
  ) %>%
  ungroup() %>% 
  mutate( # average delay of each carrier - average delay of other carriers
    arr_delay_others = (arr_delay_total - arr_delay) /
      (flights_total - flights),
    arr_delay_mean = arr_delay / flights,
    arr_delay_diff = arr_delay_mean - arr_delay_others
  ) %>% 
  filter(is.finite(arr_delay_diff)) %>%  # remove NaN values (when there is only one carrier)
  group_by(carrier) %>%
  summarise(arr_delay_diff = mean(arr_delay_diff)) %>% # average over all airports it flies to
  arrange(desc(arr_delay_diff))

# 6. For each plane, count the number of flights before the first delay of greater than 1 hour. 
flights %>%
  filter(!is.na(dep_delay)) %>%
  group_by(tailnum) %>%
  mutate(row_number = row_number()) %>%
  filter(dep_delay > 60) %>%
  summarize(flights_before_delay = min(row_number) - 1)

# 7. What does the sort argument to count() do? 
#    When might you use it?
### The sort argument to count() sorts the results in order of n. 
### You could use this anytime you would run count() followed by arrange().
### For example, the following expression counts the number of flights to a destination 
### and sorts the returned data from highest to lowest.
flights %>%
  count(dest, sort = TRUE)