#' @title 
#' Transforming a dataset with all ccceR variables to a
#'    data frame that can be exported to a CSV file.
#'
#' @description
#' Data frames with variables that are lists can not be written
#' out in CSV format. Some of the variables that the ccceR
#' creates are lists (e.g. links_full_url). This function takes 
#' a dataset and transforms all variables to character variables
#' and returns a dataset that can be exported in CSV format.
#' 
#' @param dataset The name of your dataset.
#' @keywords dataframe-lists
#' @export
#' @examples \dontrun{
#' new_dataset <- as_data_frame(dataset)
#' write.csv(new_dataset, "new_dataset.csv", row.names = FALSE)
#' }
as_data_frame <- function(dataset) {
  newdataset <- data.frame(lapply(dataset, as.character),
                           stringsAsFactors=FALSE)
  return(newdataset)
}