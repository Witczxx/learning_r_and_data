# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Note 02
# #UnusualValues #MissingValues #ChangingValues

# 2 Options when encountering unusual values:
#   Dropping entire rows [not recommended]
#   Replacing unusual values with missing values [saving rest of observation]
# Easiest wasy to replace unusual values with NA - using mutate()
diamonds2 <-diamonds %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y))
# ifelse() has three arguments. 
#          First argument test should be a logical vector. 
#          Result is value of the second argument (True).
#          Rest is value of the third argument (False).
# ggplot2 sends us a warning while generating plots, if values are missing
# We can suppress this warning by using na.rm = TRUE

# Sometimes we want to understand missing values. We can illustrate them with is.na() :
nycflights13::flights %>% 
  mutate( cancelled = is.na(dep_time), 
          sched_hour = sched_dep_time %/% 100, 
          sched_min = sched_dep_time %% 100, 
          sched_dep_time = sched_hour + sched_min / 60 
        ) %>% 
  ggplot(mapping = aes(sched_dep_time)) +
  geom_freqpoly( mapping = aes(color = cancelled), 
                 binwidth = 1/4 
                )
# However, this plot isn’t great because there are many more non-cancelled flights than cancelled flights. 
# In the next section we’ll explore some techniques for improving this comparison.
