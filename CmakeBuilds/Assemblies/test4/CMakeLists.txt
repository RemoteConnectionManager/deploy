cmake_minimum_required(VERSION 2.8)
include(../../CMakeModules/AssemblySetup.cmake)

  FIND_PACKAGE(Git)
  if(Git_FOUND)
	MESSAGE("git exec-->${GIT_EXECUTABLE}<--")
  endif()
  
  FIND_PACKAGE(Bazaar)
  if(Bazaar_FOUND)
	MESSAGE("bzr exec-->${Bazaar_EXECUTABLE}")
  endif()

#add_external_package_dir(zlib 1.2.3.9_beta)
#add_external_package_dir(png 1.2.41)
#add_external_package_dir(jpeg v7)
#add_external_package_dir(freetype 2.3.8)
#add_external_package_dir(curl 7.20.0)
#
##reset the hint on building shared versus static
#set(EXTERNAL_ASSEMBLY_BUILD_SHARED ON)
#add_external_package_dir(osg 2.9.7)
#
add_external_package_dir(md5deep 3.5.1)
add_external_package_dir(osg4web B7)