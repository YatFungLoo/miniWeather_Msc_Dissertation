#!/bin/bash

# reload default modules
# module purge
# module use /mnt/lustre/indy2lfs/sw/modulefiles
# module load epcc/setup-env

# load nvidia/nvhpc compilers
module load openmpi/4.1.4-cuda-11.8
module load nvidia/nvhpc-nompi/22.11
module switch -f gcc/10.2.0
module load cmake

PARALLEL_NETCDF=/work/m22oc/m22oc/s1754999/Project/PnetCDF_install
export PATH=$PATH:$PARALLEL_NETCDF

./cmake_clean.sh

cmake -DCMAKE_CXX_COMPILER=mpicxx                                        \
      -DCXXFLAGS="-O3 -march=native -std=c++11 -I${PARALLEL_NETCDF}/include" \
      -DLDFLAGS="-L${PARALLEL_NETCDF}/lib -lpnetcdf"            \
      -DOPENMP_FLAGS="-mp -Minfo=mp"                                                                   \
      -DOPENACC_FLAGS="-fopenacc -foffload=\"-lm -latomic\""                                         \
      -DOPENMP45_FLAGS="-fopenmp -foffload=\"-lm -latomic\""                                         \
      -DNX=200                                                            \
      -DNZ=100                                                            \
      -DSIM_TIME=1000                                                     \
      -data_spec_int=DATA_SPEC_MOUNTAIN                                   \
      ..

