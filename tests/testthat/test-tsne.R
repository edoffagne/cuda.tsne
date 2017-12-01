source("utils.R")

test_that('t-SNE returns expected results', {

  set.seed(123)
  iris_unique = unique(iris) 
  iris_matrix = as.matrix(iris_unique[,1:4])
  Y = tsne(iris_matrix)
  expect_equal(Y[1,1], 16.74606, tolerance = 0.00001)
  expect_equal(Y[1,2], 0.1206355, tolerance = 0.00001)

})

