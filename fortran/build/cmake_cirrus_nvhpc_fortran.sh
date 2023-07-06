#!/bin/bash

# Provided by Alexie Borissov, edited by Yat Fung Loo
# Note: not tested

# reload default modules
module purge
module use /mnt/lustre/indy2lfs/sw/modulefiles
module load epcc/setup-env

# load nvidia compilers
module load openmpi/4.1.4-cuda-11.8
module load nvidia/nvhpc-nompi/22.11

PARALLEL_NETCDF=/work/m22oc/m22oc/s1754999/Project/PnetCDF_install
export PATH=$PATH:$PARALLEL_NETCDF

./cmake_clean.sh

cmake -DCMAKE_Fortran_COMPILER=mpif90                                                                  \
      -DFFLAGS="-O3 -ffree-line-length-none -I${PARALLEL_NETCDF}/include"                \
      -DLDFLAGS="-L${PARALLEL_NETCDF}/lib -lpnetcdf"                                         \
      -DOPENMP_FLAGS="-mp -Minfo=mp"                                                                   \
      -DOPENACC_FLAGS:STRING="-acc -gpu=cc70,fastmath,loadcache:L1,ptxinfo -Minfo=accel"               \
      -DOPENMP45_FLAGS="-Minfo=mp -mp=gpu -gpu=cc70,fastmath,loadcache:L1,ptxinfo"                     \
      -DDO_CONCURRENT_FLAGS:STRING="-stdpar=gpu -Minfo=stdpar -gpu=cc70,fastmath,loadcache:L1,ptxinfo" \
      -DNX=200                                                                                         \
      -DNZ=100                                                                                         \
      -DSIM_TIME=1000                                                                                  \
      -DOUT_FREQ=2000                                                                                  \
      ..

