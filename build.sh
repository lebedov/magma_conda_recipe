#!/bin/bash

export CUDADIR=/usr/local/cuda
cp -f make.inc-examples/make.inc.openblas make.inc
sed -i 's/^#GPU_TARGET ?= \([[:alnum:][:blank:]]\+\)/GPU_TARGET ?= sm_35/' make.inc
sed -i 's/^NVCC\s*= nvcc/NVCC = \/usr\/local\/cuda\/bin\/nvcc/' make.inc
sed -i 's/^#OPENBLASDIR ?= \/usr\/local\/openblas/OPENBLASDIR ?= \($PREFIX\)/' make.inc
cat >> make.inc <<EOF
CFLAGS += -D_FORCE_INLINES
CXXFLAGS += -D_FORCE_INLINES
NVCCFLAGS += -D_FORCE_INLINES
EOF

export OPENBLASDIR=$CONDA_PREFIX
make -j $CPU_COUNT shared lib
prefix=$PREFIX make install
