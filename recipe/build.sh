#!/bin/bash
set -ex

mkdir build
cd build

if [[ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]]; then
    CMAKE_ARGS="$CMAKE_ARGS -DLLVM_CONFIG_PATH=$BUILD_PREFIX/bin/llvm-config -DMLIR_TABLEGEN_EXE=$BUILD_PREFIX/bin/mlir-tblgen"
fi

if [[ "${target_platform}" == linux-* ]]; then
    CMAKE_ARGS="$CMAKE_ARGS -DBUILD_SHARED_LIBS=ON"
else
    # unclear segfaults with shared builds on osx
    CMAKE_ARGS="$CMAKE_ARGS -DBUILD_SHARED_LIBS=OFF"
    # clang on osx still picks up libstdcxx by default for some reason (unless LLVM_ENABLE_LIBCXX), see
    # https://github.com/llvm/llvm-project/blob/llvmorg-17.0.0-rc4/llvm/cmake/modules/CheckCompilerVersion.cmake#L66-L88
    CMAKE_ARGS="$CMAKE_ARGS -DLLVM_ENABLE_LIBCXX=ON"
fi

cmake -G Ninja \
    ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_MODULE_PATH=../cmake/Modules \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DLLVM_EXTERNAL_LIT=$PREFIX/bin/lit \
    -DLLVM_LIT_ARGS=-v \
    -DLLVM_CMAKE_DIR=$PREFIX/lib/cmake/llvm \
    -DCLANG_DIR=$PREFIX/lib/cmake/clang \
    -DFLANG_INCLUDE_TESTS=OFF \
    -DMLIR_DIR=$PREFIX/lib/cmake/mlir \
    ../flang

cmake --build . -j1
