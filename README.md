# ccceR
This is an R package that allow researchers of the [Center for Communication and Civic Engagement](http://ccce.com.washington.edu/) (CCCE) at the University of Washington to analyze and study social media data.

## Installing the Package
To install this ccceR package use the ``install_github()`` function of the ``devtools`` package. 

    install.packages("devtools")
    library(devtools)
    install_github("CasAndreu/ccceR")
    library(ccceR)

## Reading ``xls`` files from ``Crimson Hegaxon``
If you are using an Excel file downloaded from Crimson Hexagon, you need to do some simple pre-processing tasks in order to have a dataset you can apply the ``ccceR`` functions (a dataset with meaningful variable names).

To read the ``xls`` file into R, you can use the package ``rio``. If you don't have the package, install it first. Then load it.

    install.packages("rio")
    library(rio)

Read and pre-process the data in R

    file_path <- "path/to/the/xls/file"
    raw_dataset <- import(file_path)
    colnames(raw_dataset) <- raw_dataset[1, ] # The name of the variables are in the first row
    dataset <- raw_dataset[2:nrow(raw_dataset), ] # Getting rid of the first row of the dataset

## Example of the ``add_rt_dummy()``
This function adds a RT dummy variable into the dataset to indicate which messages are RTs. If the message is a retweet, ``RT`` == 1.
   
```new_dataset <- add_rt_dummy(dataset, "Contents")```


## Example of the ``add_link_dummy()``
This function adds a dummy variable to the dataset indicating which messages contain at least one URL. If the message contains URLs, ``link_dummy`` == 1.

```new_dataset <- add_link_dummy(dataset, "Contents")```

## Example of the ``add_tweet_id()``
This function adds a variable to the datset with the tweet id (``tweet_id``).

```new_dataset <- add_tweet_id(dataset, "URL")`

## Example of the ``add_links_url()``
This function adds 2 variables to the dataset with "shortened" (``links_short_url``) and "full" (``links_full_url``) URLs in the text messages.

```new_dataset <- add_links_url(dataset, "Contents")```

## Example of the ``add_image_dummy()``
This function adds a dummy variable to the dataset (``image_dummy``) indicating which messages contain links to images.

```new_dataset <- add_image_dummy(dataset, "links_full_url")```

## Example of the ``download.images()``
This function downloads images in tweets to a directory given by the user, and it also adds a variable to the dataset indicating the id of the tweet images.

```new_dataset <- download_images(dataset, "links_full_url", "path/to/a/directory")```
