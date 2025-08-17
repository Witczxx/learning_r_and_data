# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Exercise 01
# #ExploratoryDataAnalysis #EDA #Variable #Value #Observation #TabularData #Variation #VisualisingDistributions
# #Subgroups #UntypicalValues #Outliers

# 1. Explore the distribution of each of the x, y, and z variables in diamonds. 
#    What do you learn? 
#    Think about a diamond and how you might decide which dimension is the length, width, and depth. 
### We have some outliers, but using geom_smooth() clearly show that the values of x and y are quite equal in each observation.
### While the x/y and z are tending to have a proportion of z = x * 2/3, with a slight decrease at high weights. 
### There are a view outliers, which most likely are errors. For each parameter they are less than 5 observations with untypical values.
summary(select(diamonds, x, y, z))
ggplot(diamonds) + geom_histogram(mapping = aes(x = x), binwidth = 0.01)
ggplot(diamonds) + geom_histogram(mapping = aes(x = y), binwidth = 0.01)
ggplot(diamonds) + geom_histogram(mapping = aes(x = z), binwidth = 0.01)
# Removing outliers
filter(diamonds, x > 0, x < 10) %>% ggplot() + geom_histogram(mapping = aes(x = x), binwidth = 0.01) + scale_x_continuous(breaks = 1:10)
filter(diamonds, y > 0, y < 10) %>% ggplot() + geom_histogram(mapping = aes(x = y), binwidth = 0.01) + scale_x_continuous(breaks = 1:10)  
filter(diamonds, z > 0, z < 10) %>% ggplot() + geom_histogram(mapping = aes(x = z), binwidth = 0.01) + scale_x_continuous(breaks = 1:10)    
# Z is less than both x and y 
summarise(diamonds, mean(x > y), mean(x > z), mean(y > z))

# 2. Explore the distribution of price. 
#    Do you discover anything unusual or surprising? 
#   (Hint: carefully think about the bin width and make sure you try a wide range of values.) 
### In the lower pricing-area we have a very high count, wiht a peak at around 400 of around 1500 diamonds.
### From that moment on, the count is dropping with a rising price.
### There is a small increase in the area around 4000. People seem to prefer staying under thresholds like 500 and 5000. 
### From a price of 10000, the total count in a span of 1000 is under 1000, reaching its lowest point of 300 at 18000.
?diamonds
summary(select(diamonds, price))
ggplot(diamonds) + geom_histogram(mapping = aes(x = price), binwidth = 100)
filter(diamonds, price < 2500) |> 
ggplot() + geom_histogram(mapping = aes(x = price), binwidth = 50)
filter(diamonds, price > 10000) |> 
ggplot() + geom_histogram(mapping = aes(x = price), binwidth = 10)
diamonds |> 
  mutate(round_price = price %/% 1000) |> 
  group_by(round_price) |> 
  summarise(n = n())

# 3. How many diamonds are 0.99 carat? 
#    How many are 1 carat? 
#    What do you think is the cause of the difference? 
### There are only 23 diamonds with 0.99 carat, but 1558 diamonds with 1 carat
### It is easier to sell diamonds with 1 carat. Filter in online-shops or requests of customers.
View(filter(diamonds, between(carat, 0.99, 1)))
diamonds |> 
  filter(carat == 0.99 | carat == 1) |> 
  group_by(carat) |> 
  summarise(carat_count = n())

# 4. Compare and contrast coord_cartesian() versus xlim() or ylim() when zooming in on a histogram. 
#    What happens if you leave binwidth unset? 
#    What happens if you try and zoom so only half a bar shows?
### coord_cartesian() does really a visual zoom. The look of the data stays unchanged.
### xlim and ylim drop all values outside the limit as NA, influencing how the visualisation looks.
?coord_cartesian
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = price)) +
  coord_cartesian(xlim = c(100, 5000), ylim = c(0, 3000))
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = price)) +
  xlim(100, 5000) +
  ylim(0, 3000)
