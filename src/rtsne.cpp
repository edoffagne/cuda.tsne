#include<R.h>
#include<Rmath.h>
#include<Rdefines.h>
#include<stdlib.h>
#include "sp_tsne.h"

extern "C" SEXP run_tsne(SEXP sorted_distances_in, SEXP sorted_indices_in, SEXP N_in,
                        SEXP no_dims_in, SEXP K_in, SEXP perplexity_in, SEXP theta_in,
                        SEXP eta_in, SEXP exageration_in, SEXP iterations_in, SEXP verbose_in) {

  PROTECT(sorted_distances_in = AS_NUMERIC(sorted_distances_in));
  double *sorted_distances;
  sorted_distances =  NUMERIC_POINTER(sorted_distances_in);

  PROTECT(sorted_indices_in = AS_NUMERIC(sorted_indices_in));
  double *sorted_i;
  sorted_i = NUMERIC_POINTER(sorted_indices_in);
  int lsi = LENGTH(sorted_indices_in);
  int* sorted_indices = (int*) malloc(lsi * sizeof(int));
  for (int i = 0; i < lsi; i++) 
  { sorted_indices[i] = (int) sorted_i[i]; }

  PROTECT(N_in = AS_NUMERIC(N_in));
  double *xN;
  xN = NUMERIC_POINTER(N_in);
  int N = (int) * xN;

  PROTECT(K_in = AS_NUMERIC(K_in));
  double *xK;
  xK = NUMERIC_POINTER(K_in);
  int K = (int) * xK;

  PROTECT(no_dims_in = AS_NUMERIC(no_dims_in));
  double *xno_dims;
  xno_dims = NUMERIC_POINTER(no_dims_in);
  int no_dims = (int) * xno_dims;

  PROTECT(perplexity_in = AS_NUMERIC(perplexity_in));
  double *xperplexity;
  xperplexity =  NUMERIC_POINTER(perplexity_in);
  int perplexity = (int) * xperplexity;

  PROTECT(eta_in = AS_NUMERIC(eta_in));
  double * eta;
  eta =  NUMERIC_POINTER(eta_in);

  PROTECT(theta_in = AS_NUMERIC(theta_in));
  double * theta;
  theta =  NUMERIC_POINTER(theta_in);

  PROTECT(exageration_in = AS_NUMERIC(exageration_in));
  double * exageration;
  exageration =  NUMERIC_POINTER(exageration_in);

  PROTECT(iterations_in = AS_NUMERIC(iterations_in));
  double * xiterations = NUMERIC_POINTER(iterations_in);
  int iterations = (int) * xiterations;

  PROTECT(verbose_in = AS_NUMERIC(verbose_in));
  double *xverbose;
  xverbose =  NUMERIC_POINTER(verbose_in);
  int verbose = (int) * xverbose;

  double *xresult;
  SEXP result;
  int rl = no_dims * N;
  PROTECT(result = NEW_NUMERIC(rl));
  xresult = NUMERIC_POINTER(result);
  
  double* Y = (double*) malloc(N * no_dims * sizeof(double));
  TSNE tsne;

  tsne.run(sorted_distances, sorted_indices, N, no_dims, K,
            perplexity, *theta, *eta, *exageration, iterations, verbose, Y);

  /* Construct the output (transpose) */
  for(int i = 0; i < N; i++) {
    for(int j = 0; j < no_dims; j++) {
       xresult[j * N + i] = Y[i * no_dims + j];
    }
  }

  /* Clean up memory */
  free(Y);
  free(sorted_indices);
  UNPROTECT(12);
  return result;
}


