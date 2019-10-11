## Ozone client function

library(jsonlite); library(curl); library(glue)

ozone_predict_remote <- function(temp) {
        ## Construct API URL
        cmd <- glue("http://67.205.166.80:8000/ozone?", 
                    "temp={temp}")
        
        ## Open connection to the web server
        con <- curl(cmd)
        
        ## Read the answer from the server
        ans <- readLines(con, 1, warn = FALSE)
        
        ## Close server connection
        close(con)
        
        ## Convert answer from JSON and return
        fromJSON(ans)
}


ozone_vpredict_remote <- function(temp) {
        temp <- paste(temp, collapse = ",")
        
        ## Construct API URL
        cmd <- glue("http://67.205.166.80:8000/ozone_v?", 
                    "temp={temp}")
        
        ## Open connection to the web server
        con <- curl(cmd)
        
        ## Read the answer from the server
        ans <- readLines(con, 1, warn = FALSE)
        
        ## Close server connection
        close(con)
        
        ## Convert answer from JSON and return
        fromJSON(ans)
}