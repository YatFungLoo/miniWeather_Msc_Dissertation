#!/bin/bash

# NOT TESTED

# reload default modules
module purge
module use /mnt/lustre/indy2lfs/sw/modulefiles
module load epcc/setup-env

# load nvidia/nvhpc compilers
module load openmpi/4.1.4-cuda-11.8
module load nvidia/nvhpc-nompi/22.11
module load cmake

PARALLEL_NETCDF=/work/m22oc/m22oc/s1754999/Project/PnetCDF_install
export PATH=$PATH:$PARALLEL_NETCDF

./cmake_clean.sh

# cmake -DCMAKE_CXX_COMPILER=nvcc                                          \
#       -DCXXFLAGS="-O3 -march=native -std=c++11 -I${PARALLEL_NETCDF}/include "-I${MPI_HOME}/include        \
#       -DLDFLAGS="-L${MPI_HOME}/lib -L${PARALLEL_NETCDF}/lib -lmpi -lpnetcdf"                      \
#       -DOPENMP_FLAGS="-mp -Minfo=mp"                                      \
#       -DOPENACC_FLAGS="-fopenacc -foffload=\"-lm -latomic\""              \
#       -DOPENMP45_FLAGS="-fopenmp -foffload=\"-lm -latomic\""              \
#       -DNX=200                                                            \
#       -DNZ=100                                                            \
#       -DSIM_TIME=1000                                                     \
#       -DDATA_SPEC="DATA_SPEC_GRAVITY_WAVES"                               \
#       ..