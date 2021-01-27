cd %SRC_DIR%\build
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64

cmake --build . --target install
if errorlevel 1 exit 1

mkdir %LIBRARY_BIN%\..\include\flang
cp %SRC_DIR%/build/include/flang/ieee_arithmetic.mod %LIBRARY_BIN%\..\include\flang
cp %SRC_DIR%/build/include/flang/ieee_arithmetic_la.mod %LIBRARY_BIN%\..\include\flang
cp %SRC_DIR%/build/include/flang/ieee_exceptions.mod %LIBRARY_BIN%\..\include\flang
cp %SRC_DIR%/build/include/flang/ieee_exceptions_la.mod %LIBRARY_BIN%\..\include\flang
cp %SRC_DIR%/build/include/flang/ieee_features.mod %LIBRARY_BIN%\..\include\flang
cp %SRC_DIR%/build/include/flang/iso_c_binding.mod %LIBRARY_BIN%\..\include\flang
cp %SRC_DIR%/build/include/flang/iso_fortran_env.mod %LIBRARY_BIN%\..\include\flang
cp %SRC_DIR%/build/include/flang/omp_lib.mod %LIBRARY_BIN%\..\include\flang
cp %SRC_DIR%/build/include/flang/omp_lib_kinds.mod %LIBRARY_BIN%\..\include\flang
cp %SRC_DIR%/build/include/flang/__norm2.mod %LIBRARY_BIN%\..\include\flang
cp %SRC_DIR%/build/include/flang/__norm2_i8.mod %LIBRARY_BIN%\..\include\flang
cp %SRC_DIR%/build/include/flang/omp_lib.h %LIBRARY_BIN%\..\include\flang
cp %SRC_DIR%/build/lib/flangADT.lib %LIBRARY_BIN%\..\lib
cp %SRC_DIR%/build/lib/flangArgParser.lib %LIBRARY_BIN%\..\lib
cp %SRC_DIR%/build/lib/libpgmath.lib %LIBRARY_BIN%\..\lib
cp %SRC_DIR%/build/lib/pgmath.lib %LIBRARY_BIN%\..\lib
cp %SRC_DIR%/build/lib/ompstub.lib %LIBRARY_BIN%\..\lib
cp %SRC_DIR%/build/lib/libompstub.lib %LIBRARY_BIN%\..\lib
cp %SRC_DIR%/build/bin/libompstub.dll %LIBRARY_BIN%\..\lib
cp %SRC_DIR%/build/lib/flangrti.lib %LIBRARY_BIN%\..\lib
cp %SRC_DIR%/build/lib/libflangrti.lib %LIBRARY_BIN%\..\lib
cp %SRC_DIR%/build/lib/flang.lib %LIBRARY_BIN%\..\lib
cp %SRC_DIR%/build/lib/libflang.lib %LIBRARY_BIN%\..\lib
cp %SRC_DIR%/build/lib/flangmain.lib %LIBRARY_BIN%\..\lib
cp %SRC_DIR%/build/bin/libflangrti.dll %LIBRARY_BIN%
cp %SRC_DIR%/build/bin/libflang.dll %LIBRARY_BIN%
cp %SRC_DIR%/build/bin/flang.exe %LIBRARY_BIN%
cp %SRC_DIR%/build/bin/flang1.exe %LIBRARY_BIN%
cp %SRC_DIR%/build/bin/flang2.exe %LIBRARY_BIN%

rm %LIBRARY_BIN%\libflang.dll
rm %LIBRARY_BIN%\libflangrti.dll
rm %LIBRARY_BIN%\libompstub.dll

:: Copy the [de]activate scripts to %PREFIX%\etc\conda\[de]activate.d.
:: This will allow them to be run on environment activation.
FOR %%F IN (activate deactivate) DO (
    IF NOT EXIST %PREFIX%\etc\conda\%%F.d MKDIR %PREFIX%\etc\conda\%%F.d
    COPY %RECIPE_DIR%\%%F.bat %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.bat
)
