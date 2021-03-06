% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/download_images.R
\name{download_images}
\alias{download_images}
\title{A function to download images from tweets.}
\usage{
download_images(dataset, links_full_url, path)
}
\arguments{
\item{dataset}{The name of your dataset.}

\item{links_full_url}{A string indicating the name of the 
variable in your dataset that conatins full links to the
images urls}

\item{path}{Path to the directory where you want to store the
images}
}
\description{
This function allows you to download images that are part
   of a tweet and it also adds a new variable to the dataset
   indicating the id of the image in that tweet or "" if the
   tweet has no image
}
\examples{
 \dontrun{
dataset_with_image_id <- download_images(dataset, "links_full_url",
   "path/to/a/directory")
}
}
\keyword{images}

