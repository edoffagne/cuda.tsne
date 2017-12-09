
#' t-Distributed Stochastic Neighbor Embedding
#'
#' Wrapper for a CUDA implementation of Barnes-Hut t-Distributed Stochastic Neighbor Embedding (t-SNE).
#' t-SNE is a technique for dimensionality reduction that is particularly well suited for the
#' visualization of high-dimensional datasets.
#'
#'
#' @usage tsne(data, no_dims=2, perplexity=30, theta=0.5, eta=200, exageration=12,
#'             iterations=1000, verbose=FALSE)
#'
#' @param data A matrix
#' @param no_dims Output dimensionality
#' @param perplexity Perplexity parameter
#' @param theta Speed vs accuracy trade-off
#' @param eta Learning rate
#' @param exageration exageration parameter
#' @param iterations Number of iterations
#' @param verbose Whether progress updates should be printed
#'
#' @return A matrix containing the new representations for the data
#' @references Maaten, L. Van Der, 2014. Accelerating t-SNE using Tree-Based Algorithms.
#'             Journal of Machine Learning Research, 15, p.3221-3245.
#'
#'             van der Maaten, L.J.P. & Hinton, G.E., 2008. Visualizing
#'             High-Dimensional Data Using t-SNE. Journal of Machine Learning
#'             Research, 9, pp.2579-2605.
#' @rdname tsne
#' @export
#' @useDynLib cuda.tsne
#' @import reticulate

tsne = function(data, no_dims=2, perplexity=30, theta=0.5, eta=200, exageration=12,
               iterations=1000, verbose=FALSE)
{ 
  is.wholenumber <- function(x, tol = .Machine$double.eps^0.5)  abs(x - round(x)) < tol
 
  if (nrow(data) - 1 < 3 * perplexity) { stop("Perplexity is too large.")}
  if (!is.matrix(data)) { stop("Input data must be a matrix.")}
  if (!is.wholenumber(no_dims) || (no_dims < 2))  { stop("Incorrect dimensionality.")}
  if (!is.numeric(theta) || (theta<0.0) || (theta>1.0) ) { stop("Incorrect theta provided.")}
  if (!is.numeric(eta) ) { stop("Incorrect eta provided.")}
  if (!is.numeric(exageration)) { stop("exageration must be numeric")} 
  if (!(iterations>0)  || !is.wholenumber(iterations)) { stop("Number of iterations must be a positive integer.")}
  
  d = calculate_knn_distances(template_features_sparse_clean=data,
                                   perplexity=perplexity, mem_usage=0.9,
                                   verbose=verbose)
  if (verbose == TRUE) int_verbose = 2 
  else int_verbose = 1
  N = as.integer(nrow(data))
  no_dims = as.integer(no_dims)
  res = .Call("run_tsne", d[[2]], d[[1]], N, no_dims, d[[3]], perplexity, theta, eta, 
              exageration, iterations, int_verbose, PACKAGE='cuda.tsne')
  res = matrix(res, ncol=2)
  return(res)
}

