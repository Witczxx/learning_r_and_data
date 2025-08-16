# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Exercise 04
# #mutate() #HowToAddColumns #transmute() 
# #ModularArithmetics #%/% #%% 
# #log() #lag() #lead()
# #CummulativeAggregates #RollingAggregates #LogicalComparisons 
# #RankingFunctions #min_rank() #max_rank()

# 1. Currently dep_time and sched_dep_time are convenient to look at, 
#    but hard to compute with because they’re not really continuous numbers. 
#    Convert them to a more convenient representation of number of minutes since midnight. 
### %% 1400 will turn the observations 2400 into a zero. 
departure_minutes <- mutate(select(flights, dep_time, sched_dep_time), 
    dep_minutes = (dep_time %/% 100 * 60 + dep_time %% 100) %% 1440,
    sched_minutes = (sched_dep_time %/% 100 * 60 + sched_dep_time %% 100) %% 1440
)
filter(departure_minutes, dep_time == 2400)

# 2. Compare air_time with arr_time - dep_time. 
#    What do you expect to see? 
#    What do you see? 
#    What do you need to do to fix it? 
### I would expect to see that the difference between arr_time and dep_time equals air_time.
### The numbers are varying, but the air time always seems to be smaller than the calculated time.
### It means that that departure time and arrival time includes more than simply the air time.
### To fix it, I could set our calculated columns as the new air_time.
mutate(select(flights, air_time, arr_time, dep_time), 
arr_dep_diff = arr_time - dep_time,
arr_dep_diff_air_diff = arr_dep_diff - air_time
)
mutate(select(flights, air_time, arr_time, dep_time),
air_time = arr_time - dep_time)

# 3. Compare dep_time, sched_dep_time, and dep_delay. 
#    How would you expect those three numbers to be related? 
### dep_delay is dep_time - sched_dep_time
### But it is not simply counting with the numbers, but with hours and minutes
### We could use the results from task 1 to create a calculating imitating dep_delay
mutate(select(flights, dep_time, sched_dep_time, dep_delay), 
    dep_minutes = (dep_time %/% 100 * 60 + dep_time %% 100) %% 1440,
    sched_minutes = (sched_dep_time %/% 100 * 60 + sched_dep_time %% 100) %% 1440,
    dep_delay_check = dep_minutes - sched_minutes
)

# 4. Find the 10 most delayed flights using a ranking function. 
#    How do you want to handle ties? 
#    Carefully read the documentation for min_rank(). 
### I couldn't solve it myself, I needed to search for a solution.
### But I feel like I understand of how to work with rank functions now
### My problem was that I failed to put it into a separate column using mutate()
### Beacuse of this, my results were not connected to the data frame and my approach felt wrong. 
?min_rank()
flights_delayed <- mutate(flights,  ### We use mutate() to extend the dataframes by the given ranks
    dep_delay_min_rank = min_rank(desc(dep_delay)),
    dep_delay_row_number = row_number(desc(dep_delay)),
    dep_delay_dense_rank = dense_rank(desc(dep_delay))
    )
flights_delayed <- filter(flights_delayed, ### We filter the dataframe to only get our top 10
                          !(dep_delay_min_rank > 10 | dep_delay_row_number > 10 |
                              dep_delay_dense_rank > 10))
flights_delayed <- arrange(flights_delayed, dep_delay_min_rank) ### We arrange them in ascending ranking order
print(select(flights_delayed, month, day, carrier, flight, dep_delay, 
             dep_delay_min_rank, dep_delay_row_number, dep_delay_dense_rank), 
      n = Inf) # n = Inf, To check if our filtering was correct

# 5. What does 1:3 + 1:10 return? 
#    Why? 
### Looks like when adding two vectors of different lengths
### It leads to the fact that the shorter vector starts repeating to fill the missing values
### it calculated: 1+1, 2+2, 3+3, 1+4, 2+5, 3+6, 1+7, 2+8, 3+9, 1+10
 1:3 + 1:10

# 6. What trigonometric functions does R provide?
# ?Trig shows - cos/sin/tan a- cos/sin/tan/tan2 cospi/sinpi/tanpi (x)