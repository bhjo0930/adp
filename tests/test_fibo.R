#첫 행에는 해당 파일 내 테스트들이 무엇에 대한 테스트인지를 명시하기 위해 context(“fibonacci series”)를 적는다
#여러 테스트 파일을 작성하게 된다면 context( )에 기록한 정보가 유용하게 사용된다.
context("fibonacci series")

test_that("base test", {
  expect_equal(1, fibo(0))
  expect_equal(1, fibo(1))
})

test_that("recursion test", {
  expect_equal(2, fibo(2))
  expect_equal(3, fibo(3))
  expect_equal(5, fibo(4))
  #expect_equal(0, fibo(5))
})
