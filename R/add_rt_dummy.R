#' @title
#' A function to add a RT dummy variable.
#'
#' This function allows you to add a dummy variable to 
#'    your dataset to indicate with messages are RTs.
#'    If the message is a retweet, RT == 1. 
#' @param dataset The name of your dataset.
#' @param var_text A string indicating the name of the 
#'    variable in your dataset that conatins text messages.
#' @keywords retweet
#' @export
#' @examples  \dontrun{
#' dataset_with_rt_dummy <- add_rt_dummy(orig_dataset, "Contents")
#' }
add_rt_dummy <- function(dataset, var_text) {
  dataset$RT <- 0
  texts <- dataset[ , names(dataset) == var_text]
  texts <- iconv(texts, "latin1", "ASCII", sub="")
  texts_start <- substring(text = texts, first = 1, last = 2)
  texts_rt <- texts_start == 'RT'
  dataset$RT[texts_rt] <- 1
  print("A new variable has been added to the dataset: 'RT'")
  return(dataset)
}