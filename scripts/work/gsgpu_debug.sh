#!/bin/sh
export GSGPU_DEBUG_LEVEL=2
export MESA_LOADER_DRIVER_OVERRIDE=gsgpu
export MESA_GL_VERSION_OVERRIDE=3.1
export LD_LIBRARY_PATH=/home/loongson/build/lib:/home/loongson/build/lib64
export LIBGL_DRIVERS_PATH=/home/loongson/build/lib/dri
export DISPLAY=:0.0
