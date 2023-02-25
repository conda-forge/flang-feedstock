#!/bin/bash
set -ex

# copy symlink & its target, e.g. libFortranRuntime.16.dylib & libFortranRuntime.dylib
cp $SRC_DIR/build/lib/libFortranRuntime*${SHLIB_EXT}* $PREFIX/lib
