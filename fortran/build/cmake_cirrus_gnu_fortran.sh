#!/bin/bash

# Provided by Alexie Borissov, edited by Yat Fung Loo
# Bug: there is a bug with openmp45 (target offloading)

# reload default modules
module purge
module use /mnt/lustre/indy2lfs/sw/modulefiles
module load epcc/setup-env

# # load gcc compilers
module load gcc/12.2.0-gpu-offload
module load openmpi/4.1.4-cuda-11.6 cmake

PARALLEL_NETCDF=/work/m22oc/m22oc/s1754999/Project/PnetCDF_install
export PATH=$PATH:$PARALLEL_NETCDF

./cmake_clean.sh

cmake -DCMAKE_Fortran_COMPILER=mpif90                                                 \
      -DFFLAGS="-O3 -g -ffree-line-length-none -I${PARALLEL_NETCDF}/include"          \
      -DLDFLAGS="-L${PARALLEL_NETCDF}/lib -lpnetcdf"                                  \
      -DOPENACC_FLAGS="-fopenacc -foffload=\"-lm -latomic\""                          \
      -DOPENMP_FLAGS="-fopenmp"                                                       \
      -DOPENMP45_FLAGS="-fopenmp -foffload=nvptx-none=\"-lm -latomic\""                          \
      -DNX=200                                                                        \
      -DNZ=100                                                                        \
      -DSIM_TIME=1000                                                                 \
      -DOUT_FREQ=10000                                                                  \
      ..
