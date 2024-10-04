# TritonExp
This repository contains OpenMP support and optimizations for [Triton](https://github.com/triton-lang/triton) based on [triton-shared](https://github.com/microsoft/triton-shared). Also, the kernel code compiled by Triton can run on a standalone environment using the custom driver and rewriter.\
Note that there are some absolute paths in the script. To execute correctly, one should modify the paths and copy corresponding files to specific paths.

## Subdirectory
### triton_shared
This folder contains a modified compiler and a driver script. The compiler script enables OpenMP support for the Triton kernel. The driver script parallelizes the execution of the kernel grid.

### loop_serialization
This MLIR pass can serialize inner for-loop to reduce OpenMP scheduling overhead.

### triton_kernel_launcher
This folder contains a rewriter and a driver script. The rewriter script can convert a Triton code to a standalone host code. The driver script provides the necessary functions to compile and call the kernel without Triton.

### output
This folder contains every IR and shared library. The files will be generated once a new kernel is compiled. To regenerate the files without modifying the Triton program, one can delete Triton cache which is typically at "user_name/.triton".

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

### RISC-V Toolchain
```
export PATH="/opt/riscv/bin:$PATH"

sudo apt-get install autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev

git clone https://github.com/riscv/riscv-gnu-toolchain
cd riscv-gnu-toolchain
./configure --prefix=/opt/riscv
make linux
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

# Run these for normal Triton flow
cp /this/repo/triton_shared/backend/compiler.py backend/compiler.py
cp /this/repo/triton_shared/backend/driver.py backend/driver.py

# Run these for Triton Standalone
cp /this/repo/triton_shared/backend/compiler_standalone.py backend/compiler.py
cp /this/repo/triton_shared/backend/driver_standalone.py backend/driver.py

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

### Cross Compile LLVM+MLIR
```
mkdir xbuild; cd xbuild
cp /path/to/riscv64.toolchain.cmake .

cmake ../llvm -G Ninja                                                                 \
      -DLLVM_ENABLE_PROJECTS="clang;lld;clang-tools-extra;lldb;polly;openmp;mlir;libc" \
      -DCMAKE_INSTALL_PREFIX=/usr/local/llvm_x_cross                                   \
      -DCMAKE_BUILD_TYPE=Release                                                       \
      -DCMAKE_SYSTEM_NAME=Linux -DLLVM_HOST_TRIPLE=riscv64-linux-gnu                   \
      -DCMAKE_TOOLCHAIN_FILE=./riscv64.toolchain.cmake -DHAVE_POSIX_REGEX=0            \
	  -DLLVM_TARGETS_TO_BUILD="RISCV;NVPTX;AMDGPU"

ninja
ninja install
```
scp -r /usr/local/llvm_x_cross ywshao@xxx.xxx.xxx.xxx:/usr/local/

### PyTorch on RISC-V
```
sudo apt-get install clang python3.12-dev libgomp1 libomp-dev git cmake libopenblas-dev
sudo apt-get install python3-{hypothesis,psutil,requests,sympy,filelock,networkx,jinja2,fsspec,packaging,numpy}
pip install pytorch-riscv64 --break-system-packages
```

### Triton Standalone Driver
```
scp -r /usr/local/llvm_x_cross ywshao@xxx.xxx.xxx.xxx: /home/ywshao/Desktop/riscv/triton_kernel_launcher
```

## Execution
One can get riscv gcc and toolchain lib from RISC-V packages, source code, etc.
Run this script to make sure environment variables are set and activate venv.
```
source ./prepare.sh
```

### Triton CPU
```
export OMP_NUM_THREADS=6
export OMP_PLACES={0:6}
export OMP_PROC_BIND=true
python3 TritonExp/triton_kernel_launcher/vec_add.py
```

### Triton Standalone CPU
If /usr/include/riscv64-linux-gnu/python3.12/pyconfig.h is not presented, one can get it from RISC-V device with python3.12-dev package or download and unpack it on local machine.
To continue, one must obtain kernel.so by running Triton CPU flow.
Rewriter does not always work. Grid should become three arguments.
```
export OMP_NUM_THREADS=6
export OMP_PLACES={0:6}
export OMP_PROC_BIND=true
cd TritonExp/triton_kernel_launcher
python3 vec_add.py
scp ../output/kernel.so ywshao@xxx.xxx.xxx.xxx:/home/ywshao/Desktop/riscv
python3 rewriter.py vec_add.py vec_add_after.py
scp vec_add_after.py ywshao@xxx.xxx.xxx.xxx:/home/ywshao/Desktop/riscv/triton_kernel_launcher
```

On RISC-V device:
```
python3 vec_add_after.py
```
