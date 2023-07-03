#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00

#SBATCH --job-name=gfort-gpu
#SBATCH --output=%x-%j.out
#SBATCH --account=m22oc-s1754999

# Load the required modules
module load gcc/12.2.0-gpu-offload

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/lustre/indy2lfs/sw/cuda/9.0/lib64
export OMP_NUM_THREADS=2

srun -n 1 ../openmp45_gcc12
