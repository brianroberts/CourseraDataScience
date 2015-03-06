best <- function(state, outcome) {
  ## Read outcome data
  outcome_data <- read.csv("/Users/broberts/Downloads/rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses="character")
  ## Check that state and outcome are valid
  if (!(state %in% outcome_data[,7])) { stop("invalid state") }
  if (outcome == "heart attack") { out_idx <- 11 }
  else if (outcome == "heart failure") { out_idx <- 17 }
  else if (outcome == "pneumonia") { out_idx <- 23 }
  else { stop("invalid outcome") }

  ## Return hospital name in that state with lowest 30-day death
  ## rate
  outcome_data[,out_idx] <- suppressWarnings(as.numeric(outcome_data[,out_idx]))
  min_val <- min(outcome_data[which(outcome_data[,7]==state), out_idx], na.rm=TRUE)
  outcome_data[outcome_data[,7]==state & is.na(outcome_data[,out_idx]) == FALSE & outcome_data[,out_idx] == min_val, 2]
  #  outcome_data[which(outcome_data[,3] == min(outcome_data[,3], na.rm = TRUE)), 1])
  #outcome_data[order(outcome_data[which(outcome_data[,3] == min(outcome_data[,3])), 1] ), 1][1]
}
