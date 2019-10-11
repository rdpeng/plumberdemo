#
# This is a Plumber API. In RStudio 1.2 or newer you can run the API by
# clicking the 'Run API' button above.
#
# In RStudio 1.1 or older, see the Plumber documentation for details
# on running the API.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(plumber)

## Predict Ozone Levels Given Temperature
library(splines)
library(datasets)
fit <- lm(Ozone ~ ns(Temp, 2), data = airquality)

#* Predict Ozone from a Single Temperature
#* @param temp The temperature input
#* @get /ozone
ozone_predict <- function(temp) {
        ## Check input type
        temp <- as.numeric(temp)
        
        ## Make prediction from fitted model
        p <- predict(fit, data.frame(Temp = temp))
        
        ## Return predicted value
        as.numeric(p)
}



## temp is specified as temp1,temp2,temp3
#* Predict Ozone from a Single Temperature
#* @param temp The temperature input
#* @get /ozone_v
ozone_vpredict <- function(temp) {
        temp <- URLdecode(temp)
        temp <- strsplit(temp, ",", fixed = TRUE)[[1]]
        
        ## Check input type
        temp <- as.numeric(temp)
        
        ## Make prediction from fitted model
        p <- predict(fit, data.frame(Temp = temp))
        
        ## Return predicted value
        as.numeric(p)
}



