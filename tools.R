crearListaAeropuertos <- function() {
  lista <- list("-- TODOS --"="TODOS")
  
  for (i in 1:nrow(aeropuertos)) {
    aeropuerto <- as.character(aeropuertos[i, "AIRPORT"])
    iata <- as.character(aeropuertos[i, "IATA_CODE"])
    lista[aeropuerto] <- iata 
  }
  
  lista
}
crearListaAeropuertos()
####################################
misDatos <- reactiveValues(muestra = NULL)

observeEvent(input$go, {
  
  misDatos$muestra <- dataset
  
  ## PASO 1. Filtrar por origen SI aplica
  # browser()
  if ("input$despegabelOrigen" != "TODOS") {
    
    misDatos$muestra <- misDatos$muestra[misDatos$muestra$ORIGIN_AIRPORT == input$despegableOrigen, ]
  }
  ## PASO 2. Filtrar por destino SI aplica
  
  if ("input$despegableDestino" != "TODOS") {
    
    misDatos$muestra <- misDatos$muestra[misDatos$muestra$DESTINATION_AIRPORT == input$despegableDestino, ]
  }
  
  if (nrow(misDatos$muestra) == 0) {
    showNotification("No hay ningún dato con esos filtros")
  }
})