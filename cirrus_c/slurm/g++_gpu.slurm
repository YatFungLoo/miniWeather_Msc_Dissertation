#!/bin/bash

# SBATCH --exclusive
#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00

#SBATCH --job-name=g++-gpu
#SBATCH --output=%x-%j.out
#SBATCH --account=m22oc-s1754999

# Load the required modules
module load gcc/8.2.0
module load openmpi/4.1.4-cuda-11.8
module load nvidia/nvhpc-nompi/22.11
module switch -f gcc/12.2.0-gpu-offload

echo ==========

# uncomment to select the executable
# EXEC=g++_openmp45_gpu
# EXEC=g++_openacc

echo EXEC_NAME: ${EXEC}_gpu
echo ==========

# run on gpu
srun -n 1 ../${EXEC}
