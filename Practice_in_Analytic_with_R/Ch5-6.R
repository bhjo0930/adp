## 06 | 더 나은 반복문
#foreach[8] apply() 계열 함수, for( ) 문 등을 대체할 수 있는 루프문을 위한 함수
#for 문과의 가장 큰 차이는 반환 값이 있고, { }가 아닌 %do% 문을 사용해 블록을 지정한다는 점
install.packages("foreach")
library(foreach)

foreach(i=1:5) %do% {
  return(i)
}

#.combine=c를 지정하면 결과를 벡터로 받는다.
foreach(i=1:5, .combine=c) %do% {
   return(i)
 }

#.combine에 rbind를 지정하면 결과를 행 방향으로 합친 데이터 프레임을 반환하며, cbind를 지정하면 컬럼 방향으로 합친다.
foreach(i=1:5, .combine=rbind) %do% {
   return(data.frame(val=i))
}

d<-foreach(i=1:5, .combine=cbind) %do% {
   return(data.frame(val=i))
 }

foreach(i=1:10, .combine="+") %do% {
   return(i)
}


