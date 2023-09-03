#!/bin/bash
set -ex

if [[ "${target_platform}" == linux-* ]]; then
    # copy symlink & its target, e.g. libFortranRuntime.so.16 & libFortranRuntime.so
    cp $SRC_DIR/build/lib/libFortranRuntime*${SHLIB_EXT}* $PREFIX/lib
    # same for libFortranDecimal
    cp $SRC_DIR/build/lib/libFortranDecimal*${SHLIB_EXT}* $PREFIX/lib
else
    # static builds on unix due to segfaults with shared ones
    cp $SRC_DIR/build/lib/libFortranRuntime.a $PREFIX/lib
    cp $SRC_DIR/build/lib/libFortranDecimal.a $PREFIX/lib
fi
