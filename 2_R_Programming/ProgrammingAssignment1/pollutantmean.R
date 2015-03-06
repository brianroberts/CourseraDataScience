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

pollutantmean <- function( directory, pollutant, id = 1:332 ) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  data <- load_specdata(directory, id)

  good <- complete.cases(data)
  m <- -1
  if (pollutant == "sulfate") {
    m <- mean(data[good,][,2]) 
  }
  
  if (pollutant == "nitrate") {
    m <- mean(data[good,][,3]) 
  }
  m
}