



month = c("2018-10","2018-11","2018-12","2019-01","2019-02","2019-03","2019-04","2019-05","2019-06","2019-07","2019-08","2019-09","2019-10")
ID = unlist(ID[,2])

i=1
j= 1 

no_data = data.frame(ID=0,month=0)
no_data = no_data[-0,]

cc= cc[-0,]
j = 2
repeat{
  if(j>length(ID))break
  A = paste0("https://e-service.cwb.gov.tw/HistoryDataQuery/MonthDataController.do?command=viewMain&station=",ID[j])
  B = "&stname=%25E9%259E%258D%25E9%2583%25A8&datepicker="
  url1 = paste0(A,B)
  print(c(j,ID[j]))
  i=1
    repeat{
      if(i>13)break
      print(c(i,month[i]))
    url = paste0(url1,month[i])             
    AA = read_html(url)
      aa = html_nodes(AA, "td:nth-child(22) , td:nth-child(17) , td:nth-child(14) , #MyTable td:nth-child(8) , #MyTable td:nth-child(2) , #MyTable td:nth-child(1)") %>% html_text()
      aa = matrix(aa, ncol = 6, byrow = T)
        bb = cbind(paste(month[i],aa[,1],sep = "-"),ID[j],aa[,2:6])
        cc = rbind(cc,bb)
        i=i+1 
    }
  j= j+1
  }

save(cc,file = "cc.rData")

ID = ID[,2]
td:nth-child(22) , td:nth-child(17) , td:nth-child(14) , td:nth-child(8) , #MyTable td:nth-child(1) , td:nth-child(2)

#### demo

https://e-service.cwb.gov.tw/HistoryDataQuery/DayDataController.do?command=viewMain&station=466920&stname=%25E8%2587%25BA%25E5%258C%2597&datepicker=2020-07-01

## 2010-04-01:2016-04-30
## construct date
the_str_time <- as.Date("2010-04-01")
the_end_time <- as.Date("2010-04-30")
dates <- seq(the_str_time, the_end_time, by = 1)
head(dates)

month = c("2018-10","2018-11","2018-12","2019-01","2019-02","2019-03","2019-04","2019-05","2019-06","2019-07","2019-08","2019-09","2019-10")
ID = unlist(ID[,2])
dates[1]
i=1
j= 1 

no_data = data.frame(ID=0,dates=0)
no_data = no_data[-0,]

cc= cc[-0,]
j = 2
repeat{
  if(j>length(ID))break
  A = paste0("https://e-service.cwb.gov.tw/HistoryDataQuery/DayDataController.do?command=viewMain&station=466920&stname=%25E8%2587%25BA%25E5%258C%2597&datepicker=",dates[j])
  url1 = paste0(A,B)
  print(c(j,ID[j]))
  i=1
  repeat{
    if(i>13)break
    print(c(i,month[i]))
    url = paste0(url1,month[i])             
    AA = read_html(url)
    aa = html_nodes(AA, "td:nth-child(22) , td:nth-child(17) , td:nth-child(14) , #MyTable td:nth-child(8) , #MyTable td:nth-child(2) , #MyTable td:nth-child(1)") %>% html_text()
    aa = matrix(aa, ncol = 6, byrow = T)
    bb = cbind(paste(month[i],aa[,1],sep = "-"),ID[j],aa[,2:6])
    cc = rbind(cc,bb)
    i=i+1 
  }
  j= j+1
}

library(xml2) #用來讀網頁編碼的套件
library(rvest) #使用github碼來擷取網頁資料
library(httr) #使用Get直接存取網頁，即使網址失效也可存取錯誤資訊，並有proxy ip功能。
#在這個範例裡並沒有使用到
library(stringr) #字串處理
library(dplyr) #基本處理套件
library(rio) #匯出檔案用

## 2010-04-01 to 2016-04-30
the_str_time <- as.Date("2010-04-01")
the_end_time <- as.Date("2016-04-30")
dates <- seq(the_str_time, the_end_time, by = 1)
n_distinct(dates) # 共2222天
#cc <- NULL
for (i in 1:length(dates)) {
  print(c(i,dates[i]))
  url=paste0("https://e-service.cwb.gov.tw/HistoryDataQuery/DayDataController.do?command=viewMain&station=466920&stname=%25E8%2587%25BA%25E5%258C%2597&datepicker=",dates[i])
  AA = read_html(url)
  aa = html_nodes(AA, "#MyTable td:nth-child(7) , .second_tr+ .second_tr th:nth-child(7) , #MyTable td:nth-child(6) , .second_tr+ .second_tr th:nth-child(6) , #MyTable td:nth-child(4) , .second_tr+ .second_tr th:nth-child(4) , #MyTable td:nth-child(1) , .second_tr+ .second_tr th:nth-child(1)") %>% html_text()
  aa = matrix(aa,ncol=4,byrow = T)
  aa = as.data.frame(aa)
  aa = aa[-1,]
  bb = cbind(paste(dates[i],aa[,1],sep = "-"),aa[,2:4])
  cc = rbind(cc,bb)
}

colnames(cc) <- c("date","Temperature","RH","WS")
summary(cc) ## 此時爬取下來資料型態為character

## 資料清洗
cc$Temperature <- gsub("^\\s|\\s$", "",cc$Temperature) %>% as.numeric()
cc$RH <- gsub("^\\s|\\s$", "",cc$RH) %>% as.numeric()
cc$WS <- gsub("^\\s|\\s$", "",cc$WS) %>% as.numeric()
summary(cc)
export(cc, "weather_taipei.sav")
