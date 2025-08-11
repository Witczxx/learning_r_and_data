install.packages("shiny")
install.packages("bslib")
install.packages("bsicons")
library(shiny)
library(bslib)
library(bsicons)

# Sidebar UI
ui <- page_sidebar(
  title = "Hello World!",
  sidebar = sidebar("Sidebar"),
  value_box(
    title = "Hello Value_Box",
    value = 100,
    showcase = bsicons::bs_icon("bar-chart"),
    theme = "teal"
  ),
  card(
    card_header("Card Header"),
    "Card Body"
  )
)

# Define server logic ----
server <- function(input, output) {
  
}

# Run the app ----
shinyApp(ui = ui, server = server)

