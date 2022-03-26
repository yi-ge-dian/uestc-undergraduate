cmake_minimum_required(VERSION 3.16)
project(MPI_project C)

set(CMAKE_C_STANDARD 99)

add_executable(MPI_project main.c removeEven.c eliminateBroadcast.c cacheOptimization.c finalOptimization.c)