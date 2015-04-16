require('RCurl')
require("jsonlite")
require('plyr')
require('dplyr')
require('tidyr')

last_value <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select distinct dest, distance, dense_rank()
OVER (order by distance DESC) as DEST_RANK 
from FT where origin = \\\'JFK\\\' order by DEST_RANK"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(last_value)