# - wrapper for rall FindPkgConfig module in CMake root
#
# add pkgconfig files in CMAKE_PREFIX_PATH to PKG_CONFIG_PATH env ar
# to help FindPkgConfig module to find custom modules instead od system one
#

#message("-------CUSTOM FindPkgConfig------ with hints-->${Package_search_hints}<--")
#message("-------CUSTOM FindPkgConfig------ CMAKE_ROOT-->${CMAKE_ROOT}<--")
#message("-------CUSTOM FindPkgConfig------ CMAKE_PREFIX_PATH-->${CMAKE_PREFIX_PATH}<--")
#message("-------CUSTOM FindPkgConfig----- pre-->$ENV{PKG_CONFIG_PATH}<--") 
string(REPLACE ":" ";" pkgpath "$ENV{PKG_CONFIG_PATH}")
foreach(p ${CMAKE_PREFIX_PATH})
  list(INSERT pkgpath 0 ${p}/lib/pkgconfig)
endforeach()
list(REMOVE_DUPLICATES pkgpath)
string(REPLACE ";" ":" pkgpath_new "${pkgpath}")

set(ENV{PKG_CONFIG_PATH} ${pkgpath_new})
#message("-------CUSTOM FindPkgConfig---setting -ENV{PKG_CONFIG_PATH}--->$ENV{PKG_CONFIG_PATH}<--") 
include(${CMAKE_ROOT}/Modules/FindPkgConfig.cmake)

link_directories(${GTK_LIBRARY_DIRS})