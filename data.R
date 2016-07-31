# GovHack 2016
# Date: 
# Authors: Andrew Chiu
#          John Le


# data.R


# Load Data ---------------------------------------------------------------
###########################################################################
#                             LOAD DATA                                   #
###########################################################################

station_daily <- read.csv("Data/Station - Daily.csv")   # all stations, daily

weather <- read.csv("Data/Weather/weather.csv")         # Weather data, daily
names(weather)[1] <- "Date"

