cmake_minimum_required(VERSION 2.8)
include(../../CMakeModules/AssemblySetup.cmake)

set(pkg unzip)
set(Package_search_hints NO_SYSTEM_ENVIRONMENT_PATH)

set(Package_search_hints "")

find_package(${pkg} ${Package_search_hints})

add_external_package_dir(zlib 1.2.3.9_beta)


add_external_package_dir(osg4web B7)
#
##add_external_package_dir(unzip)
add_external_package_dir(zip 3.0)
add_external_package_dir(gzip 1.3.12)
###add_external_package_dir(bzip2 1.0.5)
add_external_package_dir(patch 2.5.9)
add_external_package_dir(md5deep 3.5.1)
##
##
##