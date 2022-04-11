#' Server function for the scriptSearch app
app_server <- function(input, output, session) {
  
  # Create a reactiveValues object to act as the app's data store. This will
  # be passed to all modules. It is a reactiveValues object so any changes will
  # instantly be visible to all modules. It has the same uses as the session$userData
  # environment, but this method is preferred as it is more explicit.
  appData <- reactiveValues(visible = "landing")
  
  # Manage visible view
  observeEvent(appData$visible, {
    if (appData$visible == "landing") {
      shinyjs::show(id = "landing_view",
                    anim = TRUE,
                    animType = "fade",
                    time = 1)
      shinyjs::hide(id = "search_view",
                    anim = TRUE,
                    animType = "fade",
                    time = 0.5)
    } else if (appData$visible == "search") {
      shinyjs::hide(id = "landing_view",
                    anim = TRUE,
                    animType = "fade",
                    time = 0.5)
      shinyjs::show(id = "search_view",
                    anim = TRUE,
                    animType = "fade",
                    time = 1)
    }
  })
  
  # Call the module server for each view
  landing_server("landing",
                 data = appData)
  
  search_server("search",
                 data = appData)
}
