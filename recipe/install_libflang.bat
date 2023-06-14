@echo on

dir build\lib
dir build\bin

cp build\lib\FortranRuntime.lib %LIBRARY_LIB%
cp build\lib\FortranDecimal.lib %LIBRARY_LIB%
