# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Exercise 05
# #Covariations #2ContinuousVariables #geom_bin2D #geom_hex

# 1. Instead of summarizing the conditional distribution with a boxplot, you could use a frequency polygon. 
#    What do you need to consider when using cut_width() versus cut_number()? 
#    How does that impact a visualization of the 2D distribution of carat and price? 
### cut_width() makes groups of width width.
### cut_number() makes n groups with (approximately) equal numbers of observations
?cut_width
?cut_number
ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_freqpoly(mapping = aes(color = cut_width(carat, 1, boudary = 0)))
ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_freqpoly(mapping = aes(color = cut_number(carat, 2)))

# 2. Visualize the distribution of carat, partitioned by price. 
###  Plotted with a box plot with 10 equal-width bins of $2,000. 
### The argument boundary = 0 ensures that first bin is $0–$2,000.
ggplot(data = diamonds) +
  geom_boxplot(mapping = aes(x = cut_number(price, 10), y = carat)) +
  coord_flip() +
  xlab("Price")
ggplot(diamonds, aes(x = cut_width(price, 2000, boundary = 0), y = carat)) +
  geom_boxplot(varwidth = TRUE) +
  coord_flip() +
  xlab("Price")

# 3. How does the price distribution of very large diamonds compare to small diamonds. 
#    Is it as you expect, or does it surprise you? 
### There are some suprising elements. The number of carat for 4600-6300 and 6300-9820 is not expanding much.
### What's alsosuprising is the number of outliners. Some very high carat numbers can have very low prices


# 4. Combine two of the techniques you’ve learned to visualize the combined distribution of cut, carat, and price. 
ggplot(diamonds, aes(x = cut_number(carat, 5), y = price, colour = cut)) +
  geom_boxplot()
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_hex() +
  facet_wrap(~cut, ncol = 1)
  
# 5. Two-dimensional plots reveal outliers that are not visible in one-dimensional plots. 
#    For example, some points in the following plot have an unusual combination of x and y values, 
#    which and y values appear normal when examined separately: 
#    ggplot(data = diamonds) + geom_point(mapping = aes(x = x, y = y)) + coord_cartesian(xlim = c(4, 11), ylim = c(4, 11)) 
#    Why is a scatterplot a better display than a binned plot for this case?
### The binned plot would incldue a jitter, allowing more points to be visible, but limiting accuracy
### Instead of recognising outliers, they might probably mix with the jittered points. 
ggplot(data = diamonds) + geom_point(mapping = aes(x = x, y = y)) + coord_cartesian(xlim = c(4, 11), ylim = c(4, 11)) 
