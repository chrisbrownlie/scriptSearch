#' @title Script R6 class
#' 
#' @name Script
#' 
#' @description R6 class for storing information about a script
#' and methods for analysing the text
#' 
#' @return returns an R6 object of class Script
#' 
#' @import cli
#' @rawNamespace import(crayon, except = c("num_ansi_colors"))
#' @import tidyr
#' 
#' @export
Script <- R6::R6Class(
  classname = "Script",
  
  # Public
  public = list(
    # Public - fields -----
    #' @field path The file path to the script
    path = NULL,
    
    #' @field name The title of the script/play
    name = NULL,
    
    #' @field raw_text The raw, unaltered text extracted from the file
    raw_text = NULL,
    
    #' @field text_df The raw text, formatted as a dataframe with one
    #' row per line
    text_df = NULL,
    
    #' @field search_results A subset of text_df, filtered using
    #' the $search() method
    search_results = NULL,
    
    # Public - methods -----
    #' @description Initialise a new Script object
    #' 
    #' @param path The file path to the script
    #' @param title (optional) the title of the script
    #' 
    #' @return an R6 object with class Script
    initialize = function(path,
                          title) {
      
      self$raw_text <- readtext::readtext(path)$text
      
      self$text_df <- import_script(path)
      
      if (!missing(title)) self$name <- title
    },
    
    #' @description Print info about script
    print = function() {
      cat_rule(cyan("Script object"))
      cat_line()
      cat_boxx(label = ifelse(length(self$name),
                               self$name,
                               "Unnamed Script"))
    },
    
    
    #' @description Search for a string and return lines that match the string
    #' 
    #' @param string the string to search for
    #' 
    #' @return a subset of the text_df dataframe with matching lines
    search = function(string) {
      initial_results <- self$text_df %>%
        filter(grepl(pattern = string,
                     x = text,
                     ignore.case = TRUE))
      if (nrow(initial_results)) {
        
      self$search_results <- initial_results %>%
        rowwise() %>%
        mutate(position = list(as.vector(gregexec(pattern = string,
                                  text = text,
                                  ignore.case = TRUE)[[1]]))) %>%
        tidyr::unnest(position) %>%
        rowwise() %>%
        mutate(excerpt_start = max(position-30, 1),
               excerpt_finish = position+30,
               excerpt = substr(text,
                                excerpt_start,
                                excerpt_finish),
               start_in_excerpt = ifelse(position-30<1,
                                         position,
                                         31),
               end_in_excerpt = start_in_excerpt + nchar(string) -1)
      } else {
        self$search_results <- NULL
      }
    }
  ),
  
  # Private fields and methods
  private = list()
)