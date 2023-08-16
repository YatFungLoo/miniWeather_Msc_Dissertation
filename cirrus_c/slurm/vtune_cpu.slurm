#!/bin/bash

# Provided by Michele Weiland, edited by Yat Fung Loo
# slurm script for intel vtune (for serial)

#SBATCH --partition=standard
#SBATCH --qos=short
#SBATCH --time=00:05:00
#SBATCH --account=m22oc-s1754999

echo ${HOME/home/work}

# oneapi for intel compilers 22
#module load nvidia/nvhpc-byo-compiler/22.11
module load gcc/12.2.0-gpu-offload
module load openmpi/4.1.4-cuda-11.8
# module load nvidia/nvhpc-nompi/22.11
# module switch -f gcc/10.2.0

# Intel vtune profiling option - need fast-debug mode on
module load intel-20.4/compilers
module load intel-20.4/vtune

export OMP_NUM_THREADS=5
export SLURM_NTASKS_PER_NODE=1
export SLURM_TASKS_PER_NODE=1

# for serial+parallel job
# mpirun -n ${SLURM_NTASKS_PER_NODE} -N ${SLURM_TASKS_PER_NODE} ./build/mpi

# https://cirrus.readthedocs.io/en/main/software-tools/intel-vtune.html?highlight=vtune
# https://www.intel.com/content/www/us/en/docs/vtune-profiler/user-guide/2023-0/collect.html

# hotspots
mpirun -n ${SLURM_NTASKS_PER_NODE} -N ${SLURM_TASKS_PER_NODE} vtune -collect hotspots -r vtune-hotspots \
       ./build/serial

# memory-consumption
# mpirun -n ${SLURM_NTASKS_PER_NODE} -N ${SLURM_TASKS_PER_NODE} vtune -collect memory-consumption -r vtune-memory-consumption \
#        ./build/mpi