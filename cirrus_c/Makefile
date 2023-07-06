# input flags
INPUT_FLAGS = -D_NX=200 -D_NZ=100 -D_SIM_TIME=100 -D_OUT_FREQ=1000 -D_DATA_SPEC=DATA_SPEC_THERMAL

# file names
MW_SERIAL = miniWeather_serial_nompi.cpp
MW_OPENMP = miniWeather_openmp.cpp
MW_OPENACC = miniWeather_openacc.cpp
MW_OPENMP45 = miniWeather_openmp45.cpp
MW_DOCONCURRENT =
MW_CUDA =

####################################################################################################

# gfortran compiler flags
GCC_CC = g++
GCC_DFFLAGS = -O3 -g -march=native -std=c++11
GCC_DOPENACC_FLAGS =
GCC_DOPENMP_FLAGS =
GCC_DOPENMP45_FLAGS = -fopenmp -foffload=nvptx-none="-lm -latomic"

# nvfortran compiler flags
NV_CC = nvc++
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

gcc: gcc_serial gcc_openmp45 # gcc_openmp gcc_openacc

gcc_serial: ${MW_SERIAL}
	${GCC_CC} ${INPUT_FLAGS} ${GCC_DFFLAGS} -o $@ $<

# gcc_openmp: ${MW_OPENMP}
# 	${GCC_CC} ${INPUT_FLAGS} ${GCC_DFFLAGS} ${GCC_DOPENMP_FLAGS} -o $@ $<

# gcc_openacc: ${MW_OPENACC}
# 	${GCC_CC} ${INPUT_FLAGS} ${GCC_DFFLAGS} ${GCC_DOPENACC_FLAGS} -o $@ $<

gcc_openmp45: ${MW_OPENMP45}
	${GCC_CC} ${INPUT_FLAGS} ${GCC_DFFLAGS} ${GCC_DOPENMP45_FLAGS} -o $@ $<

gcc_clean:
	rm -rf gcc_serial gcc_openmp gcc_openacc gcc_openmp45

####################################################################################################

# nvhpc:
# 	make nvhpc_serial
# 	make nvhpc_openmp45

# nvhpc_serial: miniWeather_serial_copy.cpp
# 	nvc++ -D_NX=200 -D_NZ=100 -D_SIM_TIME=150 -D_OUT_FREQ=1001 -D_DATA_SPEC=DATA_SPEC_THERMAL \
# 	miniWeather_serial_copy.cpp -o serial_nvhpc

# nvhpc_openmp45: miniWeather_mpi_openmp45_copy.cpp
# 	nvc++ -D_NX=200 -D_NZ=100 -D_SIM_TIME=150 -D_OUT_FREQ=1001 -D_DATA_SPEC=DATA_SPEC_THERMAL \
# 	-mp=gpu -Minfo=mp miniWeather_mpi_openmp45_copy.cpp -o openmp45_nvhpc 

# nvhpc_clean:
# 	rm serial_nvhpc openmp45_nvhpc

####################################################################################################

clean: gcc_clean # nvhpc_clean