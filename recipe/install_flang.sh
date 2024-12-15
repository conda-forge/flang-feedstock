#!/bin/bash
set -ex

cd $SRC_DIR/build

cmake --install .

cd ..
rm -rf build
