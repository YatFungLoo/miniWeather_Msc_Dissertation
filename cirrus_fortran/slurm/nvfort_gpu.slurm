#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --gres=gpu:4
#SBATCH --time=00:10:00

#SBATCH --job-name=nvfort-gpu
#SBATCH --output=%x-%j.out
#SBATCH --account=m22oc-s1754999

# Load the required modules
module load nvidia/nvhpc

# nvaccelinfo
echo ==========

EXEC=
# export OMP_NUM_THREADS=1

echo EXEC_NAME: ${EXEC}
echo ==========
# run on gpu
# srun -n 1 ../${EXEC}

# nvidia nsight system
# srun -n 1 nsys profile --gpu-metrics-device=all -o gpu_${EXEC} ../${EXEC}

# nvidia nsight compute
# srun -n 1 ncu --section SpeedOfLight_RooflineChart -o ncu_${EXEC} ../${EXEC}

# nsys profile --gpu-metrics-device=help