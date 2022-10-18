#!/bin/sh

../../../build/bin/llvm-tblgen AMDGPU.td -I=/home/loongson/work/gpu/llvm-toolchain-8-8.0.1/llvm/include --print-records > ~/log/llvm/new-cur.log
