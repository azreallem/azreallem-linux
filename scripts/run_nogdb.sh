#!/bin/sh

env -i TERM=screen \
	DISPLAY=:0.0 \
	GALLIUM_PRINT_OPTIONS="y" \
	GSGPU_DEBUG=nir,vs,ps,gs,cs \
	GSGPU_DEBUG_LEVEL=1  \
	GSGPU_DUMP_SHADERS="true" \
	LP_DEBUG=1 \
	ST_DEBUG=1 \
	MESA_GLSL=dump,log \
	MESA_DEBUG=1 \
	LIBGL_DEBUG=1 \
	MESA_LOG_FILE=./mesa.log \
	MESA_LOADER_DRIVER_OVERRIDE=gsgpu \
	MESA_GL_VERSION_OVERRIDE=3.3 \
	LD_LIBRARY_PATH=/home/loongson/Workspace/build/lib:/home/loongson/Workspace/build/lib64 \
	LIBGL_DRIVERS_PATH=/home/loongson/Workspace/build/lib/dri  \
	${1}
