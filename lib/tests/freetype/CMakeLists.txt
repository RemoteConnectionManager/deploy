cmake_minimum_required(VERSION 2.8)

include(../../CMakeModules/AssemblySetup.cmake)



# set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/../install/libs)
# set(CMAKE_PREFIX_PATH "${CMAKE_PREFIX_PATH};${EXTERNAL_ASSEMBLY_COMMON_PREFIX}")
# set(CMAKE_FIND_ROOT_PATH "${CMAKE_PREFIX_PATH}" )
# set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)

add_external_package_dir(Freetype 2.4.6)
#add_external_package_dir(CURL )
