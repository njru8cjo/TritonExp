# TritonExp
This repository contains OpenMP support and optimizations for [Triton](https://github.com/triton-lang/triton) based on [triton-shared](https://github.com/microsoft/triton-shared). Also, the kernel code compiled by Triton can run on a standalone environment using the custom driver and rewriter.\
Note that this project is WIP. Files may have hard-coded paths for test purposes. To execute correctly, one should modify the paths and copy corresponding files to specific paths.

## Subdirectory
### triton_shared
This folder contains a modified compiler and a driver script. The compiler script enables OpenMP support for the Triton kernel. The driver script parallelizes the execution of the kernel grid.

### loop_serialization
This MLIR pass can serialize inner for-loop to reduce OpenMP scheduling overhead.

### triton_kernel_launcher
This folder contains a rewriter and a driver script. The rewriter script can convert a Triton code to a standalone host code. The driver script provides the necessary functions to compile and call the kernel without Triton.

## Version of Dependencies
```
LLVM/MLIR: ed4e505c219fe6c7464ea5a056e90d8cd94c7332
triton-shared: e771c1e604c9c8883e50ed8f0e13c647156aa7c3
Triton: 239be71fd38db1ab57c18bc3b41b6de31a4350a6
```

## Installation
### Ninja
```
sudo apt -y install cmake g++

git clone https://github.com/ninja-build/ninja.git
cd ninja
./configure.py --bootstrap

cmake -Bbuild-cmake
cmake --build build-cmake

cp ninja /usr/bin
```

### LLVM+MLIR
```
git clone https://github.com/llvm/llvm-project.git
cd llvm-project
git checkout ed4e505c219fe6c7464ea5a056e90d8cd94c7332

mkdir build
cd build
cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_ASSERTIONS=ON ../llvm -DLLVM_ENABLE_PROJECTS="mlir;llvm;clang;openmp" -DLLVM_TARGETS_TO_BUILD="host;NVPTX;AMDGPU;RISCV"
ninja
(ninja -j2)
cp lib/libomp.so /usr/local/lib/libomp.so
export LD_LIBRARY_PATH=/usr/local/lib
```

### triton-shared+Triton
```
git clone https://github.com/microsoft/triton-shared.git triton_shared
export TRITON_PLUGIN_DIRS=$(pwd)/triton_shared
cd triton_shared
git checkout e771c1e604c9c8883e50ed8f0e13c647156aa7c3

git clone https://github.com/triton-lang/triton.git
cd triton
git checkout 239be71fd38db1ab57c18bc3b41b6de31a4350a6

sudo apt-get install python3-venv
python3 -m venv .venv --prompt triton
source .venv/bin/activate

sudo apt-get install libssl-dev
pip3 install ninja cmake wheel setuptools pytest
pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cpu

cp /this/repo/triton_shared/backend/compiler.py backend/compiler.py
cp /this/repo/triton_shared/backend/driver.py backend/driver.py

export LLVM_BUILD_DIR=/path/to/llvm-project/build
LLVM_INCLUDE_DIRS=$LLVM_BUILD_DIR/include \
LLVM_LIBRARY_DIR=$LLVM_BUILD_DIR/lib \
LLVM_SYSPATH=$LLVM_BUILD_DIR \
pip3 install ./python
```

### Loop Serialization
```
cd loop_serialization
mkdir build
cd build
cmake -G Ninja .. \
  -DMLIR_DIR=/path/to/llvm-project/build/lib/cmake/mlir \
  -DCLANG_DIR=/path/to/llvm-project/build/lib/cmake/clang \
  -DLLVM_TARGETS_TO_BUILD="host" \
  -DLLVM_ENABLE_ASSERTIONS=ON \
  -DCMAKE_BUILD_TYPE=DEBUG
ninja
export LOOP_SERIALIZATION_DIR=/path/to/loop_serialization/build/bin/loopSerialization
```

## Execution
### Triton CPU
```
export OMP_NUM_THREADS=6
export OMP_PLACES={0:6}
export OMP_PROC_BIND=true
python3 TritonExp/triton_kernel_launcher/vec_add.py
```

### Triton Standalone CPU
To continue, one must obtain kernel.s by running Triton CPU flow.
```
export OMP_NUM_THREADS=6
export OMP_PLACES={0:6}
export OMP_PROC_BIND=true
cd TritonExp/triton_kernel_launcher
python3 driver.py
python3 rewriter.py vec_add.py vec_add_after.py
python3 vec_add_after.py
```
