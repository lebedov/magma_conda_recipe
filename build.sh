#!/bin/bash

export CUDADIR=/usr/local/cuda
cp -f make.inc.openblas make.inc
sed -i 's/^#GPU_TARGET ?= Fermi Kepler/GPU_TARGET ?= Fermi Kepler Maxwell/' make.inc
sed -i 's/^CC\s*= gcc/CC = gcc-4.9/' make.inc
sed -i 's/^CXX\s*= g++/CXX = g++-4.9/' make.inc
sed -i 's/^FORT\s*= gfortran/FORT = gfortran-4.9/' make.inc

cat >> make.inc <<EOF
CFLAGS += -D_FORCE_INLINES
CXXFLAGS += -D_FORCE_INLINES
NVCCFLAGS += -D_FORCE_INLINES
LIB += -lgfortran
EOF

make -j $CPU_COUNT
make
prefix=$PREFIX make install
