#' Convert a word document script into a dataframe
#' 
#' Take in the path to a word document and transform the script into a data
#' frame where each row is a line with a speaker.
#' 
#' @param path the path to the script
#' 
#' @import dplyr
#' 
#' @return a single dataframe with one row per line
import_script <- function(path) {
  
  raw_text <- readtext::readtext(path)$text %>%
    stringr::str_split(pattern = "\n",
                       simplify = TRUE) %>%
    as.vector()
  
  data.frame(
    line_number = 1:length(raw_text),
    text = raw_text,
    stringsAsFactors = FALSE,
    row.names = NULL
  )
}