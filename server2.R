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
    input$date
  })
   
  longitude <- 144.952944748845
  latitude <- 
  TOT <- 10000
  output$map1 <- renderLeaflet({
    leaflet() %>%
    addTiles() %>%
    addCircleMarkers(
                    lng=144.952944748845, # Longitude coordinates
                    lat=-37.8181633057171, # Latitude coordinates
                    radius=20, # Total count
                    stroke=FALSE, # Circle stroke
                    fillOpacity=0.5, # Circle Fill Opacity
                     
                    ) %>%
    addCircleMarkers(
            lng=144.956318211113, # Longitude coordinates
            lat=-37.8122356514626, # Latitude coordinates
            radius=30, # Total count
            stroke=FALSE, # Circle stroke
            fillOpacity=0.5, # Circle Fill Opacity
            
    )
  
    
  })
  
}) # End of shinyServer
