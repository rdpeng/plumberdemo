
## Return 95% confidence interval for the median
confint_median <- function(x, N = 1000) {
        ## Coerce to numeric
        x <- as.numeric(x)
        
        ## Remove missing values
        x <- x[!is.na(x)]
        
        if(length(x) == 0L) 
                stop("no non-missing data values")
        nobs <- length(x)
        med <- replicate(N, {
                x.new <- sample(x, nobs, replace = TRUE)
                median(x.new)
        })
        quantile(med, c(0.025, 0.975))
}


#* Compute the 95% bootstrap confidence interval for the median
#* @param key the S3 key for the data
#* @param bucket the name of the bucket where the data live
#* @param N the number of bootstrap iterations
#* @get /confint
confint_median_compute <- function(key, bucket, N) {
        ## Make sure data is proper type
        key <- as.character(key)
        bucket <- as.character(bucket)
        N <- as.integer(N)
        
        ## Read data from S3
        x <- s3readRDS(key, bucket = bucket)
        
        ## Compute the confidence interval
        confint_median(x, N)
}

