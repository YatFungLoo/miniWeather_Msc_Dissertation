#!/bin/bash

# reload default modules
# module purge
# module use /mnt/lustre/indy2lfs/sw/modulefiles
# module load epcc/setup-env

# # load gcc compilers
module load gcc/12.2.0-gpu-offload
module load openmpi/4.1.4-cuda-11.6 
module load cmake

PARALLEL_NETCDF=/work/m22oc/m22oc/s1754999/Project/PnetCDF_install
export PATH=$PATH:$PARALLEL_NETCDF

./cmake_clean.sh

cmake -DCMAKE_CXX_COMPILER=mpicxx                                        \
      -DCXXFLAGS="-O3 -march=native -std=c++11 -I${PARALLEL_NETCDF}/include" \
      -DLDFLAGS="-L${PARALLEL_NETCDF}/lib -lpnetcdf"            \
      -DOPENMP_FLAGS="-fopenmp"                                           \
      -DOPENACC_FLAGS="-fopenacc -foffload=\"-lm -latomic\""                                         \
      -DOPENMP45_FLAGS="-fopenmp -foffload=\"-lm -latomic\""                                         \
      -DNX=200                                                            \
      -DNZ=100                                                            \
      -DSIM_TIME=1000                                                     \
      -data_spec_int=DATA_SPEC_MOUNTAIN                                   \
      ..

