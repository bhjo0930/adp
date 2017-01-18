## 유닛 테스팅을 위한 패키지
install.packages("testthat")
library(testthat)

## expect 함수들

#유닛 테스팅은 작성한 코드에 어떤 입력을 주었을 때 예상되는 출력이 실제로 반환되는지 확인하는 것을 기본으로 한다. 기댓값과 실제 반환 값을 비교하기 위해 사용하는 함수의 일부를 다음 표에 정리했다.

a <- 1:3
b <- 1:3
expect_equal(a, b)
expect_equivalent(a, b)
names(a) <- c('a', 'b', 'c')
expect_equal(a, b)       # 벡터에 부여한 이름이 다르므로 테스트가 실패
expect_equivalent(a, b)  # 벡터에 부여한 이름을 무시하므로 테스트 성공

# 실습
fib <- function(n) {
  if (n == 0) {
    return(1)
  }
  if (n > 0) {
    return(fib(n-1) + fib(n-2))
  }
}

expect_equal(1, fib(0))
expect_equal(1, fib(1))
fib(1)

fib <- function(n) {
  if (n == 0 || n == 1) {
#    print(c('n val: ',n))
    return(1)
  }
  if (n >= 2) {
    return(fib(n-1) + fib(n-2))
  }
}

expect_equal(1, fib(1))



# test_that을 사용한 테스트 그룹화
#testthat::test_that : 테스트를 생성한다.
test_that::test_that(
  desc,  # 테스트 이름
  code   # 테스트 코드
)

test_that("base case", {
  expect_equal(1, fib(0))
  expect_equal(1, fib(1))
})


test_that("recursion test", {
  expect_equal(2, fib(2))
  expect_equal(3, fib(3))
  expect_equal(5, fib(4))
})



## 테스트 파일 구조
# trun_tests.R 참고


## 디버깅
# print( )는 주어진 객체를 화면에 출력
# paste : 벡터를 문자열들로 변환한 후 연결
# paste0 : 벡터를 문자열들로 변환한 후 연결한다. paste( )와 달리 sep가 항상 빈 문자열이다

paste('a', 1, 2, 'b', 'c')
paste("A", 1:6, sep="|")
paste0("A", 1:6)

# collapse는 결과를 하나의 문자열로 만들 때 사용하는 구분자
paste("A", 1:6, sep="", collapse=",")

fibo <- function(n) {
  if (n == 1 || n == 2) {
    print(c("base case n:",n))
    return(1)
  }
  print(paste0("fibo(", n - 1, ") + fibo(", n - 2, ")"))
  return(fibo(n - 1) + fibo(n - 2))
}

fibo(3)

#sprintf( )는 print( )와 유사하지만 주어진 인자들을 특정한 규칙에 맞게 문자열로 변환해 출력
sprintf("Number: %d, String: %s", 123, "hello")
sprintf("%.2f", 123.456)
sprintf("%5d", 1234)
#1의 자리 이상의 숫자의 자릿수를 맞춰서 출력해주면 숫자가 주어진 자릿수에 맞춰 우측 정렬되므로 좀 더 보기 좋은 출력물을 얻을 수 있다

#cat: print( )나 sprintf( )는 결과를 출력한 뒤 개행이 일어난다. 반면 cat( )은 주어진 입력을 출력하고 행을 바꾸지 않는다는 특징
cat(1, 2, 3, 4, 5)

sum_to_ten <- function() {
  sum <- 0
  cat("Adding ...")
  for (i in 1:10) {
    sum <- sum + i
    cat(i, "...")
  }
  cat("Done!", "\n")
  return(sum)
}

sum_to_ten()

# browser( )가 호출되면 명령의 수행이 중지되고, 해당 시점부터 디버깅 모드가 시작된다. 디버깅 모드가 되면 browser( )가 호출된 행에서 접근 가능한 변수 및 함수의 내용을 볼 수 있으며, 코드를 한 행씩 실행하거나 다시 browser( )가 호출될 때까지 명령의 실행을 재개할 수 있다.

