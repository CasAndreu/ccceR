#' A function to download images from tweets.
#'
#' This function allows you to download images that are part
#'    of a tweet and it also adds a new variable to the dataset
#'    indicating the id of the image in that tweet or "" if the
#'    tweet has no image.
#' @param dataset The name of your dataset.
#' @param links_full_url A string indicating the name of the 
#'    variable in your dataset that conatins full links to the
#'    images urls
#' @param path Path to the directory where you want to store the
#'    images
#' @keywords images
#' @export
#' @examples  \dontrun{
#' dataset_with_image_id <- download_images(dataset, "links_full_url",
#'    "path/to/a/directory")
#' }
download_images <- function(dataset, links_full_url, path) {
  full_urls <- dataset[ , names(dataset) == links_full_url]
  urls <- sapply(full_urls, function(x)
    x[grepl(pattern = "/photo/", x = unlist(x))])
  dataset$image_url <- ""
  dataset$image_url[which(nchar(urls) > 12)] <- urls[which(nchar(urls) > 12)]
  all_ids <- NULL
  for (url in urls) {
    if (length(url) == 0) {
      all_ids <- c(all_ids, "")
      next
    } else{
      result2 <- try(url_html <- read_html(url));
      if(class(result2)[1] == "try-error") next;
      result2 <- try(image_link <- html_node(url_html, "div .AdaptiveMedia-photoContainer"));
      if(class(result2)[1] == "try-error") next;
      image_str <- as.character(image_link)
      image_url <- extraire(image_str,'data-image-url=\"(.*?)\"')
      image_url_splitted <- strsplit(image_url, "/")
      image_id <- image_url_splitted[[1]][length(image_url_splitted[[1]])]
      all_ids[[length(all_ids)+1]] <- c(image_id)
      download.file(url = image_url, destfile = paste0(path, "/", image_id))
    }
  }
  dataset$image_id <- all_ids
  return(dataset)
}