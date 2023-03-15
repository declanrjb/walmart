for (y in towns_list) {
  test <- remDr$findElement("link text", y)
  test$clickElement()
  #Begin town page page
  message(y)
  #return to state page
  test <- remDr$findElement("link text", x)
  test$clickElement()
}