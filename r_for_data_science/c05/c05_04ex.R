# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Exercise 04
# #Covariations #CategoricalVariables #geom_count #geom_tile

# 1. How could you rescale the count dataset 
#    to more clearly show the distribution of cut within color, 
#    or color within cut? 
diamonds %>%
  count(color, cut) %>%
  group_by(color) %>%
  mutate(prop = n / sum(n)) %>%
  ggplot(mapping = aes(x = color, y = cut)) +
  geom_tile(mapping = aes(fill = prop))

# 2. Use geom_tile() together with dplyr 
#    to explore how average flight delays vary by destination and month of year. 
#    What makes the plot difficult to read? How could you improve it? 
flights %>%
  group_by(month, dest) %>%                                 # This gives us (month, dest) pairs
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  group_by(dest) %>%                                        # group all (month, dest) pairs by dest ..
  filter(n() == 12) %>%                                     # and only select those that have one entry per month 
  ungroup() %>%
  mutate(dest = reorder(dest, dep_delay)) %>%
  ggplot(aes(x = factor(month), y = dest, fill = dep_delay)) +
  geom_tile() +
  labs(x = "Month", y = "Destination", fill = "Departure Delay")

# 3. Why is it slightly better to use aes(x = color, y = cut) 
#    rather than aes(x = cut, y = color) in the previous example?
### It’s usually better to use the categorical variable with a larger number of categories or the longer labels on the y axis. 
### If at all possible, labels should be horizontal because that is easier to read.
diamonds %>%
  count(color, cut) %>%
  group_by(color) %>%
  mutate(prop = n / sum(n)) %>%
  ggplot(mapping = aes(x = color, y = cut)) +
  geom_tile(mapping = aes(fill = prop))
diamonds %>%
  count(color, cut) %>%
  group_by(color) %>%
  mutate(prop = n / sum(n)) %>%
  ggplot(mapping = aes(x = cut, y = color)) +
  geom_tile(mapping = aes(fill = prop))