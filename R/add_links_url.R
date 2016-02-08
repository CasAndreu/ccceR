#' @title 
#'  A function adds 2 variables in the datset with the "shortened"
#'    and "complete" links in the messages
#'  
#' @description 
#' This function takes the text message in tweets and looks for urls
#'    in them. Then in creates 2 variables "links_short_url" and 
#'    "links_full_url" to the datset with the links to those urls.
#' @param dataset The name of your dataset.
#' @param var_text A string indicating the name of the 
#'    variable in your dataset that conatins text messages.
#' @keywords urls
#' @export
#' @examples  \dontrun{
#' dataset_with_links_urls <- add_links_url(dataset, "Contents")
#' }

add_links_url <- function(dataset, var_text) {
  texts <- dataset[ , names(dataset) == var_text]
  texts <- iconv(texts, "latin1", "ASCII", sub="")
  url_pattern <- "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"
  urls_info <- gregexpr(url_pattern, texts)
  length_urls <- sapply(urls_info, function(x) attr(x, which = "match.length"))
  cut_urls <- sapply(urls_info, function(x) unlist(x[1:length(attr(x, which = "match.length"))]))
  short_urls <- sapply(1:length(texts), function(i) substring(texts[i], cut_urls[[i]], cut_urls[[i]] + length_urls[[i]]))
  var_urls <- sapply(1:length(short_urls), function(i) short_urls[[i]])
  dataset$links_short_url <- var_urls
  all_long <- NULL
  for (i in 1:length(short_urls)) {
    ls <- short_urls[[i]]
    if (ls[[1]] == "") {
      all_long <- c(all_long, "")
      next
    } 
    long_urls_list <- NULL
    for (url in ls) {
      if (nchar(url) < 16) {
        long_urls_list <- c(long_urls_list, "incomplete")
      } else {
        long_raw <- sapply(url, function(x) try(getURL(x, header=TRUE, nobody=TRUE, 
            followlocation=FALSE,cainfo = system.file("CurlSSL", "cacert.pem",
                                                      package = "RCurl"))))
        long_url <- try(extraire(long_raw,"\r\nlocation: (.*?)\r\nserver"))
        if (nchar(long_url) < 30 & !is.na(long_url)) {
          long_raw <- sapply(long_url, function(x) try(getURL(x, header=TRUE, nobody=TRUE, 
                      followlocation=FALSE,cainfo = system.file("CurlSSL", "cacert.pem",
                      package = "RCurl"))))
          long_url <- try(extraire(tolower(long_raw),"\r\nlocation: (.*?)\r"))
        }
        long_urls_list <- c(long_urls_list, long_url)
      }
    }
    all_long[length(all_long)+1] <- list(long_urls_list)
  }
  dataset$links_full_url <- all_long
  print("2 new variables have been added to the dataset: 'links_short_url' & 'links_full_url'")
  return(dataset)
}
