library(shiny)

# Define the overall UI
shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(    
    
    # Give the page a title
    titlePanel("Naravni prirast po občinah"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
        selectInput("kraj", "Občina:", 
                    choices = levels(tabela$kraj),
                    selected = "Ljubljana"),
        hr(),
        helpText("Izberi občino")
      ),
      
      # Create a spot for the barplot
      mainPanel(
        plotOutput("pprirast")  
      )
      
    )
  )
)