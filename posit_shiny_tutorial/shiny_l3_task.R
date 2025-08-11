install.packages("shiny")
library(shiny)
install.packages("bslib")
library(bslib)


ui <- page_sidebar(
  title = "censusVis",
  sidebar = sidebar(
    helpText(
      "Create demographic maps with information from the 2010 US Census."
    ),
     selectInput(
       "selectInput",
       label = "Choose a variable to display",
       c("Percent White", "Percent Black", "Percent Hispanic", "Percent Asian")
       ),
     sliderInput(
       "sliderInput",
        label = "Range of Interest",
        min = 0,
        max = 100,
        value = c(0, 100)
      )
    )
  )


server <- function(input, output) {}


shinyApp(ui = ui, server = server)