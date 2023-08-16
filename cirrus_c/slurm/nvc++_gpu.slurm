#!/bin/bash

# SBATCH --exclusive
#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00

#SBATCH --job-name=nvc++-gpu
#SBATCH --output=%x-%j.out
#SBATCH --account=m22oc-s1754999

# Load the required modules
module load nvidia/nvhpc

# Intel vtune profiling option - need fast-debug mode on
module load intel-20.4/compilers
module load intel-20.4/vtune

# nvaccelinfo
echo ==========

EXEC=nvc++_openacc
EXEC=nvc++_openmp45

echo EXEC_NAME: ${EXEC}_gpu
echo ==========

# run on gpu
srun -n 1 ../${EXEC}

# nvidia nsight system
# srun -n 1 nsys profile --gpu-metrics-device=all -o gpu_${EXEC} ../${EXEC}

# nvidia nsight compute
# srun -n 1 ncu --section SpeedOfLight_RooflineChart -o ncu_${EXEC} ../${EXEC}
