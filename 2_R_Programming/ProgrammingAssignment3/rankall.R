rankall <- function(outcome, num = "best") {
  states = c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", 
             "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", 
             "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", 
             "NC", "ND", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN", 
             "TX", "UT", "VT", "VI", "VA", "WA", "WV", "WI", "WY", "GU")
    
  ## Check that state and outcome are valid
  if (outcome == "heart attack") { 
    out_idx <- 11
  } else if (outcome == "heart failure") { 
    out_idx <- 17
  } else if (outcome == "pneumonia") { 
    out_idx <- 23
  } else { 
    stop("invalid outcome") 
  }
  if (!is.numeric(num)) {
    if (!(num %in% c('best','worst'))) {
      stop("invalid num")
    } else if (num == "best") {
      num = 1
    }
  } else if (num - round(num) != 0) {
    stop("invalud num")
  }

  ## Read outcome data
  outcome_data <- read.csv("/Users/broberts/Downloads/rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses="character")
  outcome_data <- outcome_data[order(outcome_data$State,outcome_data$Hospital.Name),c(2,7,out_idx)]
  outcome_data[,3] <- suppressWarnings(as.numeric(outcome_data[,3]))
    
  ## return rank hospital
  outcome_data <- transform(outcome_data, out.rank=ave(outcome_data[,3], outcome_data[,2], FUN=function(x) rank(x, na.last = TRUE, ties.method="first")))

  hospital <- c()

  for (state in states) {
    if (num == "worst") {
      hospital <- c(hospital, outcome_data[outcome_data[,2]==state & outcome_data$out.rank == max(outcome_data[is.na(outcome_data[,3])==FALSE & outcome_data[,2]==state,4]), 1])
      #is.na(outcome_data[,3])==FALSE & 
    } else if (num > max(outcome_data[outcome_data[,2]==state, 4])) { 
      hospital <- c(hospital, NA)
    } else {
      hospital <- c(hospital, outcome_data[outcome_data[,2]==state & outcome_data$out.rank==num, 1])
    }
  }
  data.frame(hospital=hospital, state=states))
#  colnames(out) <- c('hospital','state')
#  return(out)
}