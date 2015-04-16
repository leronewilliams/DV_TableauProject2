require('RCurl')
require("jsonlite")
require('dplyr')
require('plyr')
require('tidyr')

#rank top_destinations for each uniquecarrier
rank <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select uniquecarrier, dest, COUNT(dest) AS TOTAL_RECORDS, rank()
                                                  OVER (PARTITION BY uniquecarrier order by COUNT(dest) desc) as DEST_RANK
                                                  from FT where origin = \\\'JFK\\\'GROUP BY uniquecarrier, dest"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(rank)