#!/bin/bash
set -ex

cd $SRC_DIR/build

cmake --install .

# don't repackage libflang output
rm $PREFIX/lib/libFortranRuntime*
# same for libfortran-main
rm $PREFIX/lib/libFortran_main.a

for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    cp "${RECIPE_DIR}/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}_${CHANGE}.sh"
done
