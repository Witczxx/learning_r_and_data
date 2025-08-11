### We had to set where we are first
getwd()
setwd("/Users/patrick/files/data_analytics/jing_calendar/r_files")

### install / load packges
library(maps)
library(mapproj)

### Continue
source("census-app/helpers.R")
counties <- readRDS("census-app/data/counties.rds")
percent_map(counties$white, "darkgreen", "% White")

