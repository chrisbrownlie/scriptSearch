#' Landing page module

#' Landing page module UI
#'
#' Defines the UI for the Landing page module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @import shiny
#'
#' @export
landing_ui <- function(id) {

  ns <- NS(id)

    tags$div(class = "landing_page_container",
             id = "landing_view",
             tags$div(class = "landing_page_content",
                      tags$div(
                        class = "landing_page_content-input",
                        fileInput(ns("script_upload"),
                                  "Select script: ",
                                  width = "100%")
                        ),
                        tags$div(
                          class = "landing_page_content-btn",
                          actionButton(ns("begin"),
                                       "Analyse")
                          )
                      )
    )

}

#' Landing page module server
#'
#' Defines the server logic for the Landing page module
#'
#' @param id to be used to namespace the module
#' @param data the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
landing_server <- function(id,
                           data) {

  moduleServer(
    id,
    function(input,
             output,
             session,
             appData = data) {

      # Alias the namespace function for ease of use
      ns <- session$ns
      
      observeEvent(input$begin, {
        
        if (!length(input$script_upload$datapath)) {
          alert_error("Please select a file to upload first")
        } else {
          # Create new script object
          appData[["script"]] <- Script$new(path = input$script_upload$datapath)
          
          # Hide landing page and show analysis page
          shinyjs::hide(id = "landing_view",
                        anim = TRUE,
                        animType = "fade",
                        time = 1,
                        asis = TRUE)
          shinyjs::show(id = "search_view",
                        anim = TRUE,
                        animType = "fade",
                        time = 1,
                        asis = TRUE)
        }
      })

    }
  )

}
