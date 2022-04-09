#' UI for the advancedShiny app
app_ui <- function() {
  
  # UI definition
  ui <- fluidPage(
    tags$head(
      # Include custom CSS
      tags$link(href = "styling.css", rel = "stylesheet", type = "text/css"),
    ),
    
    shinyjs::useShinyjs(),
    
    # Main page container
    tags$div(
      class = "page_container",
      
      # Begin header
      tags$div(
        class = "page_header",
        tags$div(
          class = "header_main",
          tags$a(
            href =  "https://chrisbrownlie.com",
            h3("chris", tags$strong("brownlie", .noWS = "outside"), ".com", icon("user-ninja"))
          )
        ),
      
        tags$div(
          class = "header_secondary",
          tags$a(
            href =  "#",
            h3("scriptSearch", icon("scroll"))
          )
        )
      ), # end header
      
      # Landing page UI
      landing_ui("landing"),
      
      # Search view UI
      search_ui("search")
      
    ) # end page_container div
  ) # end fluidPage
  
  # Return the ui
  ui
}