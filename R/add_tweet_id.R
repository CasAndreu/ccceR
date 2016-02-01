#' A function to add a variable with the tweet id.
#'
#' This function allows you to add a variable with the tweet id. 
#' @param dataset The name of your dataset.
#' @param var_tweet_url A string indicating the name of the variable with the 
#'    tweet URL.
#' @keywords tweet_id
#' @export
#' @examples  \dontrun{
#' dataset_with_tweet_id <- add_link_dummy(dataset, "URL")
#' }
add_tweet_id <- function(dataset, var_tweet_url) {
  id_urls <- dataset[ , names(dataset) == var_tweet_url]
  id_urls_splitted <- strsplit(id_urls, "/")
  ids <- sapply(id_urls_splitted, function(x) x[[length(x)]])
  dataset$tweet_id <- ids
  print("A new variable has been added to the dataset: 'tweet_id'")
  return(dataset)
}