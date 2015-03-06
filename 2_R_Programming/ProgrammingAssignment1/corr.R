load_specdata <- function( path, id ) {
  files = c()
  for (i in id) {
    dir <- paste( getwd(), path, "", sep="/")
    file <- paste( dir, formatC(i, width = 3, format = "d", flag = "0"), ".csv", sep="" )
    files = c(files,file)
  }
  tables <- lapply(files, read.csv)
  do.call(rbind, tables)
}

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  c <- c()
  for (i in 1:332) {
    data <- load_specdata(directory,i)
    good <- complete.cases(data)
    if (sum(complete.cases(data)) > threshold) {
      c <- c(c,cor(data[good,][,2],data[good,][,3]))
    }
  }
  c
}