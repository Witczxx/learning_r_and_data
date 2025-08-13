# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 03 - Exercise 02
# #Facets #facet_wrap #facet_grid

# 1. What happens if you facet on a continuous variable?
### It will create thousands of facets!
data(mpg)
View(mpg)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = year, y = displ)) +
  facet_wrap(~displ)

# 2. What do the empty cells in a plot with facet_grid(drv ~ cyl) mean? 
#    How do they relate to this plot? 
#    ggplot(data = mpg) + geom_point(mapping = aes(x = drv, y = cyl))
### The x- and y-axis are both categorical values. They results show grouping dots. 
### That's why we have empty grids in the plot. At this grids there are no meeting values.
### e.g. there is no car with 5 cyl and 4 drv. 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl)) +
  facet_grid(drv ~cyl)

# 3. What plots does the following code make? 
#    What does . do? 
#    ggplot(data = mpg) + 
#     geom_point(mapping = aes(x = displ, y = hwy)) + 
#     facet_grid(drv ~ .) 
#    ggplot(data = mpg) + 
#     geom_point(mapping = aes(x = displ, y = hwy)) + 
#     facet_grid(. ~ cyl)
### The plots actualy create facet_wrap() functions 
### they inlcude the same information as before, but this time separated into 2 plots.
### The . leaves the part of the grid empty.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ .) 
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) + 
    facet_grid(. ~ cyl)
# 4. Take the first faceted plot in this section: 
#    ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(~ class, nrow = 2) 
#    What are the advantages to using faceting instead of the color aesthetic? What are the disadvantages? 
#    How might the balance change if you had a larger dataset?
### Faceting is very helpful for large amounts of information. Especially scatterplots can become too messy with too many dots.
### A disadvantage is the size of the viz. There are many small graphics. It might not be optimal for presenting in every case.
### Depending of the size of data, analysing the results might be easier with colors or with facets. 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# 5. Read ?facet_wrap. 
#    What does nrow do? 
#    What does ncol do? 
#    What other options control the layout of the individual panels?
#    Why doesn’t facet_grid() have nrow and ncol variables?
### nrow and ncol allows us to choose inot how many rows and columns the viz should be splited.
### We can use the as.table="" to chang the direction of where the highest facet is orienting to.
### with dir="" we can choose horizontal or vertical facet wrapping.
### drop= T/F can let us drop data, which is not being used in our facet_wrap. There's much more.
### facet_grid() doesn't have nrow and ncol, because it is simply using rows="" and cols="" .
?facet_wrap
?facet_grid

# 6. When using facet_grid() you should usually put the variable with more unique levels in the columns. Why?
### facet_grid() is only useful, when you have a lot of data. Because it is going to be divided into many grids.
### If the dataset is too small, it might not be the appropriate method for communicating data.