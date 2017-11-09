cd %SRC_DIR%\build
nmake install
if errorlevel 1 exit 1

rm %LIBRARY_BIN%\flang.dll
rm %LIBRARY_BIN%\flangrti.dll
rm %LIBRARY_BIN%\ompstub.dll

:: Copy the [de]activate scripts to %PREFIX%\etc\conda\[de]activate.d.
:: This will allow them to be run on environment activation.
FOR %%F IN (activate deactivate) DO (
    IF NOT EXIST %PREFIX%\etc\conda\%%F.d MKDIR %PREFIX%\etc\conda\%%F.d
    COPY %RECIPE_DIR%\%%F.bat %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.bat
)
