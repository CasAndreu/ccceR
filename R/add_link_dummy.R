#' A function to add a Link dummy variable.
#'
#' This function allows you to add a dummy variable to 
#'    your dataset to indicate with messages contain links to URLs.
#'    If the message contains a link, link_dummy == 1. 
#' @param dataset The name of your dataset.
#' @param var_text A string indicating the name of the 
#'    variable in your dataset that conatins text messages.
#' @keywords links
#' @export
#' @examples
#' dataset_with_link_dummy <- add_link_dummy(orig_dataset, "Contents")
add_link_dummy <- function(dataset, var_text) {
  dataset$link_dummy <- 0
  texts <- dataset[ , names(dataset) == var_text]
  texts <- iconv(texts, "latin1", "ASCII", sub="")
  texts_link <- grepl(pattern = "http", x = texts)
  dataset$link_dummy[texts_link] <- 1
  print("A new variable has been added to the dataset: 'link_dummy'")
  return(dataset)
}