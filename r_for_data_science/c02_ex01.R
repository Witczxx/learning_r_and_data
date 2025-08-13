# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 02 - Exercise 01
# #

# 1. Why does this code not work? 
#    my_variable <-10 my_varıable 
#    #> Error in eval(expr, envir, enclos): 
#    #> object 'my_varıable' not found 
#    Look carefully! (This may seem like an exercise in pointlessness, 
#    but training your brain to notice even the tiniest difference will pay off when programming.) 
(my_variable <- 10)

# 2. Tweak each of the following R commands so that they run correctly: 
#    ggplot(dota = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) fliter(mpg, cyl = 8) filter(diamond, carat > 3) 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
filter(mpg, cyl == 8)
filter(diamonds, carat > 3)

# 3. Press Alt-Shift-K. What happens? 
#    How can you get to the same place using the menus?
### For Positron it is: cmd+shift+p -> "Open Keyboard Shortcuts"
### Probably you can get in a similar way to it at RStudio