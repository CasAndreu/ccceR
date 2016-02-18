#' @title 
#' A function that adds a dummy variable to the dataset indicating which
#'    messages contain links to images.
#'
#' @description
#' This function takes the URLs in the tweets' text and it
#'    indicates whether this contains a link to an image (==1) 
#'    or not (==0).
#' @param dataset The name of your dataset.
#' @param var_full_url A string indicating the name of the 
#'    variable in your dataset that conatins lists with full
#'    urls in the text messages.
#' @keywords image
#' @export
#' @examples \dontrun{
#' dataset_with_image_dummy <- add_image_dummy(dataset, "links_full_url")
#' }
add_image_dummy <- function(dataset, var_full_url = "links_full_url") {
  if(!(var_full_url %in% names(dataset))) {
    print(paste(var_full_url, "not in the dataset!"))
    break
  }
  urls <- dataset[ , names(dataset) == var_full_url]
  urls_image_boolean <- sapply(urls, function(x) 
              grep(pattern = "/photo/|twitter.com", x = x))
  image_dummy <- sapply(urls_image_boolean, function(x) 
                  length(x) > 0 )
  dataset$image_dummy <- 0
  dataset$image_dummy[image_dummy] <- 1
  print("A new variable has been added to the dataset: 'image_dummy'")
  return(dataset)
}