#!/bin/bash

#SBATCH --exclusive
#SBATCH --partition=standard
#SBATCH --qos=standard
#SBATCH --time=00:20:00
#SBATCH --account=m22oc-s1754999

#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=36

#SBATCH --job-name=nvfort-openacc-cpu
#SBATCH --output=%x-%j.out
#SBATCH --account=m22oc-s1754999

# Load the required modules
module load nvidia/nvhpc

# Intel vtune profiling option - need fast-debug mode on
module load intel-20.4/compilers
module load intel-20.4/vtune

# lscpu
echo ==========

# uncomment to select the executable
# EXEC=nvhpc_serial
# EXEC=nvhpc_openmp
# EXEC=nvhpc_openacc
# EXEC=nvhpc_do_concurrent

export OMP_NUM_THREADS=36
export ACC_NUM_COREs=36

echo EXEC_NAME: ${EXEC}_cpu
echo ==========

# run on cpu 
srun --cpu-bind=cores ../${EXEC}

# vtune hotspots
# srun --cpu-bind=cores vtune -collect hotspots -r vtune-hotspots  ../${EXEC}