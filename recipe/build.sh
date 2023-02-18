#!/bin/bash
set -ex

mkdir build
cd build

cmake -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DFLANG_ENABLE_WERROR=ON \
    -DLLVM_EXTERNAL_LIT=$PREFIX/bin/lit \
    -DLLVM_LIT_ARGS=-v \
    -DLLVM_CMAKE_DIR=$PREFIX/lib/cmake/llvm \
    -DCLANG_DIR=$PREFIX/lib/cmake/clang \
    -DFLANG_INCLUDE_TESTS=OFF \
    -DMLIR_DIR=$PREFIX/lib/cmake/mlir \
    ../flang

cmake --build .
cmake --install .
