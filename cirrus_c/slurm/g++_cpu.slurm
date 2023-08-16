#!/bin/bash

#SBATCH --exclusive
#SBATCH --partition=standard
#SBATCH --qos=standard
#SBATCH --time=00:20:00
#SBATCH --account=m22oc-s1754999

#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=36

#SBATCH --job-name=g++-cpu
#SBATCH --output=%x-%j.out
#SBATCH --account=m22oc-s1754999

# Load the required modules
module load gcc/8.2.0
module load openmpi/4.1.4-cuda-11.8
module load nvidia/nvhpc-nompi/22.11
module switch -f gcc/12.2.0-gpu-offload

# nvaccelinfo
echo ==========

# uncomment to select the executable
# EXEC=g++_serial_cpu
# EXEC=g++_openmp_cpu
# EXEC=g++_openacc

export OMP_NUM_THREADS=36
export ACC_NUM_COREs=36

echo EXEC_NAME: ${EXEC}_cpu
echo ==========

# run on gpu
srun --cpu-bind=cores ../${EXEC}

# nvidia nsight system
# srun -n 1 nsys profile --gpu-metrics-device=all -o gpu_${EXEC} ../${EXEC}

# nvidia nsight compute
# srun -n 1 ncu --section SpeedOfLight_RooflineChart -o ncu_${EXEC} ../${EXEC}