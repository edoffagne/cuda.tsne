calculate_knn_distances = function(template_features_sparse_clean=data,
                                   perplexity=perplexity, mem_usage=0.9,
                                   verbose=True)
{
  file = system.file("python", "gpu.py", package="cuda.tsne")
  dir = gsub("gpu.py", "", file)
  mod = import_from_path("gpu", dir)
  res = mod$calculate_knn_distances(template_features_sparse_clean, perplexity)
  return(res)
}
