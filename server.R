# GovHack 2016
# Date: 
# Authors: Andrew Chiu
#          John Le
#          Alex Levashov
#          Dylan Sanusi-Goh
#          Keith Chong


# server.R

###########################################################################
#                             SHINYSERVER                                 #
###########################################################################

shinyServer(function(input, output) {


# Shiny Outputs -----------------------------------------------------------
  ###########################################################################
  #                           SHINY OUTPUTS                                 #
  ###########################################################################

  output$tempHistogram <- renderPlotly({
    p1 <- plot_ly(data = weather,
                 x = minTemp,
                 opacity = 0.6,
                 type = "histogram") %>%
      add_trace(data = weather,
                x = maxTemp,
                opacity = 0.6,
                type = "histogram") %>%
      layout(barmode = "overlay")
    p1
  })
    
  output$patronage <- renderPlotly({
    
    southern <- filter(station_daily, Station == "Southern Cross") %>%
                mutate(Date = ymd(Date),
                       Year = year(Date)) %>%
                filter(Year == "2013")

    p2 <- plot_ly(data = southern,
                  x = Date,
                  y = Daily_Patronage)
    p2
  })
  
  output$weather <- renderPlotly({
    weatherPlot <- weather %>%
                   mutate(Date = ymd(Date),
                          Year= year(Date)) %>%
                   filter(Year == "2013")
    p3 <- plot_ly(data = weatherPlot,
                  x = Date,
                  y = minTemp) %>%
          add_trace(data = weatherPlot,
                    x = Date,
                    y = maxTemp)
    p3
  })
  
  output$linearModel <- renderPrint({
    linearMod <- filter(station_daily, Station == "Southern Cross")   # Subset data to selected station
    
    linearMod <- left_join(linearMod, weather, by = "Date")
    linearMod$Date <- ymd(linearMod$Date)
    linearMod <- mutate(linearMod,
                        Weekday = weekdays(linearMod$Date),
                        Month = month(linearMod$Date),
                        Quarter = quarters(linearMod$Date))
    
    ## Linear model for station
    lm.fit <- lm(Daily_Patronage ~ maxTemp + minTemp + Month + Weekday, 
                 data = linearMod)
    summary(lm.fit)
  })
  
  output$Date <- renderPrint({
    date <- as.Date(input$date)
    
    temp <- filter(weatherForecast, Date == date)
    
    minTemp <- min(temp$temperature)
    
    maxTemp <- max(temp$temperature)
    
    weekday <- weekdays(date)
    
    month <- month(date)
    
    newData <- data.frame(minTemp = minTemp,
                       maxTemp = maxTemp,
                       Month = month,
                       Weekday = weekday)
    
    paste("Minimum temperature:", minTemp, "Maximum temperature:", maxTemp, "Weekday:", weekday, sep = " ")
  })
  
  output$Patronage <- renderPrint({
    
    date <- as.Date(input$date)
    
    temp <- filter(weatherForecast, Date == date)
    
    minTemp <- min(temp$temperature)
    
    maxTemp <- max(temp$temperature)
    
    weekday <- weekdays(date)
    
    month <- month(date)
    
    newData <- data.frame(minTemp = minTemp,
                          maxTemp = maxTemp,
                          Month = month,
                          Weekday = weekday)
    
    station <- as.character(input$station)    # User selects station
    #station
    temp <- filter(station_daily, Station == station)   # Subset data to selected station
    
    temp <- left_join(temp, weather, by = "Date")
    temp$Date <- ymd(temp$Date)
    temp <- mutate(temp,
                   Weekday = weekdays(temp$Date),
                   Month = month(temp$Date),
                   Quarter = quarters(temp$Date))
    
    ## Linear model for station
    lm.fit <- lm(Daily_Patronage ~ maxTemp + minTemp + Month + Weekday, 
                 data = temp)
    #summary(lm.fit)
    pred <- predict(lm.fit, newdata = newData)
    
    paste("Predicted patronage:", pred, sep = " ")
    
  })
  
  output$map1 <- renderLeaflet({
    leaflet() %>%
    addTiles() %>%
    addMarkers(lng = 144.9631, lat = -37.8136) %>%
    addCircleMarkers(lng=144.952944748845, # Longitude coordinates
                     lat=-37.8181633057171, # Latitude coordinates
                     radius=20, # Total count
                     stroke=FALSE, # Circle stroke
                     fillOpacity=0.5) %>%   # Circle Fill Opacity
                     
    addCircleMarkers(lng=144.956318211113, # Longitude coordinates
                     lat=-37.8122356514626, # Latitude coordinates
                     radius=30, # Total count
                     stroke=FALSE, # Circle stroke
                     fillOpacity=0.5) # Circle Fill Opacity)
  })
  
}) # End of shinyServer
