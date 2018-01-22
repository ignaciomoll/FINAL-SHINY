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