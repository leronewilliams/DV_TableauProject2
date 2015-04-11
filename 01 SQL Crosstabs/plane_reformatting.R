require(tidyr)
require(plyr)
require(dplyr)

setwd("/Users/syairah/DataVisualization/DV_TableauProject2/01 SQL Crosstabs")

file_path <- "plane-data.csv"


plane <- read.csv(file_path, stringsAsFactors = FALSE)

# Replace "." (i.e., period) with "_" in the column names.
names(plane) <- gsub("\\.+", "_", names(plane))

str(plane)

measures <- c("year")

dimensions <- setdiff(names(plane), measures)

for(m in measures) {
  plane[m] <- data.frame(lapply(plane[m], gsub, pattern="None",replacement= ""))
}

for(d in dimensions) {
  # Get rid of " and ' in dimensions.
  plane[d] <- data.frame(lapply(plane[d], gsub, pattern="[\"']",replacement= ""))
  # Change & to and in dimensions.
  plane[d] <- data.frame(lapply(plane[d], gsub, pattern="&",replacement= " and "))
  # Change : to ; in dimensions.
  plane[d] <- data.frame(lapply(plane[d], gsub, pattern=":",replacement= ";"))
}


write.csv(plane, paste(gsub(".csv", "", file_path), "_reformatted.csv", sep=""), row.names=FALSE)


tableName <- "Plane"
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
