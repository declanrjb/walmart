library(tidyverse)
library(rvest)
library(RSelenium)
library(usmap)

rD <- rsDriver(
  port = 4548L,
  browser = "firefox",
  version = "latest",
  chromever = "106.0.5249.21",
  geckover = "latest",
  iedrver = NULL,
  phantomver = "2.1.1",
  verbose = TRUE,
  check = TRUE,
)

remDr <- rD[["client"]]
remDr$setTimeout(type = "implicit", 5000)

url <- "https://www.walmart.com/store-directory"
delay <- 5

remDr$navigate(url)

Sys.sleep(runif(delay))

states <- remDr$findElements("css selector", ".mt3")
states.html <- lapply(states, function(x){x$getElementAttribute("link-identifier")})
states_list <- unlist(states.html)
states_list <- states_list[2:51]

state_counts <- as.data.frame(matrix(nrow=50,ncol=2))
colnames(state_counts) <- c("State","Count")
state_counts$State <- states_list

for (x in states_list) {
  test <- remDr$findElement("link text", x)
  test$clickElement()
  #Begin states page
  message(x)
  
  #get state count
  state_metadata <- remDr$findElement("css selector", "h3.f6")
  count_text <- state_metadata$getElementAttribute("textContent")
  message(count_text)
  count_text -> state_counts[which(state_counts$State==x, arr.ind=TRUE)[1],]$Count
  state_counts$Count <- str_extract(state_counts$Count,regexp)

  #begin searching next level
  towns <- remDr$findElements("css selector", "a.dark-gray.no-underline.dbi.f6")
  towns.html <- lapply(towns, function(x){x$getElementAttribute("link-identifier")})
  towns_list <- unlist(towns.html)
  towns_list <- towns_list[2:length(towns_list)]
  
  Sys.sleep(runif(delay))
  
  #insert for loop here
  town_length <- length(towns_list)
  for (count in 1:length(towns_list)) {
    Sys.sleep(runif(delay))
    index <- sample(1:length(towns_list),1)
    y <- towns_list[index]
    towns_list <- towns_list[- index]
    message(length(towns_list))
    
    Sys.sleep(runif(delay))
    
    town_element <- remDr$findElement("link text", y)
    town_element$clickElement()
    #Begin states page
    message(y)
    
    #get data
    
    return_name <- paste(x," Walmart Stores",sep="")
    
    Sys.sleep(runif(delay))
    
    remDr$goBack()
  }
  
  #return to homepage
  test <- remDr$findElement("link text", "U.S. Walmart Stores")
  test$clickElement()
  Sys.sleep(runif(delay))
}

rD[["server"]]$stop()
