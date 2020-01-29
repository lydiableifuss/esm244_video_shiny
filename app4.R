## Second example from video!!

library(shiny)
library(tidyverse)
library(shinythemes)
library(here)

ui <- navbarPage("Allison's navigation bar!",
                 theme = shinytheme("cyborg"),
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
                            mainPanel("Main panel text.",
                                      plotOutput(outputId = "diamond_plot_2"))
                          ))
                 )



server <- function(input, output) {
  
  diamond_clarity <- reactive({
    diamonds %>% 
      filter(clarity %in% input$diamondclarity)
  })
  
  output$diamond_plot <- renderPlot({
    ggplot(data = diamonds, aes(x = carat, y = price)) +
      geom_point(aes(color = clarity))
  })
  
  
  output$diamond_plot_2 <- renderPlot({
    ggplot(data = diamond_clarity(), aes(x = clarity, y = price)) +
      geom_violin(aes(fill = clarity))
  })
  
  
}


shinyApp(ui = ui, server = server)

