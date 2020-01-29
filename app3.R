# Pound sign in front of any non code in RScripts

# My first app example! 
# L-Train


# Attach packages
library(here)
library(shiny)
library(tidyverse)

# Get penguins.csv data
penguins <- read_csv(here("session_4_ex_1", "penguins.csv"))


# Creat 'ui' = "User Interface"

ui <- fluidPage(
  titlePanel("This is  my app title"), 
  sidebarLayout(
    sidebarPanel("Here are my widgets!", 
                 radioButtons(inputId = "species",
                              label = "Choose penguin species:",
                              choices = c("Adelie", "Gentoo", "Awesome Chinstrap Penguins" = "Chinstrap")),
                 selectInput(inputId = "pt_color",
                             label = "Select a point color!",
                             choices = c("Favorite RED!!!" = "red", 
                                         "Pretty purple" = "purple",
                                         "ORAAAAANGE!" = "orange"))),
    mainPanel("Here is my graph!", 
              plotOutput(outputId = "penguin_plot"))
  )
)

# Create a 'server' (takes inputs (user selected) and sends back outputs (which user can see)

server <- function(input, output) {
  
  # Created a reative data frame: 
  penguin_select <- reactive({
    penguins %>% 
      filter(sp_short == input$species)
  })
  
  output$penguin_plot <- renderPlot({
    
    ggplot(data = penguin_select(), aes(x = flipper_length_mm, y = body_mass_g)) +
      geom_point(color = input$pt_color)
    
  })
  
}

# Let R know that you want to combine the ui & server into an app:

shinyApp(ui = ui, server = server)

