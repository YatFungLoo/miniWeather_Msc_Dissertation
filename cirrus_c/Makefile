# input flags
# INPUT_FLAGS = -D_NX=200 -D_NZ=100 -D_SIM_TIME=100 -D_OUT_FREQ=1000 -D_DATA_SPEC=DATA_SPEC_THERMAL
INPUT_FLAGS = -D_NX=1500 -D_NZ=750 -D_SIM_TIME=1 -D_OUT_FREQ=1000 -D_DATA_SPEC=DATA_SPEC_THERMAL

# file names
MW_SERIAL = miniWeather_serial_nompi.cpp
MW_OPENMP = miniWeather_openmp.cpp
MW_OPENACC = miniWeather_openacc.cpp
MW_OPENMP45 = miniWeather_openmp45.cpp
MW_DOCONCURRENT =
MW_CUDA =

####################################################################################################

# gfortran compiler flags
GPP_CC = g++
GPP_DFFLAGS = -O3 -g -march=native -std=c++11
GPP_DOPENMP_FLAGS = -fopenmp
GPP_DOPENACC_FLAGS = -fopenacc
GPP_DOPENMP45_FLAGS = -fopenmp -foffload=nvptx-none="-lm -latomic"

# nvfortran compiler flags
NVCPP_CC = nvc++
NVCPP_DFFLAGS = -O3 -g -Mvect -Mextend
NVCPP_DOPENMP_FLAGS = -mp=gpu # -Minfo=mp
NVCPP_DOPENACC_FLAGS = -acc # -Minfo=accel
NVCPP_DOPENMP45_FLAGS = -mp=gpu -Minfo=mp

# for correctness checking
CHECK_OUTPUT_PATH = check_output.sh
TEST_FLAGS = -D_NX=200 -D_NZ=100 -D_SIM_TIME=400 -D_OUT_FREQ=1000 -D_DATA_SPEC=DATA_SPEC_THERMAL
MAX_MASS_CHANGE = 1.e-13
MAX_ENERGY_CHANGE = 4.5e-5

####################################################################################################

g++: g++_serial g++_openmp45 g++_openmp g++_openacc

g++_serial: ${MW_SERIAL}
	${GPP_CC} ${INPUT_FLAGS} ${GPP_DFFLAGS} -o $@ $<

g++_openmp: ${MW_OPENMP}
	${GPP_CC} ${INPUT_FLAGS} ${GPP_DFFLAGS} ${GPP_DOPENMP_FLAGS} -o $@ $<

g++_openacc: ${MW_OPENACC}
	${GPP_CC} ${INPUT_FLAGS} ${GPP_DFFLAGS} ${GPP_DOPENACC_FLAGS} -o $@ $<

g++_openmp45: ${MW_OPENMP45}
	${GPP_CC} ${INPUT_FLAGS} ${GPP_DFFLAGS} ${GPP_DOPENMP45_FLAGS} -o $@ $<

g++_clean:
	rm -rf g++_serial g++_openmp g++_openacc g++_openmp45

####################################################################################################

g++_test: g++_serial_test g++_openmp45_test g++_openmp_test g++_openacc_test

g++_serial_test: ${MW_SERIAL}
	${GPP_CC} ${TEST_FLAGS} ${GPP_DFFLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

g++_openmp_test: ${MW_OPENMP}
	${GPP_CC} ${TEST_FLAGS} ${GPP_DFFLAGS} ${GPP_DOPENMP_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

g++_openacc_test: ${MW_OPENACC}
	${GPP_CC} ${TEST_FLAGS} ${GPP_DFFLAGS} ${GPP_DOPENACC_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

g++_openmp45_test: ${MW_OPENMP45}
	${GPP_CC} ${TEST_FLAGS} ${GPP_DFFLAGS} ${GPP_DOPENMP45_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

g++_clean_test:
	rm -rf g++_serial_test g++_openmp_test g++_openacc_test g++_openmp45_test

####################################################################################################


nvc++: nvc++_serial nvc++_openmp45 nvc++_openmp nvc++_openacc

nvc++_serial: ${MW_SERIAL}
	${NVCPP_CC} ${INPUT_FLAGS} ${NVCPP_DFFLAGS} -o $@ $<

nvc++_openmp: ${MW_OPENMP}
	${NVCPP_CC} ${INPUT_FLAGS} ${NVCPP_DFFLAGS} ${NVCPP_DOPENMP_FLAGS} -o $@ $<

nvc++_openacc: ${MW_OPENACC}
	${NVCPP_CC} ${INPUT_FLAGS} ${NVCPP_DFFLAGS} ${NVCPP_DOPENACC_FLAGS} -o $@ $<

nvc++_openmp45: ${MW_OPENMP45}
	${NVCPP_CC} ${INPUT_FLAGS} ${NVCPP_DFFLAGS} ${NVCPP_DOPENMP45_FLAGS} -o $@ $<

nvc++_clean:
	rm -rf nvc++_serial nvc++_openmp nvc++_openacc nvc++_openmp45

####################################################################################################

clean: g++_clean g++_clean_test nvc++_clean