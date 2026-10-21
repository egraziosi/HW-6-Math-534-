
library(shiny)
library(ggplot2)
library(palmerpenguins)

ui <- fluidPage(
  
  titlePanel("Palmer Penguins"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput("species", "Select Species:",
                  choices = c("All", "Adelie", "Chinstrap", "Gentoo")),
      
      selectInput("sex", "Select Sex:",
                  choices = c("All", "male", "female")),
      
      selectInput("x", "X-axis:",
                  choices = c("bill_length_mm", "bill_depth_mm",
                              "flipper_length_mm", "body_mass_g")),
      
      selectInput("y", "Y-axis:",
                  choices = c("bill_length_mm", "bill_depth_mm",
                              "flipper_length_mm", "body_mass_g"),
                  selected = "body_mass_g")
      
    ),
    
    mainPanel(
      plotOutput("penguinPlot")
    )
    
  )
)

server <- function(input, output) {
  
  output$penguinPlot <- renderPlot({
    
    data <- penguins
    
    if (input$species != "All") {
      data <- data[data$species == input$species, ]
    }
    
    if (input$sex != "All") {
      data <- data[!is.na(data$sex) & data$sex == input$sex, ]
    }
    
    ggplot(data, aes(x = .data[[input$x]], y = .data[[input$y]])) +
      geom_point(aes(color = species), size = 3) +
      labs(x = input$x, y = input$y) +
      theme_minimal()
    
  })
  
}

shinyApp(ui, server)
