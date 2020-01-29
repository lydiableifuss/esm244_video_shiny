## Second example from video!!

library(shiny)
library(tidyverse)
library(shinythemes)
library(here)

ui <- navbarPage("Allison's navigation bar!",
                 tabPanel("First tab!", 
                          h1("Some giant text"),
                          p("Here's some regular text..."),
                          plotOutput(outputId = "diamond_plot")),
                 tabPanel("Second tab!",
                          sidebarLayout(
                            sidebarPanel("Some text!",
                                         checkboxGroupInput(inputId = "diamondclarity",
                                                            "Choose some!",
                                                            choices = c(levels(diamonds$clarity)))),
                            mainPanel("Main panel text.")
                          ))
                 )

server <- function(input, output) {
  
  output$diamond_plot <- renderPlot({
    
    ggplot(data = diamonds, aes(x = carat, y = price)) +
      geom_point(aes(color = clarity))
    
  })
  
}

shinyApp(ui = ui, server = server)