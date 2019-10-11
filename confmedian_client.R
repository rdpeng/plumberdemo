library(aws.s3)
library(jsonlite)
library(curl)
library(glue)

## Need to have AWS credentials set in .Renviron already!

## Compute the 95% confidence interval for the median using 
## a remote server
median_CI <- function(x, N = 1000) {
        bucket <- "confint"
        buckets_available <- bucketlist()$Bucket
        if(bucket %in% buckets_available) {
                message("using '", bucket, "' bucket")
        } else {
                stop("'", bucket, "' bucket not available")
        }
        ## Upload the data to AWS S3 bucket
        ## Key for storing data on AWS
        key <- "xdata"
        val <- s3saveRDS(x, key, bucket)
        if(!val) {
                stop("problem saving data to S3")
        }
        
        ## Call the function on the remote server
        ## Construct API URL and open connection to the web server
        cmd <- glue("http://67.205.166.80:8000/confint?", 
                    "key={key}&bucket={bucket}&N={N}")
        con <- curl(cmd)
        
        ## Read the answer from the server
        message("connecting to server")
        tryCatch({
                ans <- readLines(con, 1, warn = FALSE)
        }, finally = {
                ## Close server connection
                close(con)
        })
        ## Convert answer from JSON and return
        fromJSON(ans)
}


