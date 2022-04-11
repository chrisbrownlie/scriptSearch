#' Search module

#' Search module UI
#'
#' Defines the UI for the Search module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
search_ui <- function(id) {

  ns <- NS(id)

  shinyjs::hidden(
    tags$div(class = "search_page_container",
           id = "search_view",
             sidebarLayout(
               sidebarPanel = sidebarPanel(
                 width = 3,
                 textInput(ns("search_string"),
                           "Search for:",
                           placeholder = "e.g. 'look', 'blood'"),
                 p("To look for multiple words/spellings, use '|'. E.g. 'hello|hi'"),
                 hr(),
                 fluidRow(
                   column(
                     width = 4,
                     numericInput(ns("number_visible"),
                                  "No. of results to show:",
                                  value = 15)
                     ),
                   column(
                     width = 4,
                     offset = 2,
                     uiOutput(ns("aggregate_analysis"))
                   )
                   )
               ),
               
               mainPanel = mainPanel(
                 h4("Search results"),
                 uiOutput(ns("search_results"))
               )
             )
    ) #end search_page_container
  )

}

#' Search module server
#'
#' Defines the server logic for the Search module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
search_server <- function(id,
                          data) {

  moduleServer(
    id,
    function(input,
             output,
             session,
             appData = data) {

      # Alias the namespace function for ease of use
      ns <- session$ns
      
      # Sidebar - search input
      observe({
        req(input$search_string)
        appData$script$search(input$search_string)
      })
      
      # Sidebar - aggregations
      output$aggregate_analysis <- renderUI({
        search <- input$search_string
        p("Total number of matches: ", tags$strong(nrow(appData$script$search_results)))
      })
      
      # Main panel - search results
      output$search_results <- renderUI({
        req(!is.null(input$search_string))
        if (input$search_string=="") {
          h6("Try entering a search term on the left")
        } else if (length(appData$script$search_results)) {
          lapply(
            seq_len(min(nrow(appData$script$search_results), input$number_visible)),
            function(i) {
              tags$div(
                class = "search_result",
                h3(substr(appData$script$search_results$excerpt[i],
                          0,
                          appData$script$search_results$start_in_excerpt[i]-1),
                   tags$span(substr(appData$script$search_results$excerpt[i],
                                       appData$script$search_results$start_in_excerpt[i],
                                       appData$script$search_results$end_in_excerpt[i]),
                               class = "search_result_match",
                             .noWS = "outside"),
                   substr(appData$script$search_results$excerpt[i],
                          appData$script$search_results$end_in_excerpt[i]+1,
                          nchar(appData$script$search_results$excerpt[i])))
              )
            }
          )
        } else {
          h3("No matches")
        }
      })

    }
  )

}
