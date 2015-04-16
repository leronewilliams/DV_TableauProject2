

require('RCurl')
require("jsonlite")
require('plyr')
require('dplyr')
require('tidyr')

#cume_dist
cumedist <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select  G.dest,  G.avg_airtime, cume_dist()
OVER (ORDER BY G.avg_airtime ASC) AS PERCENTILE
from ( Select dest, AVG(airtime) AS avg_airtime FROM FT where origin = \\\'JFK\\\' GROUP BY dest) G
order by 2 "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(cumedist)