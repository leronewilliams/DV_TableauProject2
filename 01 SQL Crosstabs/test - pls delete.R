time_efficiency <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= "SELECT * FROM (SELECT DISTINCT dest, Avg_Dist, uniquecarrier, min_airtime, max_airtime, Diff_airtime, rank() 
OVER (PARTITION BY dest order by Diff_airtime ASC) as AirTimeDuration_Rank 
FROM (SELECT * FROM 
(SELECT distinct dest, uniquecarrier, Avg_Dist, 
first_value(airtime) IGNORE NULLS OVER (PARTITION BY dest ORDER BY airtime asc ) AS min_airtime,
last_value(airtime) IGNORE NULLS OVER (PARTITION BY dest ORDER BY airtime desc) AS max_airtime,
last_value(airtime) IGNORE NULLS OVER (PARTITION BY dest ORDER BY airtime desc) -
first_value(airtime) IGNORE NULLS OVER (PARTITION BY dest ORDER BY airtime asc) AS Diff_airtime 
FROM ( 
SELECT distinct dest, uniquecarrier, airtime, AVG(distance) AS Avg_Dist FROM FT WHERE origin = \\\'JFK\\\' AND cancelled = 0 AND (sdelay = 0 OR sdelay IS NULL) GROUP BY dest, uniquecarrier, airtime))
WHERE min_airtime != max_airtime))
WHERE AirTimeDuration_Rank = 1
ORDER BY dest ASC
"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(time_efficiency)



time_efficiency <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= "SELECT * FROM (SELECT dest, Avg_Dist, uniquecarrier, min_airtime, max_airtime, Diff_airtime, rank() 
OVER (PARTITION BY dest order by Diff_airtime ASC) as AirTimeDuration_Rank (
FROM (SELECT distinct dest, uniquecarrier, Avg_Dist, 
first_value(airtime) IGNORE NULLS OVER (PARTITION BY dest, uniquecarrier ORDER BY airtime asc ) AS min_airtime,
last_value(airtime) IGNORE NULLS OVER (PARTITION BY dest, uniquecarrier ORDER BY airtime desc) AS max_airtime,
last_value(airtime) IGNORE NULLS OVER (PARTITION BY dest, uniquecarrier ORDER BY airtime desc) -
first_value(airtime) IGNORE NULLS OVER (PARTITION BY dest, uniquecarrier ORDER BY airtime asc) AS Diff_airtime 
FROM ( 
SELECT distinct dest, uniquecarrier, airtime, AVG(distance) AS Avg_Dist FROM FT WHERE origin = \\\'JFK\\\' AND cancelled = 0 AND (sdelay = 0 OR sdelay IS NULL) GROUP BY dest, uniquecarrier, airtime))))
WHERE max_airtime != min_airtime AND DEST = \\\'ACK\\\'
ORDER BY DEST ASC, max_airtime DESC

"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(time_efficiency)



time_efficiency <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= "SELECT * FROM (SELECT dest, Avg_Dist, uniquecarrier, min_airtime, max_airtime, Diff_airtime, rank() 
OVER (PARTITION BY dest order by max_airtime DESC, Diff_airtime ASC, min_airtime ASC) as AirTimeDuration_Rank FROM (SELECT * FROM (SELECT distinct dest, uniquecarrier, Avg_Dist, 
first_value(airtime) IGNORE NULLS OVER (PARTITION BY dest, uniquecarrier ORDER BY airtime asc ) AS min_airtime,
last_value(airtime) IGNORE NULLS OVER (PARTITION BY dest, uniquecarrier ORDER BY airtime desc) AS max_airtime,
last_value(airtime) IGNORE NULLS OVER (PARTITION BY dest, uniquecarrier ORDER BY airtime desc) -
first_value(airtime) IGNORE NULLS OVER (PARTITION BY dest, uniquecarrier ORDER BY airtime asc) AS Diff_airtime 
FROM ( 
SELECT distinct dest, uniquecarrier, airtime, AVG(distance) AS Avg_Dist FROM FT WHERE origin = \\\'JFK\\\' AND cancelled = 0 AND (sdelay = 0 OR sdelay IS NULL) GROUP BY dest, uniquecarrier, airtime))
WHERE max_airtime != min_airtime
ORDER BY DEST ASC, max_airtime DESC))
WHERE AirTimeDuration_Rank = 1 
"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(time_efficiency)



time_efficiency <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= " 
SELECT distinct dest, uniquecarrier, max(airtime), AVG(distance) AS Avg_Dist FROM FT WHERE origin = \\\'JFK\\\' AND cancelled = 0 AND (sdelay = 0 OR sdelay IS NULL) GROUP BY dest, uniquecarrier, airtime

"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(time_efficiency)




time_efficiency <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query= "SELECT distinct dest, uniquecarrier, airtime, AVG(airtime) AS Avg_Airtime, AVG(distance) AS Avg_Dist FROM FT WHERE origin = \\\'JFK\\\' AND cancelled = 0 AND (sdelay = 0 OR sdelay IS NULL) AND (weatherdelay = 0 OR weatherdelay IS NULL ) AND (securitydelay = 0 OR securitydelay IS NULL) GROUP BY dest, uniquecarrier
"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(time_efficiency)










