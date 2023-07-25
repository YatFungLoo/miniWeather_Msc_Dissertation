# input flags
# INPUT_FLAGS = -D_NX=750 -D_NZ=375 -D_SIM_TIME=1000 -D_OUT_FREQ=100 -D_DATA_SPEC=DATA_SPEC_THERMAL
INPUT_FLAGS = -D_NX=1500 -D_NZ=750 -D_SIM_TIME=2 -D_OUT_FREQ=100 -D_DATA_SPEC=DATA_SPEC_THERMAL

# file names
MW_SERIAL = miniWeather_serial_nompi.F90
MW_OPENMP = miniWeather_openmp.F90
MW_OPENACC = miniWeather_openacc.F90
MW_OPENMP45_GCC = miniWeather_openmp45_gcc.F90
MW_OPENMP45_NV = miniWeather_openmp45_nvhpc.F90
MW_OPENMP45_ICC = miniWeather_openmp45_nvhpc.F90
MW_DOCONCURRENT = miniWeather_do_concurrent.F90
MW_CUDA = miniWeather_cuda.CUF

####################################################################################################

# gfortran compiler flags
GCC_FC = gfortran
GCC_DFFLAGS = -O3 -g -ffree-line-length-none
GCC_DOPENMP_FLAGS = -fopenmp # -fopt-info
GCC_DOPENACC_FLAGS = -fopenacc -foffload="-lm -latomic -lgfortran"
GCC_DOPENMP45_FLAGS = -fopenmp -foffload="-lm -latomic"
GCC_DDO_CONCURRENT_FLAGS = -ftree-parallelize-loops=2

# nvfortran compiler flags
NV_FC = nvfortran
NV_DFFLAGS = -O3 -g -Mvect -Mextend # -DNO_INFORM
NV_DOPENMP_FLAGS = -mp # -Minfo=mp
NV_DOPENACC_FLAGS = -acc # -Minfo=accel # -gpu=cc70,fastmath,loadcache:L1,ptxinfo
NV_DOPENMP45_FLAGS = -mp=gpu  # -gpu=cc70,fastmath,loadcache:L1,ptxinfo -Minfo=mp
NV_DDO_CONCURRENT_FLAGS = -stdpar=gpu,multicore # -gpu=cc50 # ,fastmath,loadcache:L1,ptxinfo # -Minfo=stdpar
NV_DCUDA_FLAGS = #-Mcuda #-arch=sm_70

# intel compiler flags (work in progress)
ICC_FC = ifx
ICC_DFFLAGS = -Ofast -fast-transcendentals -fp-model=fast=2 -xHost # -DNO_INFORM
ICC_DOPENMP_FLAGS = -qopenmp
# ICC_DOPENACC_FLAGS = not supported
ICC_DOPENMP45_FLAGS = -fiopenmp
# ICC_DDO_CONCURRENT_FLAGS = -ffrontend-loop-interchange

# for correctness checking
CHECK_OUTPUT_PATH = check_output.sh
TEST_FLAGS = -D_NX=100 -D_NZ=50 -D_SIM_TIME=400 -D_OUT_FREQ=400 -D_DATA_SPEC=DATA_SPEC_THERMAL
MAX_MASS_CHANGE = 1.e-13
MAX_ENERGY_CHANGE = 4.5e-5

####################################################################################################

gcc: gcc_serial gcc_openmp gcc_openacc gcc_openmp45

gcc_serial: ${MW_SERIAL}
	${GCC_FC} ${INPUT_FLAGS} ${GCC_DFFLAGS} -o $@ $<

gcc_openmp: ${MW_OPENMP}
	${GCC_FC} ${INPUT_FLAGS} ${GCC_DFFLAGS} ${GCC_DOPENMP_FLAGS} -o $@ $<

gcc_openacc: ${MW_OPENACC}
	${GCC_FC} ${INPUT_FLAGS} ${GCC_DFFLAGS} ${GCC_DOPENACC_FLAGS} -o $@ $<

gcc_openmp45: ${MW_OPENMP45_GCC}
	${GCC_FC} ${INPUT_FLAGS} ${GCC_DFFLAGS} ${GCC_DOPENMP45_FLAGS} -o $@ $<

gcc_do_concurrent: ${MW_DOCONCURRENT}
	${GCC_FC} ${INPUT_FLAGS} ${GCC_DFFLAGS} ${GCC_DDO_CONCURRENT_FLAGS} -o $@ $<

gcc_clean:
	rm -rf gcc_serial gcc_openmp gcc_openacc gcc_openmp45

####################################################################################################

gcc_test: gcc_serial_test gcc_openmp_test gcc_openacc_test gcc_openmp45_test

