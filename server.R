library(shiny)
library(ggplot2)
library(leaflet)

shinyServer(function(input, output) {
  
  # buscamos un ractive cuando cambiemos los despegables y le demos al boton buscar

  misDatos <- reactiveValues(muestra = NULL)
  
  observeEvent(input$go, {
    
    misDatos$muestra <- dataset
    
    ## PASO 1. Filtrar por origen SI aplica
    if (input$despegableOrigen != "TODOS") {
      
      misDatos$muestra <- misDatos$muestra[misDatos$muestra$ORIGIN_AIRPORT == input$despegableOrigen, ]
    }
    ## PASO 2. Filtrar por destino SI aplica
    
    if (input$despegableDestino != "TODOS") {
      
      misDatos$muestra <- misDatos$muestra[misDatos$muestra$DESTINATION_AIRPORT == input$despegableDestino, ]
    }
    
    if (nrow(misDatos$muestra) == 0) {
      showNotification("No hay ningún dato con esos filtros")
    }
  })
  
  # primer histograma con frecuencias de retraso entre aeropuertos
  output$retraso <- renderPlot({
    
    if (nrow(misDatos$muestra) > 0) {
      # histograma
      hist(misDatos$muestra$ARRIVAL_DELAY,
           xlab = "Numero de Minutos",
           main = "Retraso de Aviones")
    }
  })
  
  # con renderText generamos la frase con la distancia entre aeropuertos
  output$distancia <- renderText({
    
    if (nrow(misDatos$muestra) > 0) {
      paste0("DISTANCIA(Millas): ", misDatos$muestra[1,6]) 
    }
  })
  
  # tercer histograma que genera el histograma con el tiempo de salida
  output$salida <- renderPlot({
    
    if (nrow(misDatos$muestra) > 0) {
      # histograma
      hist(misDatos$muestra$DEPARTURE_TIME,
           xlab = "Horas",
           main = "Hora de salida")
    }
  })
  
  
  #   origen <- reactiveValues(origin = NULL)
  #   
  #   destino <- reactiveValues(destin = NULL)
  #   
  #   observeEvent(input$go, {
  #     
  #     r <- dataset[dataset$LATITUDE.origen == input$despegableOrigen &
  #                    dataset$LONGITUDE.origen == input$despegableOrigen, ]
  #     origen$origin <- r[,c(13,14)]
  #   })
  #   
  #   observeEvent(input$go, {
  #     
  #     s <- dataset[dataset$LATITUDE.destino == input$despegableDestino &
  #                    dataset$LONGITUDE.destino == input$despegableDestino, ] 
  #     destino$destin <- s[, c(19,20)]
  #   })
  #   
  #   output$map <- renderLeaflet({
  #     
  #     req(origen$origin)
  #     req(destino$destin)
  #     
  #     leaflet() %>%
  #       addProviderTiles("Esri.WorldImagery") %>%
  #       setView(lat = 37.681918,
  #               lng = -97.368171,
  #               zoom = 4) %>%
  #       addMarkers(lat = origen$origin$LATITUDE.origen,
  #                  lng = origen$origin$LONGITUDE.origen) %>%
  #       # clusterOptions = markerClusterOptions(),
  #       # popup = as.character(dataset$AIRPORT))
  #       addMarkers(lat = destino$destin$LATITUDE.destino,
  #                  lng = destino$destin$LONGITUDE.destino)
  #     
  #     
  #   })
  #   
})