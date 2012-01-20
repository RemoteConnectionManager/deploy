cmake_minimum_required(VERSION 2.8)
include(../../CMakeModules/AssemblySetup.cmake)

SET(ZLIB_NAMES z zlib zdll)
set(sflags NO_SYSTEM_ENVIRONMENT_PATH NO_DEFAULT_PATH)
FIND_LIBRARY(
	pippo NAMES ${ZLIB_NAMES} 
	${sflags}
)

message("pippo-->${pippo}<---")
add_external_package_dir(osg 2.9.7)

