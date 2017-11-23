
skip_if_no_accelerate <- function() {
  if (!reticulate::py_module_available("accelerate"))
    skip("Accelerate not available for testing")
}
