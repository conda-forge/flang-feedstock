#!/bin/bash
set -ex

# show CPU arch to detect slow CI agents early (rather than wait for 6h timeout)
python -c "import numpy; numpy.show_config()"

mkdir build
cd build

if [[ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]]; then
    CMAKE_ARGS="$CMAKE_ARGS -DLLVM_CONFIG_PATH=$BUILD_PREFIX/bin/llvm-config -DMLIR_TABLEGEN_EXE=$BUILD_PREFIX/bin/mlir-tblgen"
fi

# On macOS, BUILD_SHARED_LIBS alone duplicates MLIR TypeIDs across the many
# flang dylibs, causing a segfault during dialect registration.  Route all
# MLIR/LLVM code through the monolithic dylibs shipped by conda-forge's
# llvmdev/mlir to avoid the collision (see PR #29 / #31 for the original
# macOS attempt, and Homebrew's Formula/f/flang.rb for the proven combo).
if [[ "$target_platform" == osx-* ]]; then
    CMAKE_ARGS="$CMAKE_ARGS -DMLIR_LINK_MLIR_DYLIB=ON -DLLVM_LINK_LLVM_DYLIB=ON"
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
    -DCLANG_DIR=$PREFIX/lib/cmake/clang \
    -DFLANG_INCLUDE_RUNTIME=OFF \
    -DFLANG_INCLUDE_TESTS=OFF \
    -DMLIR_DIR=$PREFIX/lib/cmake/mlir \
    ../flang

cmake --build . -j2
