require('RCurl')
require("jsonlite")
apdata <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select * from FT where origin = \\\'JFK\\\' "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(apdata)

rank <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select tailnum, uniquecarrier, dest, rank()
OVER (PARTITION BY uniquecarrier order by dest desc) as DEST_RANK 
from FT where origin = \\\'JFK\\\' order by 2,3 desc"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(rank)

rank2 <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select tailnum, uniquecarrier, dest, rank()
OVER (order by dest desc) as DEST_RANK 
from FT where origin = \\\'JFK\\\'"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(rank2)

#rank3 <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select * from (select tailnum, uniquecarrier, dest, rank()
#OVER (PARTITION BY uniquecarrier order by dest desc) as DEST_RANK 
#from FT where origin = \\\'JFK\\\' "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
#tbl_df(rank3)

lmd <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select tailnum, uniquecarrier, dest, last_value(max_dest)
OVER (PARTITION BY uniquecarrier order by dest) max_dest, last_value(max_dest) 
OVER (PARTITION BY uniquecarrier order by dest) - dest dest_diff
from
(SELECT tailnum, uniquecarrier, dest, max(dest)
OVER (PARTITION BY uniquecarrier) max_dest
from FT where origin = \\\'JFK\\\'order by 2,3 desc"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(lmd)





df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select empno, deptno, sal, last_value(max_sal) 
OVER (PARTITION BY deptno order by sal) max_sal, last_value(max_sal) 
OVER (PARTITION BY deptno order by sal) - sal sal_diff
from
(SELECT empno, deptno, sal, max(sal)
OVER (PARTITION BY deptno) max_sal 
FROM emp) 
order by 2,3 desc"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal', USER='DV_Scott', PASS='orcl', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(df)

nthval <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select tailnum, uniquecarrier, dest, nth_value(dest, 2)
OVER (PARTITION BY uniquecarrier) max_dest 
from FT where origin = \\\'JFK\\\' order by 2,3 desc"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(nthval)


cumedist <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select tailnum, uniquecarrier, dest, cume_dist()
OVER (PARTITION BY uniquecarrier order by dest) cume_dist
from FT where origin = \\\'JFK\\\' order by 2,3 desc"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(cumedist)









