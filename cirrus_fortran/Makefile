# input flags
INPUT_FLAGS = -D_NX=200 -D_NZ=100 -D_SIM_TIME=100 -D_OUT_FREQ=1000 -D_DATA_SPEC=DATA_SPEC_THERMAL

# file names
MW_SERIAL = miniWeather_serial_nompi.F90
MW_OPENMP = miniWeather_openmp.F90
MW_OPENACC = miniWeather_openacc.F90
MW_OPENMP45 = miniWeather_openmp45.F90
MW_DOCONCURRENT =
MW_CUDA =

####################################################################################################

# gfortran compiler flags
GCC_FC = gfortran
GCC_DFFLAGS = -O3 -g -ffree-line-length-none
GCC_DOPENACC_FLAGS = -fopenacc -foffload="-lm -latomic"
GCC_DOPENMP_FLAGS = -fopenmp # -fopt-info
GCC_DOPENMP45_FLAGS = -fopenmp -foffload=nvptx-none="-lm -latomic"

# nvfortran compiler flags
NV_FC = nvfortran
NV_DFFLAGS =
NV_DOPENACC_FLAGS =
NV_DOPENMP_FLAGS =
NV_DOPENMP45_FLAGS = -mp=gpu -Minfo=mp

# for correctness checking
CHECK_OUTPUT_PATH = check_output.sh
TEST_FLAGS = -D_NX=200 -D_NZ=100 -D_SIM_TIME=400 -D_OUT_FREQ=1000 -D_DATA_SPEC=DATA_SPEC_THERMAL
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

gcc_openmp45: ${MW_OPENMP45}
	${GCC_FC} ${INPUT_FLAGS} ${GCC_DFFLAGS} ${GCC_DOPENMP45_FLAGS} -o $@ $<

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

gcc_openmp45_test: ${MW_OPENMP45}
	${GCC_FC} ${TEST_FLAGS} ${GCC_DFFLAGS} ${GCC_DOPENMP45_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

gcc_clean_test:
	rm -rf gcc_serial_test gcc_openmp_test gcc_openacc_test gcc_openmp45_test

####################################################################################################

nvhpc: nvhpc_serial nvhpc_openmp nvhpc_openacc nvhpc_openmp45

nvhpc_serial: ${MW_SERIAL}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} -o $@ $<

nvhpc_openmp: ${MW_OPENMP}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} ${NV_DOPENMP_FLAGS} -o $@ $<

nvhpc_openacc: ${MW_OPENACC}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} ${NV_DOPENACC_FLAGS} -o $@ $<

nvhpc_openmp45: ${MW_OPENMP45}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} ${NV_DOPENMP45_FLAGS} -o $@ $<

nvhpc_clean:
	rm -rf nvhpc_serial nvhpc_openmp nvhpc_openacc nvhpc_openmp45

####################################################################################################

clean: gcc_clean nvhpc_clean

