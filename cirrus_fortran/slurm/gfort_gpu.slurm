#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --gres=gpu:4
#SBATCH --time=00:10:00

#SBATCH --job-name=gcc-gpu
#SBATCH --output=%x-%j.out
#SBATCH --account=m22oc-s1754999

# Load the required modules
module load gcc/8.2.0
module load openmpi/4.1.4-cuda-11.8
module load nvidia/nvhpc-nompi/22.11
module switch -f gcc/12.2.0-gpu-offload

nvaccelinfo
echo ==========

EXEC=gcc_openmp45_test
# export OMP_NUM_THREADS=1

echo EXEC_NAME: ${EXEC}
echo ==========
srun -n 1 ../${EXEC}
