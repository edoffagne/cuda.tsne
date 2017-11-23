
source("utils.R")

test_that('Input must be a matrix', {

  expect_error(tsne(iris)) 
  
})
