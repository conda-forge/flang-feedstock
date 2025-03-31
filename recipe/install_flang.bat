@echo on

cd %SRC_DIR%\build

cmake --build . --target install
if %ERRORLEVEL% neq 0 exit 1

cd ..
rmdir /s /q build
