# copiamos el siguiente link en el buscador
# https://www.kaggle.com/usdot/flight-delays/data

# de la página resultante nos descargamos los dos siguientes ficheros:

# - airports.csv
# - flights.csv

# Por último corremos el código de abajo para obtener nuestro dataaset final

vuelos <- read.csv("flights.csv")
vuelos <- vuelos[,-c(26,27,28,29,30,31)]

aeropuertos <- read.csv("airports.csv")

# vamos a unificar aeropuertos y vuelos
re <- merge(vuelos, aeropuertos, by.x = "ORIGIN_AIRPORT", by.y = "IATA_CODE", all.x = T)
dataset <- merge(re, aeropuertos, by.x = "DESTINATION_AIRPORT", by.y = "IATA_CODE", suffixes=c(".origen", ".destino"))

dataset <- dataset[,c(1,2,10,11,12,18,21,22,23,26,27,28,30,31,32,33,4,35,36,37)]
dataset <- na.omit(dataset)
