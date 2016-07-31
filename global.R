# GovHack 2016
# Date: 
# Authors: Andrew Chiu
#          John Le
#          Alex Levashov
#          Dylan Sanusi-Goh
#          Keith Chong

# global.R


# Packages ----------------------------------------------------------------
###########################################################################
#                       LOAD PACKAGES AND MODULES                         #
###########################################################################

library(shiny)
library(shinydashboard)
library(dplyr)            # Data manipulation
library(ggplot2)          # Visualisations
library(plotly)           # Visualisations - interactive
library(leaflet)          # Map
library(Rforecastio)      # forecast weather data
library(lubridate)        # Manipulate date variables
#library(googleVis)        # Interactive graphics
library(plotly)           # Another interactive graphics library
library(weatherr)      # Get weather forecast data

# Load Data ---------------------------------------------------------------
###########################################################################
#                             LOAD DATA                                   #
###########################################################################

station_daily <- read.csv("Data/Station - Daily.csv")   # all stations, daily

weather <- read.csv("Data/Weather/weather.csv")         # Weather data, daily
names(weather)[1] <- "Date"

weatherForecast <- locationforecast(lat = -37.8136,
                                    lon = 144.9631) %>%
                   mutate(Date = as.Date(time))