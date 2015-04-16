require('RCurl')
require("jsonlite")
require('plyr')
require('dplyr')
require('tidyr')


#2nd highest cancellation for each month
nthval <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="
select l.month, l.dest, l.c_dest, nth_value(l.c_dest, 2)
OVER (PARTITION BY month) secondhighest_cancellation 
from 
( select month, dest, count(dest) AS c_dest 
FROM FT where origin = \\\'JFK\\\' and cancelled = 1  
GROUP BY month, dest order by month, c_dest desc) l
ORDER BY 1"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(nthval)