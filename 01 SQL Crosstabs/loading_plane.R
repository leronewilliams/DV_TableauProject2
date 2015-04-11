require(RCurl)
require(jsonlite)
require(dplyr)
require(tidyr)
require(plyr)

plane_df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select * from plane "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_nm22335', PASS='orcl_nm22335', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))); tbl_df(plane_df)