require('RCurl')
require("jsonlite")
require('plyr')
require('dplyr')
require('tidyr')

#rank top_destinations for each uniquecarrier
rank <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="
select uniquecarrier, dest, COUNT(dest) AS TOTAL_RECORDS, rank()
OVER (PARTITION BY uniquecarrier order by COUNT(dest) desc) as DEST_RANK
from FT 
where origin = \\\'JFK\\\' 
GROUP BY uniquecarrier, dest"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(rank)


last_value <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select distinct dest, distance, dense_rank()
OVER (order by distance DESC) as DEST_RANK 
from FT where origin = \\\'JFK\\\' order by DEST_RANK"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(last_value)




#query works in sql but not in r - CHECK
# max_value - carriers with most delays. Can't do rank and pull total number of records for each 
max_value <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="
SELECT uniquecarrier, MAX(Arrdelay) AS Avg_Arrdelay, AVG(Depdelay) AS Avg_Depdelay 
FROM FT 
WHERE origin = \\\'JFK\\\' 
GROUP BY uniquecarrier "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(max_value)



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

#cume_dist
cumedist <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select  G.dest,  G.avg_airtime, cume_dist()
OVER (ORDER BY G.avg_airtime ASC) AS PERCENTILE
from ( Select dest, AVG(airtime) AS avg_airtime FROM FT where origin = \\\'JFK\\\' GROUP BY dest) G
order by 2 "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(cumedist)




#determining the airtime  uniquecarriers relative to the max_airtime for a certain dist
#tableau - sheet 14
lastval_dif <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select distinct dest, uniquecarrier, airtime, last_value(max_airtime)
OVER (PARTITION BY dest) AS max_airtime, last_value(max_airtime)
OVER (PARTITION BY dest, uniquecarrier) - airtime  AS aberration
FROM
(SELECT dest, uniquecarrier, airtime, max(airtime)
OVER (PARTITION BY dest) AS max_airtime
FROM FT where origin = \\\'JFK\\\' AND cancelled = 0 AND (sdelay = 0 OR sdelay IS NULL) AND (weatherdelay = 0 OR weatherdelay IS NULL ) AND (securitydelay = 0 OR securitydelay IS NULL)) ORDER BY dest, uniquecarrier, airtime "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(lastval_dif)


#ps : will try more for difference, couldn't find anything interesting - since we can't do SUM() and only difference .. Let me know if you have any idea
