mkdir build
cd build

set "PROCESSOR_ARCHITECTURE=AMD64"

cmake -G "Ninja" ^
    -DCLANG_DIR=%LIBRARY_BIN% ^
    -DCMAKE_C_COMPILER=clang-cl ^
    -DCMAKE_CXX_COMPILER=clang-cl ^
    -DCMAKE_BUILD_TYPE="Release" ^
    -DCMAKE_CXX_STANDARD=17 ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% ^
    -DTARGET_ARCHITECTURE=AMD64 ^
    %SRC_DIR%\flang
if %ERRORLEVEL% neq 0 exit 1

cmake --build .
if %ERRORLEVEL% neq 0 exit 1

cmake --install .
if %ERRORLEVEL% neq 0 exit 1
