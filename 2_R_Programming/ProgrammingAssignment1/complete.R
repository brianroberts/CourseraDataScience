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

complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  compl <- data.frame(id=numeric(0), nobs=numeric(0))
  for (i in id) {
    data <- load_specdata(directory,i)
    compl <- rbind(compl,c(i,sum(complete.cases(data))))
  }
  names(compl)[1] <- "id"
  names(compl)[2] <- "nobs"
  compl
}