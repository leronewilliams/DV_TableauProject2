require(RCurl)
require(jsonlite)
require(dplyr)
require(tidyr)
require(plyr)

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select * from FT where origin = \\\'JFK\\\' "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))


dest_carrier <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select
CASE
WHEN grouping(Dest) = 1 THEN \\\'zTotal\\\'
ELSE dest END dest, CASE WHEN grouping(UniqueCarrier) = 1 THEN \\\'zTotal\\\'
ELSE UniqueCarrier END UniqueCarrier, count(*) n
from FT where origin = \\\'JFK\\\' group by cube (Dest, UniqueCarrier)"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(dest_carrier)

spread(dest_carrier, Dest, n)   #threw an error



rank_dest_carrier <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= "SELECT Dest, UniqueCarrier,  count(*) freq, rank() 
OVER (PARTITION BY Dest order by UniqueCarrier desc) Freq_Carrier
FROM FT where origin = \\\'JFK\\\' " ')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(rank_dest_carrier)

