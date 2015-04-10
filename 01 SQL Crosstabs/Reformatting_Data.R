setwd("/Users/syairah/DataVisualization/DV_TableauProject2/01 SQL Crosstabs")

file_path <- "2008.csv"

df <- read.csv(file_path, stringsAsFactors = FALSE)

#since the column names are structured pretty well - we move on to get measures and dimensions

str(df) 

measures <- c("Year", "Month", "DayofMonth", "DayOfWeek", "DepTime", "CRSDepTime", "ArrTime", "CRSArrTime", "FlightNum", "ActualElapsedTime", "CRSElapsedTime", "AirTime", "ArrDelay", "DepDelay", "Distance", "TaxiIn", "TaxiOut", "Cancelled", "Diverted", "CarrierDelay", "WeatherDelay", "NASDelay", "SecurityDelay", "LateAircraftDelay")


dimensions <- setdiff(names(df), measures)


for(m in measures) {
  df[m] <- data.frame(lapply(df[m], gsub, pattern="NA",replacement= ""))
}


#check to make sure if NA is also one of unique carriers (which is confusing and can be mistaken as NA missing data). This is because unique carriers also have two-letter representations.
l <- as.factor(df$UniqueCarrier)
l

for(d in dimensions) {
  # Get rid of " and ' in dimensions.
  df[d] <- data.frame(lapply(df[d], gsub, pattern="[\"']",replacement= ""))
  # Remove NA in dimensions.
  df[d] <- data.frame(lapply(df[d], gsub, pattern="NA",replacement= ""))
}


write.csv(df, paste(gsub(".csv", "", file_path), "_reformatted.csv", sep=""), row.names=FALSE)


tableName <- "FT"
sql <- paste("CREATE TABLE", tableName, "( \n")
for(d in dimensions) {
  sql <- paste(sql, paste(d, "varchar2(4000),\n"))
}
for(m in measures) {
  if(m != tail(measures, n=1)) sql <- paste(sql, paste(m, "number(38,4),\n"))
  else sql <- paste(sql, paste(m, "number(38,4)\n"))
}
sql <- paste(sql, ");")
cat(sql)
