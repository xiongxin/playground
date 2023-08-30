# TODO 1: Add a library called MathFunctions
# Hint: You will need the add_library command
cmake_minimum_required(VERSION 3.10)

aux_source_directory(. DIR_LIB_SRCS)
add_library(MathFunctions ${DIR_LIB_SRCS})
