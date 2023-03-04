cd %SRC_DIR%\build
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64

cmake --build . --target install
if %ERRORLEVEL% neq 0 exit 1

:: don't repackage libflang output
rm %LIBRARY_BIN%\FortranRuntime.dll
rm %LIBRARY_BIN%\FortranDecimal.dll
:: same for libfortran-main
rm %LIBRARY_LIB%\Fortran_main.lib

:: Copy the [de]activate scripts to %PREFIX%\etc\conda\[de]activate.d.
:: This will allow them to be run on environment activation.
FOR %%F IN (activate deactivate) DO (
    IF NOT EXIST %PREFIX%\etc\conda\%%F.d MKDIR %PREFIX%\etc\conda\%%F.d
    COPY %RECIPE_DIR%\%%F.bat %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.bat
)
