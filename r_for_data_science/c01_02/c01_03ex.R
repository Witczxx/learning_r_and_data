# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 01 - Exercise 03
# #CreatingPlots #geom_smooth() #Legends #Syntax

# 1. What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?
### I would use geom_line() or geom_smooth or 

# 2. Run this code in your head and predict what the output will look like. 
#    Then, run the code in R and check your predictions: 
#    ggplot( data = mpg, mapping = aes(x = displ, y = hwy, color = drv) ) + 
#     geom_point() + 
#     geom_smooth(se = FALSE)
### Prediction:
###   I am predicting that I am going to see 2 geoms in one viz. 
###   Since coordinates and dividing by color is set gloabally:
###   I predict that both geoms will be divided in the same way by color by the drv variable.
### Result:
###   I was not paying attention to se = T/F
###   se = T/F can show/remove the confidence interval around the smooth line graph.
###   I was also not predicting that the points will show all data and geom_smooth the average line.
?geom_smooth
ggplot( data = mpg, mapping = aes(x = displ, y = hwy, color = drv) ) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# 3. What does show.legend = FALSE do? 
# What happens if you remove it? 
# Why do you think I used it earlier in the chapter?
### show.legend = FALSE will remove the legends after using aesthetics like color = .
### if you remove it, the legend will appear, because it is the automatic preset.
### Earlier the legend not necessarry. 
### The focus earlier was on the code and illustration and not on the data.

# 4. What does the se argument to geom_smooth() do?
### I answered before:
### se = T/F can show/remove the confidence interval around the smooth line graph.

# 5. Will these two graphs look different? 
#    Why/why not? 
#    ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
#     geom_point() + geom_smooth() 
#    ggplot() + 
#     geom_point( data = mpg, mapping = aes(x = displ, y = hwy) ) + 
#     geom_smooth( data = mpg, mapping = aes(x = displ, y = hwy) )
### It is going to be exactly the same. 
### One plot saves the same information globally, the other locally.
### Because there are 2 geoms, locally the information must be written twice.
### That's why the code of the second graph is longer.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
 geom_point() + geom_smooth() 
ggplot() + 
 geom_point( data = mpg, mapping = aes(x = displ, y = hwy) ) + 
 geom_smooth( data = mpg, mapping = aes(x = displ, y = hwy) )
# 6. 6. Re-create the R code necessary to generate the following graphs.
### Adding Screenshot 
library(magick)
c01_ex03_pic01 <- image_read("screenshots/c01_ex03_pic01.png")
print(c01_ex03_pic01)
### Plot 01
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)
### Plot 02
### Remember: Mapping is a connection between variables in the data and visual properties.
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(mapping=aes(group = drv), se = FALSE)
### Plot 03
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() + 
  geom_smooth(se = FALSE)
### Plot 4
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = drv)) + 
  geom_smooth(se = FALSE)
### Plot 5
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) + 
  geom_smooth(se = FALSE, aes(linetype = drv))
### Plot 6
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(shape = 21, aes(fill = drv), color = "white", size = 3, stroke = 2)
