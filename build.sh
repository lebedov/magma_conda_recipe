#!/bin/bash

export CUDADIR=/usr/local/cuda
cp -f make.inc-examples/make.inc.openblas make.inc
sed -i 's/^#GPU_TARGET ?= Fermi Kepler/GPU_TARGET ?= Kepler Maxwell Pascal/' make.inc
sed -i 's/^NVCC\s*= nvcc/NVCC = \/usr\/local\/cuda\/bin\/nvcc/' make.inc
cat >> make.inc <<EOF
CFLAGS += -D_FORCE_INLINES
CXXFLAGS += -D_FORCE_INLINES
NVCCFLAGS += -D_FORCE_INLINES
EOF

export OPENBLASDIR=$CONDA_PREFIX
make -j $CPU_COUNT shared lib
prefix=$PREFIX make install
