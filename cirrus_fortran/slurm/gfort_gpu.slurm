#!/bin/bash

# SBATCH --exclusive
#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00

#SBATCH --job-name=gfort-openmp45-gpu
#SBATCH --output=%x-%j.out
#SBATCH --account=m22oc-s1754999

# Load the required modules
module load gcc/8.2.0
module load openmpi/4.1.4-cuda-11.8
module load nvidia/nvhpc-nompi/22.11
module switch -f gcc/12.2.0-gpu-offload

# nvaccelinfo
echo ==========

EXEC=gfortran_openmp45
# EXEC=gfortran_openacc
# export OMP_NUM_THREADS=1000

echo EXEC_NAME: ${EXEC}_gpu
echo ==========
# run on gpu
# srun -n 1 ../${EXEC}

# nvidia nsight system
# srun -n 1 nsys profile --trace=openmp --gpu-metrics-device=all -o nsys_${EXEC} ../${EXEC}
# srun -n 1 nsys profile --trace=openacc --gpu-metrics-device=all -o nsys_${EXEC} ../${EXEC}
srun -n 1 nsys profile --trace=cuda --gpu-metrics-device=all -o nsys_${EXEC} ../${EXEC}

# nvidia nsight compute
# srun -n 1 ncu --set default -o ncu_${EXEC} ../${EXEC}
# srun -n 1 ncu --section SchedulerStats --section WarpStateStats -o ncu_${EXEC} ../${EXEC}

# nsys profile --gpu-metrics-device=help 
# ncu --list-sets

# nsys profile --gpu-metrics-device=help
