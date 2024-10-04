#!/bin/bash
TRITON_EXP_PATH=$(dirname $(realpath "$BASH_SOURCE"))
export LD_LIBRARY_PATH=/usr/local/lib
export TRITON_PLUGIN_DIRS=/home/ywshao/triton_shared
export LLVM_BUILD_DIR=/home/ywshao/llvm-project/build
export LLVM_BINARY_DIR=/home/ywshao/llvm-project/build/bin
export TRITON_SHARED_OPT_PATH=/home/ywshao/triton_shared/triton/python/build/cmake.linux-x86_64-cpython-3.12/third_party/triton_shared/tools/triton-shared-opt/triton-shared-opt
export LOOP_SERIALIZATION_DIR=$TRITON_EXP_PATH/loop_serialization/build/bin/loopSerialization
# RISC-V clang
export RISCV_CLANG=/home/ywshao/riscv/bin/clang
# RISC-V gcc
export RISCV_GCC_LIB="/home/ywshao/riscv gcc/riscv64-unknown-linux-gnu/lib"
# RISC-V toolchain
export RISCV_SYSROOT_LIB=/home/ywshao/riscv/sysroot/lib
export TRITON_OUTPUT_DIR=$TRITON_EXP_PATH/output
source /home/ywshao/triton_shared/triton/.venv/bin/activate