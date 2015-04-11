require(tidyr)
require(plyr)
require(dplyr)

setwd("/Users/syairah/DataVisualization/DV_TableauProject2/01 SQL Crosstabs")

file_path <- "airports.csv"


ap <- read.csv(file_path, stringsAsFactors = FALSE)

# Replace "." (i.e., period) with "_" in the column names.
names(ap) <- gsub("\\.+", "_", names(ap))

str(ap)

measures <- c("lat","long")

dimensions <- setdiff(names(ap), measures)


for(d in dimensions) {
  # Get rid of " and ' in dimensions.
  ap[d] <- data.frame(lapply(ap[d], gsub, pattern="[\"']",replacement= ""))
  # Change & to and in dimensions.
  ap[d] <- data.frame(lapply(ap[d], gsub, pattern="&",replacement= " and "))
  # Change : to ; in dimensions.
  ap[d] <- data.frame(lapply(ap[d], gsub, pattern=":",replacement= ";"))
}


write.csv(ap, paste(gsub(".csv", "", file_path), "_reformatted.csv", sep=""), row.names=FALSE)


tableName <- "Airports"
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

