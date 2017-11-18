\name{tsne}
\alias{tsne}
\title{
t-Distributed Stochastic Neighbor Embedding
}
\description{
Wrapper for a CUDA implementation of Barnes-Hut t-Distributed Stochastic Neighbor Embedding (t-SNE).
t-SNE is a technique for dimensionality reduction that is particularly well suited for the
visualization of high-dimensional datasets. 
}
\usage{
tsne(data, no_dims=2, perplexity=30, theta=0.5, eta=200, exageration=12,
 iterations=1000, verbose=FALSE)
}
\arguments{
  \item{data}{A matrix}
  \item{no_dims}{Output dimensionality}
  \item{perplexity}{Perplexity parameter}
  \item{theta}{Speed vs accuracy trade-off}
  \item{eta}{Learning rate}
  \item{exageration}{exageration parameter}
  \item{iterations}{Number of iterations}
  \item{verbose}{Whether progress updates should be printed}
}
\details{
}
\value{
a matrix containing the new representations for the data
}
\references{
Maaten, L. Van Der, 2014. Accelerating t-SNE using Tree-Based Algorithms.
Journal of Machine Learning Research, 15, p.3221-3245.

van der Maaten, L.J.P. & Hinton, G.E., 2008. Visualizing
High-Dimensional Data Using t-SNE. Journal of Machine Learning
Research, 9, pp.2579-2605.

}


\examples{

\dontrun{
iris_unique = unique(iris)
iris_matrix = as.matrix(iris_unique[,1:4])
ydata = tsne(iris_matrix) # Run TSNE

# Show the objects in the 2D tsne representation
plot(ydata,col=iris_unique$Species)
}


}
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
