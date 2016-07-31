# GovHack 2016
# Date:
# Authors: Andrew Chiu
#          John Le


# server.R

###########################################################################
#                             SHINYSERVER                                 #
###########################################################################

shinyServer(function(input, output) {


# Shiny Outputs -----------------------------------------------------------
  ###########################################################################
  #                           SHINY OUTPUTS                                 #
  ###########################################################################
  
  output$Date <- renderPrint({
    date <- input$date
    paste(weekdays(date), month(date), sep = ",")
  })
  
  output$Patronage <- renderPrint({
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
    lm.fit <- lm(Daily_Patronage ~ rainfall_mm + maxTemp + minTemp + Month + Weekday, 
                 data = temp)
    summary(lm.fit)
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
