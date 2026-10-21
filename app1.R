library(shiny)

ui <- fluidPage(
  
  titlePanel("Five widgets"),
  
  sidebarLayout(
    sidebarPanel(
      
      # Widget 1: Select Distribution
      radioButtons("dist", "Select Distribution:",
                   choices = c("Normal", "Uniform", "Exponential")),
      
      # Widget 2: Sample Size
      sliderInput("n", "Sample Size:",
                  min = 100, max = 1000, value = 500),
      
      # Widget 3: Number of Bins
      numericInput("bins", "Number of Bins:",
                   value = 30, min = 5, max = 100),
      
      # Widget 4: Color
      selectInput("color", "Histogram Color:",
                  choices = c("blue", "red")),
      
      # Widget 5: Show Density Curve
      checkboxInput("density", "Show Density Curve",
                    value = FALSE)
    ),
    
    mainPanel(
      verbatimTextOutput("results")
    )
  )
)

server <- function(input, output) {
  
  output$results <- renderPrint({
    
    cat("Sample Size:", input$n, "\n")
    cat("Number of Bins:", input$bins, "\n")
    cat("Histogram Color:", input$color, "\n")
    cat("Selected Distribution:", input$dist, "\n")
    cat("Show Density Curve:", input$density, "\n")
    
  })
}

shinyApp(ui, server)




