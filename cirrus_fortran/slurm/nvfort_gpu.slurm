#!/bin/bash

#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00

#SBATCH --job-name=nvfort-gpu
#SBATCH --output=%x-%j.out
#SBATCH --account=m22oc-s1754999

# Load the required modules
module load nvidia/nvhpc
# export OMP_NUM_THREADS=2

EXEC=nvhpc_openacc_test
# export OMP_NUM_THREADS=1

echo EXEC_NAME: ${EXEC}
srun -n 1 ../${EXEC}
