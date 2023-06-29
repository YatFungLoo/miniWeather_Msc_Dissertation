#!/bin/bash

# Provided by Michele Weiland, edited by Yat Fung Loo

#SBATCH --account=m22oc-s1754999

#SBATCH --partition=standard
#SBATCH --qos=short
#SBATCH --time=00:05:00

#SBATCH --exclusive
#SBATCH --nodes=1
# SBATCH --ntasks=4                 # must match SLURM_NTASKS_PER_NODE
# SBATCH --tasks-per-node=4         # must match SLURM_TASKS_PER_NODE
# SBATCH --cpus-per-task=2          # must match OMP_NUM_THREADS

#SBATCH --job-name=miniWeather
#SBATCH --output=%x-%j.out
# SBATCH --error=%x-%j.err

echo ${HOME/home/work}

# module load nvidia/nvhpc-byo-compiler/22.11
module load gcc/12.2.0-gpu-offload
# module load openmpi/4.1.4-cuda-11.8
module load openmpi/4.1.4
# module load nvidia/nvhpc-nompi/22.11
# module switch -f gcc/10.2.0

# choose which program to run (serial, mpi, openmp, openac, openmp45)
export EXEC_NAME=openmp45
export SLURM_NTASKS_PER_NODE=4      # total number of task across all node(s)
export SLURM_TASKS_PER_NODE=4       # number of maximum mpi task (rank) per node
export OMP_NUM_THREADS=2            # openmp num threads per task

echo EXEC_NAME: ${EXEC_NAME}
echo SLURM_NTASKS_PER_NODE: ${SLURM_NTASKS_PER_NODE}
echo SLURM_TASKS_PER_NODE: ${SLURM_TASKS_PER_NODE}
echo OMP_NUM_THREADS: ${OMP_NUM_THREADS}

# launch job 
mpirun -n ${SLURM_NTASKS_PER_NODE} -N ${SLURM_TASKS_PER_NODE} ./build/${EXEC_NAME}
