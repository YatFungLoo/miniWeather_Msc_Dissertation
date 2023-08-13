# input flags
INPUT_FLAGS = -D_NX=1500 -D_NZ=750 -D_SIM_TIME=50 -D_OUT_FREQ=100 -D_DATA_SPEC=DATA_SPEC_THERMAL

# file names
MW_SERIAL = miniWeather_serial_nompi.F90
MW_OPENMP = miniWeather_openmp.F90
MW_OPENACC = miniWeather_openacc.F90
MW_OPENMP45_GNU = miniWeather_openmp45_gfort.F90
MW_OPENMP45_NV = miniWeather_openmp45_nvfort.F90
MW_OPENMP45_IFX = miniWeather_openmp45_nvfort.F90
MW_DOCONCURRENT = miniWeather_do_concurrent.F90
MW_CUDA = miniWeather_cuda.CUF

####################################################################################################

# gfortran compiler flags
GNU_FC = gfortran
GNU_DFFLAGS = -O3 -g -ffree-line-length-none
GNU_DOPENMP_FLAGS = -fopenmp -fopt-info
GNU_DOPENACC_FLAGS = -fopenacc -foffload="-lm -latomic -lgfortran" # -fopenacc-dim=32768:1:128 # -fopt-info-omp 
GNU_DOPENMP45_FLAGS = -fopenmp -foffload=nvptx-none="-lm -latomic" # -fopt-info
GNU_DDO_CONCURRENT_FLAGS = -ftree-parallelize-loops=2

# nvfortran compiler flags
NV_FC = nvfortran
NV_DFFLAGS = -O3 -g -Mvect -Mextend # -DNO_INFORM
NV_DOPENMP_FLAGS = -mp # -Minfo=mp
NV_DOPENACC_FLAGS = -acc -Minfo # -gpu=managed 	# -ta=multicore # -gpu=cc70,fastmath,loadcache:L1,ptxinfo
NV_DOPENMP45_FLAGS = -mp=gpu  # -gpu=cc70,fastmath,loadcache:L1,ptxinfo -Minfo=mp
NV_DDO_CONCURRENT_FLAGS = -stdpar=gpu,multicore # -gpu=cc50 # ,fastmath,loadcache:L1,ptxinfo # -Minfo=stdpar
NV_DCUDA_FLAGS = #-Mcuda #-arch=sm_70

# intel compiler flags (work in progress)
IFX_FC = ifx
IFX_DFFLAGS = -Ofast -fp-model=fast=2 -xHost # -DNO_INFORM -fast-transcendentals
IFX_DOPENMP_FLAGS = -qopenmp
IFX_DOPENMP45_FLAGS = -fiopenmp -fopenmp-targets=spir64
IFX_DDO_CONCURRENT_FLAGS = -qopenmp

# for correctness checking
CHECK_OUTPUT_PATH = check_output.sh
TEST_FLAGS = -D_NX=100 -D_NZ=50 -D_SIM_TIME=400 -D_OUT_FREQ=400 -D_DATA_SPEC=DATA_SPEC_THERMAL
MAX_MASS_CHANGE = 1.e-13
MAX_ENERGY_CHANGE = 4.5e-5

####################################################################################################

gfortran: gfortran_serial gfortran_openmp gfortran_openacc gfortran_openmp45

gfortran_serial: ${MW_SERIAL}
	${GNU_FC} ${INPUT_FLAGS} ${GNU_DFFLAGS} -o $@ $<

gfortran_openmp: ${MW_OPENMP}
	${GNU_FC} ${INPUT_FLAGS} ${GNU_DFFLAGS} ${GNU_DOPENMP_FLAGS} -o $@ $<

gfortran_openacc: ${MW_OPENACC}
	${GNU_FC} ${INPUT_FLAGS} ${GNU_DFFLAGS} ${GNU_DOPENACC_FLAGS} -o $@ $<

gfortran_openmp45: ${MW_OPENMP45_GNU}
	${GNU_FC} ${INPUT_FLAGS} ${GNU_DFFLAGS} ${GNU_DOPENMP45_FLAGS} -o $@ $<

gfortran_do-concurrent: ${MW_DOCONCURRENT}
	${GNU_FC} ${INPUT_FLAGS} ${GNU_DFFLAGS} ${GNU_DDO_CONCURRENT_FLAGS} -o $@ $<

gfortran_clean:
	rm -rf gfortran_serial gfortran_openmp gfortran_openacc gfortran_openmp45

####################################################################################################

gfortran_test: gfortran_serial_test gfortran_openmp_test gfortran_openacc_test gfortran_openmp45_test

