cd %SRC_DIR%\build
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64

cmake --build . --target install
if errorlevel 1 exit 1

powershell -Command "cp $env:LIBRARY_PREFIX\bin\*.exe $env:LIBRARY_BIN"
powershell -Command "cp $env:LIBRARY_PREFIX\lib\*.lib $env:LIBRARY_BIN\..\lib"
powershell -Commnd "mkdir $env:LIBRARY_BIN\..\include\flang"
powershell -Command "cp $env:LIBRARY_PREFIX\include\flang\*.mod $env:LIBRARY_BIN\..\include\flang"

rm %LIBRARY_BIN%\libflang.dll
rm %LIBRARY_BIN%\libflangrti.dll
rm %LIBRARY_BIN%\libompstub.dll

:: Copy the [de]activate scripts to %PREFIX%\etc\conda\[de]activate.d.
:: This will allow them to be run on environment activation.
FOR %%F IN (activate deactivate) DO (
    IF NOT EXIST %PREFIX%\etc\conda\%%F.d MKDIR %PREFIX%\etc\conda\%%F.d
    COPY %RECIPE_DIR%\%%F.bat %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.bat
)
