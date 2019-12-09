library(shiny)
library(tidyverse)

data <- tibble(x=rep(1:100, times=3), 
               value=c(cumsum(rnorm(100)), cumsum(runif(100)), cumsum(rexp(100))), 
               type=rep(c("normal", "uniform", "exponential"), each=100))




setwd('/Users/maxryoo/Documents/Spring 2019/STAT4310/groupwork4:2')
data <- read_csv("personality_IDKs.csv")
unique(data$Income)
ui <- fluidPage(
  titlePanel("Random Walks"),
  sidebarLayout(
    sidebarPanel(
      # Select type of trend to plot
      selectInput(inputId = "type", label = strong("Underlying Distribution"),
                  choices = c("normal", "uniform", "exponential"),
                  selected = "normal"),
      
      
      # permute?
      checkboxInput(inputId = "permute", label = strong("Permute data"), value = FALSE)
      
    ),
    
    # Output: Description, lineplot, and reference
    mainPanel(
      plotOutput(outputId = "lineplot", height = "300px")
    )
  )
)



# Define server function
server <- function(input, output) {
  
  # Subset data
  selected_walk <- reactive({
    if(input$permute){
      tmpdata <- data %>% filter(type==input$type)
      tmpdata$value <- sample(tmpdata$value)
      tmpdata
    }else{
      data %>%
        filter(type==input$type
        )
    }
  })
  
  
  # Create scatterplot object the plotOutput function is expecting
  output$lineplot <- renderPlot({
    ggplot(selected_walk(), aes(x, value)) + geom_line()
  })
}

# Create Shiny object
shinyApp(ui = ui, server = server)
