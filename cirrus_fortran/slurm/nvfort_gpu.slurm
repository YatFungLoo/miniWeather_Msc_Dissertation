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

# Intel vtune profiling option - need fast-debug mode on
module load intel-20.4/compilers
module load intel-20.4/vtune

# nvaccelinfo
echo ==========

EXEC=nvfort_openacc
# EXEC1=nvfort_openmp45
# EXEC2=nvfort_openacc
# EXEC3=nvfort_do-concurrent

export OMP_NUM_THREADS=36
export ACC_NUM_COREs=36

echo EXEC_NAME: ${EXEC}_gpu

echo ==========

run on gpu
srun -n 1 ../${EXEC}

# nvidia nsight system
# srun -n 1 nsys profile --trace=openmp --gpu-metrics-device=all -o nsys_${EXEC} ../${EXEC}
# srun -n 1 nsys profile --trace=openacc --gpu-metrics-device=all -o nsys_${EXEC}_managed ../${EXEC}

# srun -n 1 nsys profile --trace=cuda --gpu-metrics-device=all -o nsys_${EXEC1}_100_cuda ../${EXEC1}
# srun -n 1 nsys profile --trace=cuda --gpu-metrics-device=all -o nsys_${EXEC2}_100_cuda ../${EXEC2}
# srun -n 1 nsys profile --trace=cuda --gpu-metrics-device=all -o nsys_${EXEC3}_100_cuda ../${EXEC3}

# nvidia nsight compute
# srun -n 1 ncu --set default -o ncu_${EXEC} ../${EXEC}
# srun -n 1 ncu --section SchedulerStats --section WarpStateStats -o ncu_${EXEC} ../${EXEC}

# nsys profile --gpu-metrics-device=help 
# ncu --list-sets

#vtune gpu profiling test
# srun -n 1 ../${EXEC} vtune -collect gpu-offload [-knob <knob_name=knob_option>] -- <target> [target_options] 
# srun -n 1 ../${EXEC} vtune -collect gpu-offload 
