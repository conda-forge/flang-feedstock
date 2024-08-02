setlocal enabledelayedexpansion

set "_OLD_FC=%FC%"
set "_OLD_FFLAGS=%FFLAGS%"
set "_OLD_LD=%LD%"
set "_OLD_LDFLAGS=%LDFLAGS%"

:: flang 18 still uses "temporary" name
set "FC=flang-new"
set "LD=lld-link.exe"

:: need to read clang version for path to compiler-rt
FOR /F "tokens=* USEBACKQ" %%F IN (`clang.exe -dumpversion`) DO (
    SET "_CLANG_VER=%%F"
)

:: following https://github.com/conda-forge/clang-win-activation-feedstock/blob/main/recipe/activate-clang_win-64.bat
set "FFLAGS=-D_CRT_SECURE_NO_WARNINGS -nostdlib -fms-runtime-lib=dll -fuse-ld=lld -fno-aligned-allocation"
set "LDFLAGS=-nostdlib -Wl,-defaultlib:%CONDA_PREFIX:\=/%/lib/clang/!CLANG_VER:~0,2!/lib/windows/clang_rt.builtins-x86_64.lib"
