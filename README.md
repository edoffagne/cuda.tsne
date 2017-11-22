# Cuda Implementation of t-SNE


[![Build Status](https://travis-ci.org/erikdf/cuda.tsne.svg?branch=master)](https://travis-ci.org/erikdf/cuda.tsne)

## Introduction

**Disclaimer** : This project is a work in progress and is not yet stable.

Wrapper for a CUDA implementation of Barnes-Hut t-Distributed Stochastic Neighbor Embedding (t-SNE).
t-SNE is a technique for dimensionality reduction that is particularly well suited for the
visualization of high-dimensional datasets.

This package exposes a CUDA extension of the C++ t-SNE with barnes-hut algorithm written by [Laurens van der Maaten](https://lvdmaaten.github.io/). The CUDA extension has been developed by [George Dimitriadis](https://github.com/georgedimitriadis/t_sne_bhcuda).  

Barnes-Hut t-SNE algorithm is done in two parts.

* First part: a data structure for nearest neighbours search is
built and used to compute probabilities. This can be done in parallel for each point in the dataset.
This is the most time consuming part and this is where GPU can be used to speed-up the execution time. This part calls Python with Accelerate to handle the CUDA
interfacing.
 
* Second part: the embedding is optimized using gradient descent.
This part is performed in C++ (with only one core).

## Benchmark

[The Street View House Numbers (SVHN) Dataset](http://ufldl.stanford.edu/housenumbers/) has been used for the benchmark.
The dataset contains 73,257 images (32x32 RGB) obtained from house numbers in Google Street View images. 
A convolutional network has been used to extract input features for the t-SNE algorithm.

The benchmark compares the [Rtsne](https://cran.r-project.org/web/packages/Rtsne/index.html) package
which wraps the original C++ implementation of BH t-SNE and the cuda.tsne package.

The following machines have been used for the benchmark: 

* **p2.xlarge** with Intel Xeon E5-2686 v4 (Broadwell) processor and NVIDIA K80 GPU (2,496 parallel processing cores 
and 12GiB of GPU memory).
  
* **m4.large** with Intel Xeon E5-2686 v4 (Broadwell).

| Step               | Rtsne       | cuda.tsne    |
| ------------------ | ----------- |-------------:|
| Building tree      | 3370 sec    | 237 sec      |
| Learning embedding | 1315 sec    | 1604 sec     |
| Total              | 4685 sec    | 1841 sec     |

The following parameters used: number of dimensions=2, perplexity=50, theta=0.5, eta=200, exageration=12 
and iterations=1000.

## Installation

### Ubuntu 16.04

The machine must have CUDA 8 installed along with the Nvidia drivers.

Download and launch the conda installer. Please note that version 3 needs to be used.

```shell
$ wget https://repo.continuum.io/archive/Anaconda3-5.0.1-MacOSX-x86_64.sh
$ bash Anaconda3-5.0.1-MacOSX-x86_64.sh
```

Create a virtual environment.

```shell
$ conda create --name my_env python=3
$ source activate my_env
```
Install Accelerate.

```shell
$ conda install accelerate
```

```shell
$ R -e "devtools::install_github('erikdf/cuda.tsne')"
```


## References 

* Maaten, L. Van Der, 2014. Accelerating t-SNE using Tree-Based Algorithms.
Journal of Machine Learning Research, 15, p.3221-3245.

* van der Maaten, L.J.P. & Hinton, G.E., 2008. Visualizing
High-Dimensional Data Using t-SNE. Journal of Machine Learning
Research, 9, pp.2579-2605.
 
