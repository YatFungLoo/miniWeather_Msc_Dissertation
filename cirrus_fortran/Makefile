gcc:
	make gcc_serial
	make gcc_openmp45

gcc_serial: miniWeather_serial_copy.F90
	gfortran -D_NX=200 -D_NZ=100 -D_SIM_TIME=150 -D_OUT_FREQ=1001 -D_DATA_SPEC=DATA_SPEC_THERMAL 	\
	-O3 -ffree-line-length-none -o serial_gcc12 miniWeather_serial_copy.F90 											\

gcc_openmp45: miniWeather_mpi_openmp45_copy.F90
	gfortran -D_NX=200 -D_NZ=100 -D_SIM_TIME=150 -D_OUT_FREQ=1001 -D_DATA_SPEC=DATA_SPEC_THERMAL 	\
	-g -ffree-line-length-none -fopenmp -fopt-info -foffload=nvptx-none="-lm -latomic" 						\
	-o openmp45_gcc12 miniWeather_mpi_openmp45_copy.F90  																					\

gcc_clean:
	rm serial_gcc12 openmp45_gcc12

nvhpc:
	make nvhpc_serial
	make nvhpc_openmp45

nvhpc_serial: miniWeather_serial_copy.F90
	nvfortran -D_NX=200 -D_NZ=100 -D_SIM_TIME=150 -D_OUT_FREQ=1001 -D_DATA_SPEC=DATA_SPEC_THERMAL \
	miniWeather_serial_copy.F90 -o serial_nvhpc

nvhpc_openmp45: miniWeather_mpi_openmp45_copy.F90
	nvfortran -D_NX=200 -D_NZ=100 -D_SIM_TIME=150 -D_OUT_FREQ=1001 -D_DATA_SPEC=DATA_SPEC_THERMAL \
	-mp=gpu -Minfo=mp miniWeather_mpi_openmp45_copy.F90 -o openmp45_nvhpc 

nvhpc_clean:
	rm serial_nvhpc openmp45_nvhpc

clean:
	make gcc_clean
	make nvhpc_clean