cmake_minimum_required(VERSION 2.8)

include(../../CMakeModules/AssemblySetup.cmake)
debug_message("configuring with generator -->${CMAKE_GENERATOR}<--")

set(CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR}/install )
set(CMAKE_FIND_ROOT_PATH "${CMAKE_PREFIX_PATH}" )
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
#set(EXTERNAL_ASSEMBLY_BUILD_SHARED_HINT ON)

add_external_package_dir(FlexSDK)
add_external_package_dir(ActiveMQ)
get_filename_component(QT_INSTALL_DIR ${CMAKE_SOURCE_DIR}/../../../install/qt ABSOLUTE)
get_filename_component(PYTHON_INSTALL_DIR ${CMAKE_SOURCE_DIR}/../../../install/python ABSOLUTE)
get_filename_component(PARAVIEW_INSTALL_DIR ${CMAKE_SOURCE_DIR}/../../../install/ParaView ABSOLUTE)
set(CMAKE_PREFIX_PATH ${EXTERNAL_ASSEMBLY_COMMON_PREFIX} ${QT_INSTALL_DIR} ${PYTHON_INSTALL_DIR} ${PARAVIEW_INSTALL_DIR})
add_external_package_dir(ParaViewWeb)

