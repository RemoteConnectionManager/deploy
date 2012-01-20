# - wrapper for rall FindPkgConfig module in CMake root
#
# add pkgconfig files in CMAKE_PREFIX_PATH to PKG_CONFIG_PATH env ar
# to help FindPkgConfig module to find custom modules instead od system one
#


message("custom FindOpenGL   CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH -->${CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH}<--")

set(_tmp_CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ${CMAKE_FIND_ROOT_PATH_MODE_LIBRARY})
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
include(${CMAKE_ROOT}/Modules/FindOpenGL.cmake)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ${_tmp_CMAKE_FIND_ROOT_PATH_MODE_LIBRARY})
