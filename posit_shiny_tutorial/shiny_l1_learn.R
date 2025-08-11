install.packages("shiny")
install.packages("bslib")
library(shiny)
library(bslib)
runExample("01_hello")

ui <- page_sidebar(
  title = "Hello World!",
  sidebar = sidebar(
    sliderInput(
      inputId = "bins",
      label = "Number of bins:",
      min = 5,
      max = 50,
      value = 30
    )
  ),
  plotOutput(outputId = "distPlot")
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = "#007bc2", border = "orange",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")
  })
}

shinyApp(ui = ui, server = server)
### Buggy
runApp("shiny_get_started")

### Examples
runExample("01_hello")      # a histogram
runExample("02_text")       # tables and data frames
runExample("03_reactivity") # a reactive expression
runExample("04_mpg")        # global variables
runExample("05_sliders")    # slider bars
runExample("06_tabsets")    # tabbed panels
runExample("07_widgets")    # help text and submit buttons
runExample("08_html")       # Shiny app built from HTML
runExample("09_upload")     # file upload wizard
runExample("10_download")   # file download wizard
runExample("11_timer")      # an automated timer

