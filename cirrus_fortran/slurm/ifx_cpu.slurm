#!/bin/bash

#SBATCH --exclusive
#SBATCH --partition=standard
#SBATCH --qos=standard
#SBATCH --time=00:20:00
#SBATCH --account=m22oc-s1754999

#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=36

#SBATCH --job-name=ifx-do-concurrent-cpu
#SBATCH --output=%x-%j.out
#SBATCH --account=m22oc-s1754999

# Load the required modules
module load oneapi
source /mnt/lustre/indy2lfs/sw/oneapi/2022.2.0.191/setvars.sh

# Intel vtune profiling option - need fast-debug mode on
module load intel-20.4/compilers
module load intel-20.4/vtune

# lscpu
echo ==========

EXEC=ifx_serial
# EXEC=ifx_openmp
# EXEC=ifx_do-concurrent
export OMP_NUM_THREADS=36
export ACC_NUM_COREs=36

echo EXEC_NAME: ${EXEC}
echo ==========

# run on cpu 
srun --cpu-bind=cores ../${EXEC}

# EXEC=ifx_serial
# srun --cpu-bind=cores ../${EXEC}
# EXEC=ifx_openmp
# srun --cpu-bind=cores ../${EXEC}
# EXEC=ifx_do-concurrent
# srun --cpu-bind=cores ../${EXEC}

# vtune hotspots
# srun --cpu-bind=cores vtune -collect hotspots -r vtune-hotspots  ../${EXEC}
2