#' A function to get the long urls in tweets
#'
#' This function takes the output of the getURL() function
#'    of the package "RCurl" and it returns the long_url of
#'    given shortened urls. The credit for this function should
#'    be given to Arthur Charpentier, who wrote this post:
#'    http://www.r-bloggers.com/r-twitter-and-urls/
#' @param entree The word that indicates where the long_url starts
#' @param motif The word that indicates where the long_url ends
#' @keywords 
#' @export
#' @examples
#' res <- try(extraire(long_urls,"\r\nlocation: (.*?)\r\nserver"))
#' 
extraire <- function(entree,motif){
  res <- regexec(motif,entree)
  if(length(res[[1]])==2){
    debut <- (res[[1]])[2]
    fin <- debut+(attr(res[[1]],"match.length"))[2]-1
    return(substr(entree,debut,fin))
  }else return(NA)}