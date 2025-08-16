# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 03 - Exercise 04
# #BarCharts #Geoms&Stats #GeomPairs/GeomConcerts #Proportions

# 1. What is the default geom associated with stat_summary()? 
#    How could you rewrite the previous plot to use that geom function instead of the stat function? 
#    ggplot(data = diamonds) + 
#     stat_summary(
#      mapping = aes(x = cut, y = depth), 
#      fun.ymin = min, 
#      fun.ymax = max, 
#      fun.y = median
#     )
### The default geom is geom_pointrange To get a a point range, 
### I can write geom_pointrange instead of stat_summary.
### Also the arguments change because of changing the function
?stat_summary
ggplot(data = diamonds) +
  geom_pointrange(
    mapping = aes(x = cut, y = depth),
    stat = "summary",
    fun.min = min,
    fun.max = max,
    fun = median
  )
?geom_pointrange

# 2. What does geom_col() do? How is it different to geom_bar()? 
### geom_bar() makes the height of the bar proportional to the number of cases in each group
### geom_bar() uses stat_count() by default - it counts number of cases in each x position.
### geom_col() does represent the values in the data.
### geom_col() uses stat_identity() by default - it leaves the data as it is 
?geom_col()

# 3. Most geoms and stats come in pairs that are almost always used in concert. 
#    Read through the documentation and make a list of all the pairs. 
#    What do they have in common? 
### geom_bar() <-> stat_count()
### geom_smooth() <-> stat_smooth()
### geom_col() <-> stat_identity()
### geom_line() <-> stat_identity()
### geom_point() <-> stat_identity()
### They all make adjustments in the accuracy data is represented.
### Sometimes they represent truly the data, sometimes they represent averages or proportions.
?geom_line()
?geom_point()
?geom_col()

# 4. What variables does stat_smooth() compute? 
### It helps us to recognise a pattern, when there's presence of overplotting.
### Like a line that is drawn among a huge number of dots in a scatterplot.
?stat_smooth()

# 5. In our proportion bar chart, we need to set group = 1. 
#    Why? 
#    In other words what is the problem with these two graphs? 
#    ggplot(data = diamonds) + 
#     geom_bar(mapping = aes(x = cut, y = ..prop..)) 
#    ggplot(data = diamonds) + 
#     geom_bar( mapping = aes(x = cut, fill = color, y = ..prop..) )
### By setting y = ..prop.. - we defined that the y-axis represents an equal distribution
### The y-axis does not represent the true values of the x-axis 
### This plot does not represent the real data - we have to remove the y-axis
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut)) 
ggplot(data = diamonds) + 
  geom_bar( mapping = aes(x = cut, fill = color))