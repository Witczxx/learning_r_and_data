# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Exercise 05
# #Covariations #2ContinuousVariables #geom_bin2D #geom_hex


# 1. Instead of summarizing the conditional distribution with a boxplot, you could use a frequency polygon. 
#    What do you need to consider when using cut_width() versus cut_number()? 
#    How does that impact a visualization of the 2D distribution of carat and price? 
### cut_width() makes groups of width width.
### cut_number makes n groups with (approximately) equal numbers of observations


### HERE WE STOPPED
### SEPARATING BY COLOR IS NOT WORKING SO FAR 
ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_freqpoly(mapping = aes(color = cut_number(carat, 1)))

?cut_width
?cut_number
?diamonds()


# 2. Visualize the distribution of carat, partitioned by price. 



# 3. How does the price distribution of very large diamonds compare to small diamonds. 
#    Is it as you expect, or does it surprise you? 



# 4. Combine two of the techniques you’ve learned to visualize the combined distribution of cut, carat, and price. 



# 5. Two-dimensional plots reveal outliers that are not visible in one-dimensional plots. 
#    For example, some points in the following plot have an unusual combination of x and y values, 
#    which and y values appear normal when examined separately: 
#    ggplot(data = diamonds) + geom_point(mapping = aes(x = x, y = y)) + coord_cartesian(xlim = c(4, 11), ylim = c(4, 11)) 
#    Why is a scatterplot a better display than a binned plot for this case?
