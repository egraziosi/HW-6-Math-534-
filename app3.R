library(macleish)
library(ggplot2)
library(shiny)
library(shiny)
library(ggplot2)
library(macleish)

ui <- fluidPage(
  
  titlePanel("MacLeish Weather Data 2015"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput("station", "Select Weather Station:",
                  choices = c("Whately", "Orchard")),
      
      dateRangeInput("dates", "Select Date Range:",
                     start = "2015-01-01",
                     end = "2015-12-31",
                     min = "2015-01-01",
                     max = "2015-12-31"),
      
      selectInput("variable", "Select Weather Variable:",
                  choices = c("temperature",
                              "wind_speed",
                              "rel_humidity",
                              "pressure",
                              "rainfall"))
      
    ),
    
    mainPanel(
      plotOutput("weatherPlot")
    )
    
  )
)

server <- function(input, output) {
  
  output$weatherPlot <- renderPlot({
    
    if (input$station == "Whately") {
      data <- whately_2015
    } else {
      data <- orchard_2015
    }
    
    data <- data[
      as.Date(data$when) >= input$dates[1] &
        as.Date(data$when) <= input$dates[2], ]
    
    ggplot(data, aes(x = when, y = .data[[input$variable]])) +
      geom_line(color = "blue") +
      labs(
        title = paste(input$station, input$variable),
        x = "Date",
        y = input$variable
      ) +
      theme_minimal()
    
  })
  
}

shinyApp(ui, server)
