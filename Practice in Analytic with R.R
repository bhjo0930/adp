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
    print(c('n val: ',n))
    return(1)
  }
  if (n > 1) {
    return(fib(n-1) + fib(n-2))
  }
}

expect_equal(1, fib(1))



