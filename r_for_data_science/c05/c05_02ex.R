# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Exercise 02
# #UnusualValues #MissingValues #ChangingValues

library(nycflights13)
data(flights)

# 1. What happens to missing values in a histogram? 
#    What happens to missing values in a bar chart? 
#    Why is there a difference?
### In the geom_bar() function, NA is treated as another category.
### The x aesthetic in geom_bar() requires a discrete (categorical) variable, and missing values act like another category.
diamonds %>%
  mutate(cut = if_else(runif(n()) < 0.1, NA_character_, as.character(cut))) %>%
  ggplot() +
  geom_bar(mapping = aes(x = cut))
# In a histogram, the x aesthetic variable needs to be numeric.
# Since the numeric value of the NA observations is unknown, they cannot be placed in a particular bin, and are dropped.
diamonds |> 
  mutate(y = ifelse(y < 3 | y > 20, NA, y)) |> 
  ggplot(aes(x = y)) +
    geom_histogram()

# 2. What does na.rm = TRUE do in mean() and sum()?
### It drops the values from the grouping variable having a NA.
### Otherway the results will be NA - because R does not know the value to calculate everything
mean(c(0, 1, 2, NA), na.rm = TRUE)
mean(c(0, 1, 2, NA), na.rm = FALSE)
sum(c(0, 1, 2, NA), na.rm = TRUE)
sum(c(0, 1, 2, NA), na.rm = FALSE)