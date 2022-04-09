#' Launch the app
#'
#' Initiate an instance of the ScriptSearch app.
#'
#' Note: an alias function 'l' is also provided to speed up workflow (after making changes, load them with 'Ctrl+Shift+L',
#' then launch the app with 'l()')
#'
#' @return either run the app as a side effect or return a shiny.appobj object
#'
#' @importFrom shiny runApp shinyAppDir
#'
#' @export
launch_app <- function() {

  if (interactive()) {

    runApp(appDir = system.file("app",
                                package = "scriptSearch"))

  } else {

    shinyAppDir(appDir = system.file("app",
                                     package = "scriptSearch"))

  }

}

#' @export
l <- launch_app
