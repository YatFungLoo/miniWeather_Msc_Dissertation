gcc:
	make gcc_serial
	make gcc_openmp45

gcc_serial: miniWeather_serial_copy.cpp
	g++ -D_NX=200 -D_NZ=100 -D_SIM_TIME=150 -D_OUT_FREQ=1001 -D_DATA_SPEC=DATA_SPEC_THERMAL -O3 		\
	-march=native -std=c++11 -o serial_gcc12 miniWeather_serial_copy.cpp


gcc_openmp45: miniWeather_mpi_openmp45_copy.cpp
	g++ -D_NX=200 -D_NZ=100 -D_SIM_TIME=150 -D_OUT_FREQ=1001 -D_DATA_SPEC=DATA_SPEC_THERMAL -g 			\
	-fopenmp -fopt-info -foffload=nvptx-none="-lm -latomic" -o openmp45_gcc12 											\
	miniWeather_mpi_openmp45_copy.cpp

gcc_clean:
	rm serial_gcc12 openmp45_gcc12

nvhpc:
	make nvhpc_serial
	make nvhpc_openmp45

nvhpc_serial: miniWeather_serial_copy.cpp
	nvc++ -D_NX=200 -D_NZ=100 -D_SIM_TIME=150 -D_OUT_FREQ=1001 -D_DATA_SPEC=DATA_SPEC_THERMAL \
	miniWeather_serial_copy.cpp -o serial_nvhpc

nvhpc_openmp45: miniWeather_mpi_openmp45_copy.cpp
	nvc++ -D_NX=200 -D_NZ=100 -D_SIM_TIME=150 -D_OUT_FREQ=1001 -D_DATA_SPEC=DATA_SPEC_THERMAL \
	-mp=gpu -Minfo=mp miniWeather_mpi_openmp45_copy.cpp -o openmp45_nvhpc 

nvhpc_clean:
	rm serial_nvhpc openmp45_nvhpc

clean:
	make gcc_clean
	make nvhpc_clean