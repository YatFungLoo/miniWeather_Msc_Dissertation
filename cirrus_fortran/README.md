# FORTRAN on Cirrus

## Compilers

Most version are available on GNU 12.2.0, NVIDIA NVHPC and Intel compilers.

To load GNU 12.2.0 compilers, run:

```module load gcc/12.2.0-gpu-offload```

To load NVIDIA NVHPC compilers, run:

```module load nvidia/nvhpc```

To load Intel compilers, run:

```module load oneapi```

```source /mnt/lustre/indy2lfs/sw/oneapi/2022.2.0.191/setvars.sh```

Please unload all the related compiler modules before loading in another, as there might be conflicts, use:

```module unload ${module_to_unload}```

---

## Makefile

Makefile is provided for all version of the code, and are seperated by compilers. Command to use make is as follow:

```make gfortran```

```make nvfortran```

```make ifx```

To make specific verion, please add the version at the end of the compiler name, synatax is as follow:

```make ${compiler}_${version}```

for example, to make OpenMP version with nvfortran providing all the necessary modules are loaded, run:

```make nvfortran_openmp```

To remove the exec files, run:

```make clean```

to remove specific compilers exec, run:

```make ${compiler}_clean```

## Make test

Test for each version are available, that check the correctness of the program, run:

```make ${compiler}_test```

> Note: test does not work on GPU version, as it requries a job to be submitted to the GPU node. To ensure correctness, compare the output values has to be check manually.

To test specific verion, please add the version at the end of the compiler name, synatax is as follow:

```make ${compiler}_${version}_test```

To remove the test exec files, run:

```make clean_test```

to remove specific compilers exec, run:

```make ${compiler}_clean_test```

## Submitting to compute node

Slurm files are available under `\slurm` directory for each compiler and is denoted by the compiler name with the compute node that it is meant for. To use the slurm file, please ensure the executable is available, and edit the slurm file to point to the correct executable by changing `EXEC` argument