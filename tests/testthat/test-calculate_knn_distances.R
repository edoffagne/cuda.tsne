source("utils.R")

test_that('calculate_knn_distances returns expected results', {
  skip_if_no_accelerate()
  set.seed(123)
  iris_unique = unique(iris) # Remove duplicates
  iris_matrix = as.matrix(iris_unique[,1:4])
  d = cuda.tsne:::calculate_knn_distances(template_features_sparse_clean=iris_matrix,
                            perplexity=30, mem_usage=0.9,
                            verbose=FALSE)

  expect_equal(length(d), 3)
  expect_equal(length(d[[1]]), 13559)
  expect_equal(length(d[[2]]), 13559)
  expect_equal(d[[3]], 91)
})


