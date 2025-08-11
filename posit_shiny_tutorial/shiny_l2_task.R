install.packages("shiny")
library(shiny)

ui <- page_sidebar(
  title = "My Shiny App",
  sidebar = 
    "Shiny is available on CRAN, so you can install it in the usual way 
  from your R console: install.packages(\"shiny\")",
  card(
    card_header("Introducing Shiny"),
    "Shiny is a package from Posit that makes it incredibly easy to build
    interactive web applications with R. For an introduction and live 
    examples, visit the Shiny homepage (https://www.shiny.posit.co)",
    card_image("www/shiny.png", height="750px", width="750px"),
    card_footer("Shiny is a product of Posit.")
  )
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)