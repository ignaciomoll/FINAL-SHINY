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
  output$retraso <- renderUI({
    
    req(misDatos$muestra)

      datos <- misDatos$muestra$ARRIVAL_DELAY
      if (min(datos) == max(datos)) {
        p("Tiempo Retrasdo(MINUTOS):", as.numeric(as.character(min(datos))))
      } else {
        output$graficaDelay <- renderPlot({hist(misDatos$muestra$ARRIVAL_DELAY,
                                                xlab = "Numero de Minutos",
                                                main = "Retraso Aviones",
                                                xlim = range(1:500))
        })
        plotOutput("graficaDelay")
      }
  })
  

  output$distancia <- renderUI({
    
    # usar req para que no arranque si no hay muestra aun
    req(misDatos$muestra)
   
    datos <- misDatos$muestra$DISTANCE
    if (min(datos) == max(datos)) {
      p("Distancia(MILLAS):", as.character(min(datos)))
    } else {
      output$graficaDistancia <- renderPlot({hist(misDatos$muestra$DISTANCE,
                                                  xlab = "Millas",
                                                  main = "Distancia")
      })
      plotOutput("graficaDistancia")
    }
  })
  
  # tercer histograma que genera el histograma con el tiempo de salida
  output$salida <- renderUI({
    
    req(misDatos$muestra)
    
    datos <- misDatos$muestra$DEPARTURE_TIME
    if (min(datos) == max(datos)) {
      p("Hora de Salida(HORAS):", as.character(min(datos)))
    } else {
      output$graficaSalida <- renderPlot({hist(misDatos$muestra$DEPARTURE_TIME,
                                               xlab = "Horas",
                                               main = "Hora de salida")
      })
      plotOutput("graficaSalida")
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
  output$map <- renderLeaflet({
    
    req(misDatos$muestra)
    
    leaflet() %>%
      addProviderTiles("Esri.WorldImagery") %>%
      setView(lat = 37.681918,
              lng = -97.368171,
              zoom = 4) %>%
      addMarkers(lat = misDatos$muestra$LATITUDE.origen,
                 lng = misDatos$muestra$LONGITUDE.origen) %>%
      # clusterOptions = markerClusterOptions(),
      # popup = as.character(dataset$AIRPORT))
      addMarkers(lat = misDatos$muestra$LATITUDE.destino,
                 lng = misDatos$muestra$LONGITUDE.destino)
    
    
  })
  
})