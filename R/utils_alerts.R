#' Error alert
#' 
#' Thin wrapper around shinyalert for showing error alerts
#' 
#' @param text the label to show in the alert
#' 
#' @return a shinyalert
alert_error <- function(text = "") {
  shinyalert::shinyalert(
    title = "Error",
    text = text,
    showCancelButton = FALSE,
    showConfirmButton = TRUE,
    confirmButtonText = "OK",
    type = "error"
  )
}