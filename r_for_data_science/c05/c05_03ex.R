# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Exercise 03
# #Covariation #geom_boxplot() #reorder()

# 1. Use what you’ve learned to improve the visualization of the departure times of cancelled versus noncancelled flights.
### Compare the density 
nycflights13::flights %>% 
  mutate( cancelled = is.na(dep_time), 
          sched_hour = sched_dep_time %/% 100, 
          sched_min = sched_dep_time %% 100, 
          sched_dep_time = sched_hour + sched_min / 60 
        ) %>% 
  ggplot() +
  geom_freqpoly(mapping = aes(x = sched_dep_time, 
                              y = ..density..,  
                              color = cancelled), 
                              binwidth = 1/4
                )
### Or use a boxplot
nycflights13::flights %>%
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>%
  ggplot() +
  geom_boxplot(mapping = aes(y = sched_dep_time, x = cancelled))


# 2. What variable in the diamonds dataset is most important for predicting the price of a diamond? 
#    How is that variable correlated with cut? 
#    Why does the combination of those two relationships lead to lower quality diamonds being more expensive? 
### The 2 numerical variables depth and table do not have a clear relation to the price
### The 3 categorical values cut, color and price might be an okay choice across all categories to make predictions
### But the best variable is carat, since it has a direct relation without any overlapping. 
### It is numerical to numerical variable in direct contact, very clear.
ggplot(data = diamonds, mapping= aes(x = cut, y = price)) + geom_boxplot() # cut, a little predictive
ggplot(data = diamonds) + geom_freqpoly(mapping = aes(x = price, y = ..density.., color = cut))
ggplot(data = diamonds, mapping= aes(x = color, y = price)) + geom_boxplot() # color, a little predictive
ggplot(data = diamonds) + geom_freqpoly(mapping = aes(x = price, y = ..density.., color = color))
ggplot(data = diamonds, mapping= aes(x = clarity, y = price)) + geom_boxplot() # price, a little predictive
ggplot(data = diamonds) + geom_freqpoly(mapping = aes(x = price, y = ..density.., color = clarity))
ggplot(data = diamonds) + geom_smooth(mapping = aes(x = price, y = carat)) # Carat, Very clear relation
ggplot(data = diamonds) + geom_smooth(mapping = aes(x = price, y = depth)) # Depth, No clear relation
ggplot(data = diamonds) + geom_smooth(mapping = aes(x = price, y = table)) # Table, No clear relation
### Solution
### Also sasying carat
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point()
nycflights13::flights %>%
ggplot(data = diamonds, mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)), orientation = "x")


# 3. Install the ggstance package, and create a horizontal boxplot. 
#    How does this compare to using coord_flip()? 
### The big difference lies in the fact that x = and = are defined correctly in geom_boxploth()
### Meanwhile when using coord_flip(), our definition of x= and y= will always be switched.
install.packages("ggstance")
library(ggstance)
help(package = "ggstance")
ggplot(data = diamonds, mapping= aes(x = cut, y = price)) + geom_boxplot() + coord_flip()
ggplot(data = diamonds, mapping= aes(x = price, y = color)) + geom_boxplot()
### CURRENT VERSION OF GGPLOT2 DO NOT REQUIRE coord_flip() !!!!!
### The orientation argument is used to explicitly specify the axis orientation of the plot.
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(y = reorder(class, hwy, FUN = median), x = hwy), orientation = "y")

# 4. One problem with boxplots is that they were developed in an era of much smaller datasets 
#    and tend to display a prohibitively large number of “outlying values.” 
#    One approach to remedy this problem is the letter value plot. 
#    Install the lvplot package, and try using geom_lv() to display the distribution of price versus cut. 
#    What do you learn? How do you interpret the plots? 
### Like box-plots, the boxes of the letter-value plot correspond to quantiles. 
### However, they incorporate far more quantiles than box-plots.
### They are useful for larger datasets.
### Larger datasets can give precise estimates of quantiles beyond the quartiles.
install.packages("lvplot")
library(lvplot)
help(package = "lvplot")
?geom_lv
ggplot(data = diamonds) + geom_lv(mapping = aes(x = cut, y = price))

# 5. Compare and contrast geom_violin() with a faceted geom_histogram(), or a colored geom_freqpoly(). 
#    What are the pros and cons of each method? 
###  The geom_freqpoly() is better for look-up: meaning that given a price, it is easy to tell which cut has the highest density.
###  However, the overlapping lines makes it difficult to distinguish how the overall distributions relate to each other.
### The geom_violin() and faceted geom_histogram() have similar strengths and weaknesses. 
### It is easy to visually distinguish differences in the overall shape of the distributions.
### However, we can’t easily compare the vertical values of the distribution.
### It is difficult to look up which category has the highest density for a given price.
?geom_violin
?geom_histogram
?geom_freqpoly
ggplot(data = diamonds) + geom_violin(mapping = aes(x = cut, y = price))
ggplot(data = diamonds) + geom_histogram(mapping = aes(x = price, fill = cut))
ggplot(data = diamonds) + geom_freqpoly(mapping = aes(x = price, color = cut))

# 6. If you have a small dataset, it’s sometimes useful to use geom_jitter() 
#    to see the relationship between a continuous and categorical variable. 
#    The ggbeeswarm package provides a number of methods similar to geom_jitter(). 
#    List them and briefly describe what each one does.
### geom_quasirandom() produces plots that are a mix of jitter and violin plots.
### geom_beeswarm() produces a plot similar to a violin plot, but by offsetting the points.
install.packages("ggbeeswarm")
library(ggbeeswarm)
help(package = "ggbeeswarm")
ggplot(data = mpg) + geom_quasirandom(mapping = aes(
    x = reorder(class, hwy, FUN = median),  y = hwy))
ggplot(data = mpg) + geom_quasirandom(mapping = aes(
    x = reorder(class, hwy, FUN = median), y = hwy), method = "tukey")