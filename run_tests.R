require(testthat)
source("fibo.R")

Sys.getlocale()
#Sys.setlocale('LC_ALL','C') 

#Run all of the tests in a directory.
test_dir("tests", reporter="summary")

#expect_equal(0, fibo(5))을 추가하면
#fibonacci series 테스트 수행 중 recursion test에서 에러가 발생했고, fibo(5)의 반환 값이 0이 아님을 알 수 있다.