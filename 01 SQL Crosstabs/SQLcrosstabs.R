require('RCurl')
require("jsonlite")
require("dplyr")
apdata <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select * from FT where origin = \\\'JFK\\\' "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(apdata)

rank <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select distinct uniquecarrier, dest, rank()
OVER (PARTITION BY uniquecarrier order by dest) as DEST_RANK
from FT where origin = \\\'JFK\\\'order by 2,3"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(rank)

rank2 <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select tailnum, uniquecarrier, dest, rank()
OVER (order by dest desc) as DEST_RANK 
from FT where origin = \\\'JFK\\\'"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(rank2)

rank3 <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select * from (select tailnum, uniquecarrier, dest, rank()
OVER (PARTITION BY uniquecarrier order by dest desc) as DEST_RANK 
from FT where origin = \\\'JFK\\\') where DEST_RANK = 1"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(rank3)

lmd <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select tailnum, uniquecarrier, deptime, last_value(max_deptime)
OVER (PARTITION BY uniquecarrier order by deptime) max_deptime, last_value(max_deptime)
OVER (PARTITION BY uniquecarrier order by deptime) - deptime deptime_diff
from
(select tailnum, uniquecarrier, deptime, max(deptime)
OVER (PARTITION BY uniquecarrier) max_deptime
from FT where origin = \\\'JFK\\\') order by 2,3 desc"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(lmd)

nthval <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select tailnum, uniquecarrier, dest, nth_value(dest, 2)
OVER (PARTITION BY uniquecarrier) max_dest 
from FT where origin = \\\'JFK\\\' order by 2,3 desc"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(nthval)

cumedist <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select tailnum, uniquecarrier, dest, cume_dist()
OVER (PARTITION BY uniquecarrier order by dest) cume_dist
from FT where origin = \\\'JFK\\\' order by 2,3 desc"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(cumedist)