gcc_serial_test: ${MW_SERIAL}
	${GCC_FC} ${TEST_FLAGS} ${GCC_DFFLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

gcc_openmp_test: ${MW_OPENMP}
	${GCC_FC} ${TEST_FLAGS} ${GCC_DFFLAGS} ${GCC_DOPENMP_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

gcc_openacc_test: ${MW_OPENACC}
	${GCC_FC} ${TEST_FLAGS} ${GCC_DFFLAGS} ${GCC_DOPENACC_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

gcc_openmp45_test: ${MW_OPENMP45_GCC}
	${GCC_FC} ${TEST_FLAGS} ${GCC_DFFLAGS} ${GCC_DOPENMP45_FLAGS} -o $@ $<
#	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

gcc_clean_test:
	rm -rf gcc_serial_test gcc_openmp_test gcc_openacc_test gcc_openmp45_test

####################################################################################################

nvhpc: nvhpc_serial nvhpc_openmp nvhpc_openacc nvhpc_openmp45 nvhpc_do_concurrent cuda

nvhpc_serial: ${MW_SERIAL}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} -o $@ $<

nvhpc_openmp: ${MW_OPENMP}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} ${NV_DOPENMP_FLAGS} -o $@ $<

nvhpc_openacc: ${MW_OPENACC}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} ${NV_DOPENACC_FLAGS} -o $@ $<

nvhpc_openmp45: ${MW_OPENMP45_NV}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} ${NV_DOPENMP45_FLAGS} -o $@ $<

nvhpc_do_concurrent: ${MW_DOCONCURRENT}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} ${NV_DDO_CONCURRENT_FLAGS} -o $@ $<

cuda: ${MW_CUDA}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} ${NV_DCUDA_FLAGS} -o $@ $<

nvhpc_clean:
	rm -rf nvhpc_serial nvhpc_openmp nvhpc_openacc nvhpc_openmp45 nvhpc_do_concurrent cuda

####################################################################################################

nvhpc_test: nvhpc_serial_test nvhpc_openmp_test nvhpc_openacc_test nvhpc_openmp45_test nvhpc_do_concurrent_test cuda_test

nvhpc_serial_test: ${MW_SERIAL}
	${NV_FC} ${TEST_FLAGS} ${NV_DFFLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

nvhpc_openmp_test: ${MW_OPENMP}
	${NV_FC} ${TEST_FLAGS} ${NV_DFFLAGS} ${NV_DOPENMP_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

nvhpc_openacc_test: ${MW_OPENACC}
	${NV_FC} ${TEST_FLAGS} ${NV_DFFLAGS} ${NV_DOPENACC_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

nvhpc_openmp45_test: ${MW_OPENMP45_NV}
	${NV_FC} ${TEST_FLAGS} ${NV_DFFLAGS} ${NV_DOPENMP45_FLAGS} -o $@ $<
#	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

nvhpc_do_concurrent_test: ${MW_DOCONCURRENT}
	${NV_FC} ${TEST_FLAGS} ${NV_DFFLAGS} ${NV_DDO_CONCURRENT_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

cuda_test: ${MW_CUDA}
	${NV_FC} ${TEST_FLAGS} ${NV_DFFLAGS} ${NV_DCUDA_FLAGS} -o $@ $<
#	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

nvhpc_clean_test:
	rm -rf nvhpc_serial_test nvhpc_openmp_test nvhpc_openacc_test nvhpc_openmp45_test nvhpc_do_concurrent_test cuda_test

####################################################################################################

icc: icc_serial icc_openmp icc_openacc icc_openmp45

icc_serial: ${MW_SERIAL}
	${ICC_FC} ${INPUT_FLAGS} ${ICC_DFFLAGS} -o $@ $<

icc_openmp: ${MW_OPENMP}
	${ICC_FC} ${INPUT_FLAGS} ${ICC_DFFLAGS} ${ICC_DOPENMP_FLAGS} -o $@ $<

# icc_openacc: ${MW_OPENACC}
#	  ${ICC_FC} ${INPUT_FLAGS} ${ICC_DFFLAGS} ${ICC_DOPENACC_FLAGS} -o $@ $<

icc_openmp45: ${MW_OPENMP45_ICC}
	${ICC_FC} ${INPUT_FLAGS} ${ICC_DFFLAGS} ${ICC_DOPENMP45_FLAGS} -o $@ $<

# icc_do_concurrent: ${MW_DOCONCURRENT}
#   ${ICC_FC} ${INPUT_FLAGS} ${ICC_DFFLAGS} ${ICC_DDO_CONCURRENT_FLAGS} -o $@ $<

icc_clean:
	rm -rf icc_serial icc_openmp icc_openacc icc_openmp45

####################################################################################################

clean: gcc_clean nvhpc_clean

clean_test: gcc_clean_test nvhpc_clean_test
