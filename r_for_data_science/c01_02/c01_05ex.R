# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 01 - Exercise 05
# #Position:Identity/Fill/Dodge/Jitter #aes(Color/Fill) #geom_boxplot #geom_count #geom_jitter

# 1. What is the problem with this plot? 
#    How could you improve it? 
#    ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + geom_point() 
### We can use geom_jitter() instead of geom_point()
### The plot with geom_point() does not show all values. It might be misleading, since we can not see the density of the data.
### With geom_jitter() some randomization is added, making the values a little less accurate, but the plot more complete.
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + geom_point()
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + geom_jitter() 

# 2. What parameters to geom_jitter() control the amount of jittering? 
### We can do it by adding width and height. It is set by default to 40%. 
### The higher the number, the stronger the jitter is going to be.
?geom_jitter()

# 3. Compare and contrast geom_jitter() with geom_count(). 
### geom_jitter() allows the values to move a little away from their actual position to increase the number of values that can be shown.
### geom_count() follows another concept. It changes the dot size depending on the number of values at a point, and creates a legends explaining the sizes.
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + geom_jitter() 
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + geom_count() 

# 4. What’s the default position adjustment for geom_boxplot()? 
#    Create a visualization of the mpg dataset that demonstrates it.
### The default position adjustment is "dodge2"
### This positioning does not move the geom vertically, but horizontally to avoid overlapping.
?mpg
?geom_boxplot
ggplot(data = mpg, aes(x = drv, y = hwy, colour = class)) +
  geom_boxplot()
ggplot(data = mpg, aes(x = drv, y = hwy, colour = class)) +
  geom_boxplot(position = "identity")