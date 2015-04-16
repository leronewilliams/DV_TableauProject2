require('RCurl')
require("jsonlite")
require('plyr')
require('dplyr')
require('tidyr')

#determining the airtime  uniquecarriers relative to the max_airtime for a certain dist
lastval_dif <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select distinct dest, uniquecarrier, airtime, last_value(max_airtime)
OVER (PARTITION BY dest) AS max_airtime, last_value(max_airtime)
OVER (PARTITION BY dest, uniquecarrier) - airtime  AS aberration
FROM
(SELECT dest, uniquecarrier, airtime, max(airtime)
OVER (PARTITION BY dest) AS max_airtime
FROM FT where origin = \\\'JFK\\\' AND cancelled = 0 AND (sdelay = 0 OR sdelay IS NULL) AND (weatherdelay = 0 OR weatherdelay IS NULL ) AND (securitydelay = 0 OR securitydelay IS NULL)) ORDER BY dest, uniquecarrier, airtime "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(lastval_dif)