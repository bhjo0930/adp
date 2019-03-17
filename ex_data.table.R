library(dplyr)
library(ggplot2)
#install.packages('data.table')
library(data.table)

ggplot2::diamonds
class(diamonds)

mydata.origin = fread("https://github.com/arunsrinivasan/satrdays-workshop/raw/master/flights_2014.csv")
mydata<-as.data.table(mydata.origin)

nrow(mydata)
names(mydata)
head(mydata)

dat1 = mydata[ , origin] # returns a vector
dat1 = mydata[ , .(origin)] # returns a data.table
dat1 = mydata[, c("origin"), with=FALSE]
dat2 =mydata[, 2, with=FALSE]
dat3 = mydata[, .(origin, year, month, hour)]

dat6 = mydata[, !c("origin", "year", "month"), with=FALSE] #Dropping Multiple Columns
dat7 = mydata[,names(mydata) %like% "dep", with=FALSE] #Keeping variables that contain 'dep'

setnames(mydata, c("dest"), c("Destination")) #Rename Variables
dat8 = mydata[origin == "JFK"]
dat9 = mydata[origin %in% c("JFK", "LGA")] #Select Multiple Values
dat10 = mydata[!origin %in% c("JFK", "LGA")] #Apply Logical Operator : NOT

dat11 = mydata[origin == "JFK" & carrier == "AA"] #Filter based on Multiple variables
mydata01 = setorder(mydata, origin) #Sorting Data
mydata02 = setorder(mydata, -origin)

mydata[, dep_sch:=dep_time - dep_delay] #Adding Columns (Calculation on rows)
mydata002 = mydata[, c("dep_sch","arr_sch"):=list(dep_time - dep_delay, arr_time - arr_delay)]

mydata[, dep_sch:=dep_time - dep_delay][,.(dep_time,dep_delay,dep_sch)]

mydata[, .(mean = mean(arr_delay, na.rm = TRUE),
           median = median(arr_delay, na.rm = TRUE),
           min = min(arr_delay, na.rm = TRUE),
           max = max(arr_delay, na.rm = TRUE))]

mydata[, .(mean(arr_delay), mean(dep_delay))] #Summarize Multiple Columns
#.SD and .SDcols operators. The .SD operator implies 'Subset of Data'. 
mydata[, lapply(.SD, mean), .SDcols = c("arr_delay", "dep_delay")] 

mydata[, lapply(.SD, mean)]
mydata[, sapply(.SD, function(x) c(mean=mean(x), median=median(x)))]

mydata[, .(mean_arr_delay = mean(arr_delay, na.rm = TRUE)), by = origin]

mydata[, .(mean_arr_delay = mean(arr_delay, na.rm = TRUE)), keyby = origin]
mydata[, .(mean(arr_delay, na.rm = TRUE), mean(dep_delay, na.rm = TRUE)), by = origin]

setkey(mydata, "carrier")
unique(mydata)

setkey(mydata, NULL)
unique(mydata)

head(mydata[, .SD[1:2], by=carrier]) #selects first and second values from a categorical variable carrier
mydata[, .SD[.N], by=carrier] #Select LAST value from a group

dt = mydata[, rank:=frank(-distance,ties.method = "min"), by=carrier] #SQL's RANK OVER PARTITION
dat = mydata[, cum:=cumsum(distance), by=carrier] # Cumulative SUM by GROUP

DT <- data.table(A=1:5)
DT[ , X := shift(A, 1, type="lag")]
DT[ , Y := shift(A, 1, type="lead")]
DT

(dt1 <- data.table(A = letters[rep(1:3, 2)], X = 1:6, key = "A"))
(dt2 <- data.table(A = letters[rep(2:4, 2)], Y = 6:1, key = "A"))

merge(dt1, dt2, by="A")
merge(dt1, dt2, by="A", all.x = TRUE)
merge(dt1, dt2, by="A", all.y = TRUE)
merge(dt1, dt2, all=TRUE)

setDF(mydata) #Convert a data.table to data.frame
str(mydata)

s1 <- "family_id age_mother dob_child1 dob_child2 dob_child3
1         30 1998-11-26 2000-01-29         NA
2         27 1996-06-22         NA         NA
3         26 2002-07-11 2004-04-05 2007-09-02
4         32 2004-10-10 2009-08-27 2012-07-21
5         29 2000-12-05 2005-02-28         NA"
DT <- fread(s1)
DT
DT.m1 = melt(DT, id.vars = c("family_id", "age_mother"),
             measure.vars = c("dob_child1", "dob_child2", "dob_child3"),
             variable.name = "child", value.name = "dob")

dcast(DT.m1, family_id + age_mother ~ child, value.var = "dob")

s2<-"cust_id,prod_id,amt
1,prod01,100
1,prod02,200 
11,prod02,300
21,prod03,100 
31,prod01,100
31,prod02,200 
41,prod02,300
51,prod03,100 
61,prod01,100
61,prod02,200 
71,prod02,300
71,prod03,100 
"
DT <- fread(s2)
DT
DT.dcast<-dcast(DT, cust_id ~ prod_id, value.var = "amt")

DT.dcast[,names(DT.dcast) %like% "prod", with=FALSE] #Keeping variables that contain 'dep'

DT.res<-DT.dcast[, sapply(.SD, function(x) ifelse (!is.na(x),ifelse(x>100,1,0),0))]

summary(DT.res)
setDF(DT.res)
DT.res<-as.data.frame(DT.res)
names(DT.res)

cor(
  DT.res[,c("prod01","prod02","prod03")],      # 숫자 벡터, 행렬, 데이터 프레임
  y=NULL, # NULL, 벡터, 행렬 또는 데이터 프레임
  # 계산할 상관 계수의 종류를 지정한다. 피어슨(pearson), 켄달(kendall), 스피어만(spearman)을
  # 지정할 수 있으며 기본값은 피어슨이다.
  method=c("pearson")
)
mt<-mtcars
mt$name<-row.names(mt)
str(mt)

cor(mt[,1:11],mt[,1:11],use = "all.obs",method = c("pearson"))

cor(mt[1,1:11],mt[2,1:11], method = "pearson", use = "complete.obs")

install.packages('lsa')
library(lsa)

cosine(c(mt[1,1:11]),c(mt[2,1:11]))

df <- matrix(ncol=nrow(mt), nrow=nrow(mt))

for (i in 1:nrow(mt))
  for (j in 1:nrow(mt)){
    x<-cor(c(t(mt[i,-12])),c(t(mt[j,-12])))
    #print (x)
    df[i,j] <- x
  }

head(df)

df<-data.frame(a=1:nrow(mt),b=1:nrow(mt),x)
cor(c(t(mt[1,-12])),c(t(mt[2,-12])))
