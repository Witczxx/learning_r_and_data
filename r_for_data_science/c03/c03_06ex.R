# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Exercise 06
# #Group&Filter #Group&Mutate #GroupedFilters #WindowFunctions

# 1. Refer back to the table of useful mutate and filtering functions. 
#    Describe how each operation changes when you combine it with grouping.
### It is cool because we can specify filtering and mutating more - not just targeting the whole dataframe
### Mutate-Example:
### We create a new column with dep_delay - arr_delay. To every observation there will be a new value created.
### If we group it by month additionally: 
### It will put all dep_delay and arr_delay of a month together and then build the difference
### Filter-Example:
### We create a filter, where we only see arr_delay > 60 minutes - It applies on every observation
### Once we group the filter by dest, all destinations will be filtered, which have an arr_delay > 60 minutes


# 2. Which plane (tailnum) has the worst on-time record? 
### We don't have an on-time record. We have to create one:
### On-Time Record = On Time Arrival / Total Arrival * 100
flights %>%
  filter(!is.na(tailnum)) %>%
  mutate(on_time = !is.na(arr_time) & (arr_delay <= 0)) %>%
  group_by(tailnum) %>%
  summarise(on_time = mean(on_time), n = n()) %>%
  filter(min_rank(on_time) == 1)
quantile(count(flights, tailnum)$n)
flights %>%
  filter(!is.na(tailnum), is.na(arr_time) | !is.na(arr_delay)) %>%
  mutate(on_time = !is.na(arr_time) & (arr_delay <= 0)) %>%
  group_by(tailnum) %>%
  summarise(on_time = mean(on_time), n = n()) %>%
  filter(n >= 20) %>%
  filter(min_rank(on_time) == 1)

# 3. What time of day should you fly if you want to avoid delays as much as possible? 
### At 7:00 am, the plane is having its earliest arrivals.
### I would try to plan my trip according to this arrival time.
flights |> 
  group_by(hour) |> 
  summarise(mean_arr_delay = mean(arr_delay, na.rm = TRUE)) |> 
  arrange(mean_arr_delay)

# 4. For each destination, compute the total minutes of delay. 
#    For each flight, compute the proportion of the total delay for its destination. 
flights |> 
  filter(arr_delay > 0) |> 
  group_by(dest) |> 
  mutate(sum_arr_delay = sum(arr_delay),
         arr_delay_prop = arr_delay / sum_arr_delay) |> 
  select(dest, month, day, dep_time, carrier, flight,
         arr_delay, arr_delay_prop) %>%
  arrange(dest, desc(arr_delay_prop))

# 5. Delays are typically temporally correlated: 
#    even once the problem that caused the initial delay has been resolved, 
#    later flights are delayed to allow earlier flights to leave. 
#    Using lag() explores how the delay of a flight is related to the delay of the immediately preceding flight. 
lagged_delays <- flights %>%
  arrange(origin, month, day, dep_time) %>%
  group_by(origin) %>%
  mutate(dep_delay_lag = lag(dep_delay)) %>%
  filter(!is.na(dep_delay), !is.na(dep_delay_lag))

lagged_delays %>%
  group_by(dep_delay_lag) %>%
  summarise(dep_delay_mean = mean(dep_delay)) %>%
  ggplot(aes(y = dep_delay_mean, x = dep_delay_lag)) +
  geom_point() +
  scale_x_continuous(breaks = seq(0, 1500, by = 120)) +
  labs(y = "Departure Delay", x = "Previous Departure Delay")

lagged_delays %>%
  group_by(origin, dep_delay_lag) %>%
  summarise(dep_delay_mean = mean(dep_delay)) %>%
  ggplot(aes(y = dep_delay_mean, x = dep_delay_lag)) +
  geom_point() +
  facet_wrap(~ origin, ncol=1) +
  labs(y = "Departure Delay", x = "Previous Departure Delay")

# 6. Look at each destination. 
#    Can you find flights that are suspiciously fast? 
#    (That is, flights that represent a potential data entry error.) 
#    Compute the air time of a flight relative to the shortest flight to that destination. 
#    Which flights were most delayed in the air? 
standardized_flights <- flights %>%
  filter(!is.na(air_time)) %>%
  group_by(dest, origin) %>%
  mutate(
    air_time_mean = mean(air_time),
    air_time_sd = sd(air_time),
    n = n()
  ) %>%
  ungroup() %>%
  mutate(air_time_standard = (air_time - air_time_mean) / (air_time_sd + 1))
# Unusually fast flights are those flights with the smallest standardized values.
ggplot(standardized_flights, aes(x = air_time_standard)) +
  geom_density()
standardized_flights %>%
  arrange(air_time_standard) %>%
  select(
    carrier, flight, origin, dest, month, day,
    air_time, air_time_mean, air_time_standard
  ) %>%
  head(10) %>%
  print(width = Inf)

# 7. Find all destinations that are flown by at least two carriers. Use that information to rank the carriers.
flights %>%   
  group_by(dest) %>%
   mutate(n_carriers = n_distinct(carrier)) %>%
   filter(n_carriers > 1) %>% # rank carriers by number of destinations
   group_by(carrier) %>%
   summarize(n_dest = n_distinct(dest)) %>%
   arrange(desc(n_dest))
filter(airlines, carrier == "EV")
filter(airlines, carrier %in% c("AS", "F9", "HA"))