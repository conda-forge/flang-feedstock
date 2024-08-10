#!/bin/bash
set -ex

# show CPU arch to detect slow CI agents early (rather than wait for 6h timeout)
python -c "import numpy; numpy.show_config()"

mkdir build
cd build

if [[ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]]; then
    CMAKE_ARGS="$CMAKE_ARGS -DLLVM_CONFIG_PATH=$BUILD_PREFIX/bin/llvm-config -DMLIR_TABLEGEN_EXE=$BUILD_PREFIX/bin/mlir-tblgen"
fi

cmake -G Ninja \
    ${CMAKE_ARGS} \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_MODULE_PATH=../cmake/Modules \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DLLVM_EXTERNAL_LIT=$PREFIX/bin/lit \
    -DLLVM_LIT_ARGS=-v \
    -DLLVM_CMAKE_DIR=$PREFIX/lib/cmake/llvm \
    -DLLVM_DIR=$PREFIX/lib/cmake/llvm \
    -DLLVM_TARGETS_TO_BUILD="X86;WebAssembly" \
    -DLLVM_ENABLE_PROJECTS="clang;flang;mlir" \
    -DCLANG_DIR=$PREFIX/lib/cmake/clang \
    -DFLANG_INCLUDE_TESTS=OFF \
    -DMLIR_DIR=$PREFIX/lib/cmake/mlir \
    ../flang

cmake --build . -j2
