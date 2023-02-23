@echo on

mkdir build
cd build

set "PROCESSOR_ARCHITECTURE=AMD64"

cmake -G "Ninja" ^
    -DBUILD_SHARED_LIBS=ON ^
    -DCMAKE_C_COMPILER=clang-cl ^
    -DCMAKE_CXX_COMPILER=clang-cl ^
    -DCMAKE_BUILD_TYPE="Release" ^
    -DCMAKE_CXX_STANDARD=17 ^
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DFLANG_ENABLE_WERROR=ON ^
    -DLLVM_BUILD_MAIN_SRC_DIR=.. ^
    -DLLVM_EXTERNAL_LIT=%LIBRARY_BIN%/lit ^
    -DLLVM_LIT_ARGS=-v ^
    -DLLVM_CMAKE_DIR=%LIBRARY_LIB%/cmake/llvm ^
    -DCLANG_DIR=%LIBRARY_LIB%/cmake/clang ^
    -DFLANG_INCLUDE_TESTS=OFF ^
    -DMLIR_DIR=%LIBRARY_LIB%/cmake/mlir ^
    -DTARGET_ARCHITECTURE=AMD64 ^
    %SRC_DIR%\flang
if %ERRORLEVEL% neq 0 exit 1

cmake --build .
if %ERRORLEVEL% neq 0 exit 1

cmake --install .
if %ERRORLEVEL% neq 0 exit 1
