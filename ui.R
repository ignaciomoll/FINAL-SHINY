library(shiny)
library(leaflet)

source("tools.R")

choicesAeropuertos <- crearListaAeropuertos()

ui <- shinyUI(fluidPage(
  
  titlePanel("Buscador de Vuelos"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("despegableOrigen", 
                  label = "ORIGEN",
                  choices = choicesAeropuertos,
                  selected = "TODOS"),
      selectInput("despegableDestino",
                  label = "DESTINO",
                  choices = choicesAeropuertos,
                  selected = "TODOS"),
      actionButton("go", "BUSCAR")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("map"),
      verbatimTextOutput("distancia") ,
      plotOutput("retraso"),
      plotOutput("salida")
    )
  )
)
)