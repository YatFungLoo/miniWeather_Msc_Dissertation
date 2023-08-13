#!/bin/bash

# SBATCH --exclusive
#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00

#SBATCH --job-name=gfort-g++-gpu
#SBATCH --output=%x-%j.out
#SBATCH --account=m22oc-s1754999

# Load the required modules
module load gcc/8.2.0
module load openmpi/4.1.4-cuda-11.8
module load nvidia/nvhpc-nompi/22.11
module switch -f gcc/12.2.0-gpu-offload

# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/lustre/indy2lfs/sw/cuda/9.0/lib64
# export OMP_NUM_THREADS=2
echo ==========

EXEC=g++_openmp45_test
export OMP_NUM_THREADS=32
# export OMP_THREAD_LIMIT=40000

echo EXEC_NAME: ${EXEC}_gpu
echo ==========

srun -n 1 ../${EXEC}
# srun -n 1 nsys profile --trace=cuda --gpu-metrics-device=all -o nsys_${EXEC} ../${EXEC}
