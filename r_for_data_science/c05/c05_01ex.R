# Exercises from the Book "R For Data Science" (Wickham, Grolemund)
# Chapter 05 - Notes 01
# #ExploratoryDataAnalysis #EDA #Variable #Value #Observation #TabularData #Variation #VisualisingDistributions
# #Subgroups #UntypicalValues #Outliers

library(tidyverse)
data(diamonds)

# EDA = Exploratory Data Analysis
# decsribed as an iterative cycle

# Includes following steps:
# 1. Generate questions about your data. 
# 2. Search for answers by visualizing, transforming, and modeling your data. 
# 3. Use what you learn to refine your questions and/or generate new questions.

# Two major types of questions (loosely said):
# 1. What type of variation occurs within my variables? 
# 2. What type of covariation occurs between my variables?

# Definitions
# A variable is a quantity, quality, or property that you can meas‐ ure.
# A value is the state of a variable when you measure it. 
#   (The value of a variable may change from measurement to measurement)
# An observation (st data point), or a case, is a set of measurements made under similar conditions
# Tabular data is a set of values, each associated with a variable and an observation.

# Variation
# Variation is the tendency of the values of a variable to change from measurement to measurement.
# Categorical variables can also vary if you measure across different subjects.
# The best way to understand that pattern is to visualize the distribution of variables’ values.

# Visualising Distributions
# How you visualise depends on whether the variable is categorical or continuous.
# Distribution of a categorical variable (finite), use a bar chart.
# Distribution of a continuous variable (infinite), use a histogram.
#   Overlay multiple histograms -> use geom_freqpoly() instead of geom_histogram().
#   Instead of displaying bars, uses lines. It is easier to understand.

# Typical Values
# To turn this information into useful questions, look for anything unexpected:
#   Which values are the most common? Why? 
#   Which values are rare? Why? 
#   Does that match your expectations? 
#   Can you see any unusual patterns? 
#   What might explain them?

# Subgroups
# In general, clusters of similar values suggest that subgroups exist in your data.
# To understand subgroups, ask:
#   How are the observations within each cluster similar to each other? 
#   How are the observations in separate clusters different from each other? 
#   How can you explain or describe the clusters? 
#   Why might the appearance of clusters be misleading?
# Many of the preceding questions will prompt you to explore a relationship between variables,

# Untypical Values
# Unusual Values Outliers are observations that are unusual; data points that don’t seem to fit the pattern. 
# Sometimes outliers are data entry errors; other times outliers suggest important new science.
# To make it easy to see the unusual values, we need to zoom in to small values of the y-axis with cord_cartesian()
# Let's look at an example: 
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) + 
  coord_cartesian(ylim = c(0, 50)) # xlim= argument also exists, if we need to zoom into the x-axis
# Lets filter the outliers to take a closer look:
unusual <-diamonds %>% filter(y < 3 | y > 20) %>% arrange(y)
# We know that diamonds can’t have a width of 0mm, so these values must be incorrect. 
# We might also suspect that meas‐ urements of 32mm and 59mm are implausible

# What to do with outliers
# If they have minimal effect on the results, 
#   and you can’t figure out why they’re there, 
#   it’s reasonable to replace them with missing values and move on.
# If they have a substantial effect on your results, 
#   you shouldn’t drop them without justification. 
#   You’ll need to figure out what caused them (e.g., a data entry error) 
#   and disclose that you removed them in your write-up.