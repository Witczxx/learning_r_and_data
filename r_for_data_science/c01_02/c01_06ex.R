# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 03 - Exercise 06
# #coord_flip() #Pie-Chart #geom_abline() #coord_fixed() #labs() #coord_polar(theta = "y")

# Pie Chart Example
ggplot(data = diamonds) + 
  geom_bar( mapping = aes(x = cut, fill = cut), show.legend = FALSE, width = 1 ) + 
  theme(aspect.ratio = 1) + 
  labs(x = NULL, y = NULL) + 
  coord_flip() +
  coord_polar()

# 1. Turn a stacked bar chart into a pie chart using coord_polar(). 
?diamonds
ggplot(diamonds) +
  geom_bar(aes(x = factor(1), fill = color)) +
  coord_polar(theta = "y")

# 2. What does labs() do? Read the documentation. 
### It is responsible for adding texts to plots like titles, captions, and axis-names.
?labs()

# 3. What’s the difference between coord_quickmap() and coord_map()? 
### Both functions project the portion of earth(spherical) into a flat 2D plane
### coord_quickmap() does preserve straight liens.
### coord_map() does not preserve straight lines. It require considerable computation.
### But they are suspended by coord_sf()
?coord_quickmap()
?coord_map()

# 4. What does the following plot tell you about the relationship between city and highway mpg? 
#    Why is coord_fixed() important? What does geom_abline() do? 
#    ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + geom_point() + geom_abline() + coord_fixed()
### In general the graphic shows that cars from the dataset tend to do more miles on highways.
### The more miles a car does overall, the city- and highway miles become.
### It is fixed that both axis represent values in the same fixed way.
### geom_abline() creates a reference line for the plots, showing relation of x-axis and y-axis values.
### coord_fixed() doesn't allow R to automatically change, how the x-axes scales. It makes sure geom_abline() is 45 dregrees.
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point() + geom_abline() + coord_fixed()
?mpg
?coord_fixed()
?geom_abline()
