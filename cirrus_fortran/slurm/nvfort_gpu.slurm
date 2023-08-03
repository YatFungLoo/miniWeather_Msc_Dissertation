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

# EXEC=nvhpc_openmp45
EXEC=nvhpc_openacc
# EXEC=nvhpc_do_concurrent

# export OMP_NUM_THREADS=1

echo EXEC_NAME: ${EXEC}_gpu

echo ==========

# run on gpu
srun -n 1 ../${EXEC}

# nvidia nsight system
# srun -n 1 nsys profile --gpu-metrics-device=all -o nsys_${EXEC} ../${EXEC}

# nvidia nsight compute
# srun -n 1 ncu --set default -o ncu_${EXEC} ../${EXEC}
# srun -n 1 ncu --section SchedulerStats --section WarpStateStats -o ncu_${EXEC} ../${EXEC}

# nsys profile --gpu-metrics-device=help 
# ncu --list-sets

#vtune gpu profiling test
# srun -n 1 ../${EXEC} vtune -collect gpu-offload [-knob <knob_name=knob_option>] -- <target> [target_options] 
# srun -n 1 ../${EXEC} vtune -collect gpu-offload 
