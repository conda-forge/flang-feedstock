mkdir build
cd build

cmake -G Ninja \
    -DClang_DIR=$PREFIX/lib/cmake/clang \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    ../flang


cmake --build .
cmake --install .