gfortran_serial_test: ${MW_SERIAL}
	${GNU_FC} ${TEST_FLAGS} ${GNU_DFFLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

gfortran_openmp_test: ${MW_OPENMP}
	${GNU_FC} ${TEST_FLAGS} ${GNU_DFFLAGS} ${GNU_DOPENMP_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

gfortran_openacc_test: ${MW_OPENACC}
	${GNU_FC} ${TEST_FLAGS} ${GNU_DFFLAGS} ${GNU_DOPENACC_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

gfortran_openmp45_test: ${MW_OPENMP45_GNU}
	${GNU_FC} ${TEST_FLAGS} ${GNU_DFFLAGS} ${GNU_DOPENMP45_FLAGS} -o $@ $<
#	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

gfortran_clean_test:
	rm -rf gfortran_serial_test gfortran_openmp_test gfortran_openacc_test gfortran_openmp45_test

####################################################################################################

nvfort: nvfort_serial nvfort_openmp nvfort_openacc nvfort_openmp45 nvfort_do-concurrent cuda

nvfort_serial: ${MW_SERIAL}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} -o $@ $<

nvfort_openmp: ${MW_OPENMP}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} ${NV_DOPENMP_FLAGS} -o $@ $<

nvfort_openacc: ${MW_OPENACC}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} ${NV_DOPENACC_FLAGS} -o $@ $<

nvfort_openmp45: ${MW_OPENMP45_NV}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} ${NV_DOPENMP45_FLAGS} -o $@ $<

nvfort_do-concurrent: ${MW_DOCONCURRENT}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} ${NV_DDO_CONCURRENT_FLAGS} -o $@ $<

cuda: ${MW_CUDA}
	${NV_FC} ${INPUT_FLAGS} ${NV_DFFLAGS} ${NV_DCUDA_FLAGS} -o $@ $<

nvfort_clean:
	rm -rf nvfort_serial nvfort_openmp nvfort_openacc nvfort_openmp45 nvfort_do-concurrent cuda

####################################################################################################

nvfort_test: nvfort_serial_test nvfort_openmp_test nvfort_openacc_test nvfort_openmp45_test nvfort_do-concurrent_test cuda_test

nvfort_serial_test: ${MW_SERIAL}
	${NV_FC} ${TEST_FLAGS} ${NV_DFFLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

nvfort_openmp_test: ${MW_OPENMP}
	${NV_FC} ${TEST_FLAGS} ${NV_DFFLAGS} ${NV_DOPENMP_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

nvfort_openacc_test: ${MW_OPENACC}
	${NV_FC} ${TEST_FLAGS} ${NV_DFFLAGS} ${NV_DOPENACC_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

nvfort_openmp45_test: ${MW_OPENMP45_NV}
	${NV_FC} ${TEST_FLAGS} ${NV_DFFLAGS} ${NV_DOPENMP45_FLAGS} -o $@ $<
#	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

nvfort_do-concurrent_test: ${MW_DOCONCURRENT}
	${NV_FC} ${TEST_FLAGS} ${NV_DFFLAGS} ${NV_DDO_CONCURRENT_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

cuda_test: ${MW_CUDA}
	${NV_FC} ${TEST_FLAGS} ${NV_DFFLAGS} ${NV_DCUDA_FLAGS} -o $@ $<
#	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

nvfort_clean_test:
	rm -rf nvfort_serial_test nvfort_openmp_test nvfort_openacc_test nvfort_openmp45_test nvfort_do-concurrent_test cuda_test

####################################################################################################

ifx: ifx_serial ifx_openmp ifx_do-concurrent

ifx_serial: ${MW_SERIAL}
	${IFX_FC} ${INPUT_FLAGS} ${IFX_DFFLAGS} -o $@ $<

ifx_openmp: ${MW_OPENMP}
	${IFX_FC} ${INPUT_FLAGS} ${IFX_DFFLAGS} ${IFX_DOPENMP_FLAGS} -o $@ $<

# ifx_openmp45: ${MW_OPENMP45_IFX}
# 	${IFX_FC} ${INPUT_FLAGS} ${IFX_DFFLAGS} ${IFX_DOPENMP45_FLAGS} -o $@ $<

ifx_do-concurrent: ${MW_DOCONCURRENT}
	${IFX_FC} ${INPUT_FLAGS} ${IFX_DFFLAGS} ${IFX_DDO_CONCURRENT_FLAGS} -o $@ $<

ifx_clean:
	rm -rf ifx_serial ifx_openmp ifx_openmp45 ifx_do-concurrent

####################################################################################################

ifx_test: ifx_serial_test ifx_openmp_test ifx_do-concurrent_test 

ifx_serial_test: ${MW_SERIAL}
	${IFX_FC} ${TEST_FLAGS} ${IFX_DFFLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

ifx_openmp_test: ${MW_OPENMP}
	${IFX_FC} ${TEST_FLAGS} ${IFX_DFFLAGS} ${IFX_DOPENMP_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

# ifx_openmp45_test: ${MW_OPENMP45_IFX}
# 	${IFX_FC} ${TEST_FLAGS} ${IFX_DFFLAGS} ${IFX_DOPENMP45_FLAGS} -o $@ $<
#	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

ifx_do-concurrent_test: ${MW_DOCONCURRENT}
	${IFX_FC} ${TEST_FLAGS} ${IFX_DFFLAGS} ${IFX_DDO_CONCURRENT_FLAGS} -o $@ $<
	./${CHECK_OUTPUT_PATH} ./$@ ${MAX_MASS_CHANGE} ${MAX_ENERGY_CHANGE}

ifx_clean_test:
	rm -rf ifx_serial_test ifx_openmp_test ifx_openacc_test ifx_openmp45_test ifx_do-concurrent_test cuda_test

####################################################################################################

clean: gfortran_clean nvfort_clean ifx_clean

clean_test: gfortran_clean_test nvfort_clean_test ifx_clean_test
