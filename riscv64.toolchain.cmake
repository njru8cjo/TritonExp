#include(CMakeForceCompiler)

# usage
# cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/rv32imac.cmake ../

# Look for GCC in path
FIND_FILE( RISCV64_GCC_COMPILER "riscv64-unknown-linux-gnu-gcc" PATHS ENV INCLUDE)

# Select which is found
if (NOT EXISTS ${RISCV64_GCC_COMPILER})
    message(FATAL_ERROR "RISCV64 GCC not found. ${RISCV64_GCC_COMPILER}")
endif()

message( "RISCV64 GCC found: ${RISCV64_GCC_COMPILER}")

get_filename_component(RISCV64_TOOLCHAIN_BIN_PATH ${RISCV64_GCC_COMPILER} DIRECTORY)
get_filename_component(RISCV64_TOOLCHAIN_BIN_GCC ${RISCV64_GCC_COMPILER} NAME_WE)
get_filename_component(RISCV64_TOOLCHAIN_BIN_EXT ${RISCV64_GCC_COMPILER} EXT)

message( "RISCV64 GCC Path: ${RISCV64_TOOLCHAIN_BIN_PATH}" )

STRING(REGEX REPLACE "\-gcc" "-" CROSS_COMPILE ${RISCV64_TOOLCHAIN_BIN_GCC})
message( "RISCV64 Cross Compile: ${CROSS_COMPILE}" )

# The Generic system name is used for embedded targets (targets without OS) in CMake
#set( CMAKE_SYSTEM_NAME          Generic )
set( CMAKE_SYSTEM_NAME          Linux )
set( CMAKE_SYSTEM_PROCESSOR     riscv64 )
#set( CMAKE_EXECUTABLE_SUFFIX    ".elf")

set ( CMAKE_FIND_ROOT_PATH /usr/riscv64-linux-gnu )
set ( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER )
set ( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY )
set ( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY )

# specify the cross compiler. We force the compiler so that CMake doesn't
# attempt to build a simple test program as this will fail without us using
# the -nostartfiles option on the command line
#CMAKE_FORCE_C_COMPILER( "${AARCH64_TOOLCHAIN_BIN_PATH}/${CROSS_COMPILE}gcc${AARCH64_TOOLCHAIN_BIN_EXT}" GNU )
#CMAKE_FORCE_CXX_COMPILER( "${AARCH64_TOOLCHAIN_BIN_PATH}/${CROSS_COMPILE}g++${AARCH64_TOOLCHAIN_BIN_EXT}" GNU )

# use gcc
set(CMAKE_ASM_COMPILER ${RISCV64_TOOLCHAIN_BIN_PATH}/${CROSS_COMPILE}gcc )
set(CMAKE_AR ${RISCV64_TOOLCHAIN_BIN_PATH}/${CROSS_COMPILE}ar)
set(CMAKE_LD ${RISCV64_TOOLCHAIN_BIN_PATH}/${CROSS_COMPILE}ld)
set(CMAKE_C_COMPILER ${RISCV64_TOOLCHAIN_BIN_PATH}/${CROSS_COMPILE}gcc)
set(CMAKE_CXX_COMPILER ${RISCV64_TOOLCHAIN_BIN_PATH}/${CROSS_COMPILE}g++)

# We must set the OBJCOPY setting into cache so that it's available to the
# whole project. Otherwise, this does not get set into the CACHE and therefore
# the build doesn't know what the OBJCOPY filepath is
set( CMAKE_OBJCOPY      ${RISCV64_TOOLCHAIN_BIN_PATH}/${CROSS_COMPILE}objcopy
     CACHE FILEPATH "The toolchain objcopy command " FORCE )
     message( "RISCV64 objcopy: ${CMAKE_OBJCOPY}")

set( CMAKE_OBJDUMP      ${RISCV64_TOOLCHAIN_BIN_PATH}/${CROSS_COMPILE}objdump
     CACHE FILEPATH "The toolchain objdump command " FORCE )
     message( "RISCV64 objcopy: ${CMAKE_OBJDUMP}")

# Set the common build flags

# Set the CMAKE C flags (which should also be used by the assembler!
#set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Og -g3 -mcmodel=medium" )

#set( CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "" )
#set( CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "" )
#set( CMAKE_SHARED_LINKER_FLAGS "-latomic" )
