library(shiny)
library(leaflet)

source("tools.R")

choicesAeropuertos <- crearListaAeropuertos()

ui <- shinyUI(fluidPage(
  
  titlePanel("Buscador de Vuelos"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      helpText("Selecciona uno de los aeropuertos del despegable como origen, la opción --TODOS-- será como
               si seleccionaras todos los aeropuertos"),
      selectInput("despegableOrigen", 
                  label = "ORIGEN",
                  choices = choicesAeropuertos,
                  selected = "TODOS"),
      br(),
      helpText("Selecciona uno de los aeropuertos del despegable como destino, si eliges --TODOS-- 
               será como si seleccionaras todos los destinos podibles"),
      selectInput("despegableDestino",
                  label = "DESTINO",
                  choices = choicesAeropuertos,
                  selected = "TODOS"),
      br(),
      helpText("Púlsa el botón BUSCAR para comenzar la búsqueda"),
      actionButton("go", "BUSCAR")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("map"),
      uiOutput("distancia") ,
      uiOutput("retraso"),
      uiOutput("salida")
    )
  )
)
)