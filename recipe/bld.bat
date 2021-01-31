mkdir build
cd build

set "PROCESSOR_ARCHITECTURE=AMD64"

cmake -G "Ninja" ^
    -DCMAKE_C_COMPILER=clang-cl ^
    -DCMAKE_CXX_COMPILER=clang-cl ^
    -DCMAKE_BUILD_TYPE="Release" ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% ^
    -DTARGET_ARCHITECTURE=AMD64 ^
    %SRC_DIR%

if errorlevel 1 exit 1

cmake --build .
if errorlevel 1 exit 1

