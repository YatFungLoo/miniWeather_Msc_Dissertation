#!/bin/bash

# SBATCH --exclusive
#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00

#SBATCH --job-name=nvfort-openacc-gpu
#SBATCH --output=%x-%j.out
#SBATCH --account=m22oc-s1754999

# Load the required modules
module load nvidia/nvhpc

# nvaccelinfo
echo ==========

# uncomment to select the executable
# EXEC=nvfort_openacc
# EXEC=nvfort_openmp45
# EXEC=nvfort_openacc
# EXEC=nvfort_do-concurrent

export OMP_NUM_THREADS=36
export ACC_NUM_COREs=36

echo EXEC_NAME: ${EXEC}_gpu

echo ==========

# run on gpu
srun -n 1 ../${EXEC}

# nvidia nsight system
# srun -n 1 nsys profile --trace=cuda --gpu-metrics-device=all -o nsys_${EXEC} ../${EXEC}

# nvidia nsight compute
# srun -n 1 ncu --set default -o ncu_${EXEC} ../${EXEC}
# srun -n 1 ncu --section SchedulerStats --section WarpStateStats -o ncu_${EXEC} ../${EXEC}