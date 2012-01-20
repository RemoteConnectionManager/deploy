#this imports variables here
PackageSetup()

if(WIN32)
  #this setuse of external boost configured as static
  set(Package_specific_cmake_args -DWITH_SYSTEM_BOOST:BOOL=ON -DBoost_USE_STATIC_LIBS:BOOL=ON)

  #this is the folder where projects are (subdir of osgweb
  set(Package_specific_cmake_args ${Package_specific_cmake_args} -DPROJECTS_DIR=<SOURCE_DIR>/../../../osg4web/B7/src/firebreath_projects)
  set(Package_build_command BUILD_COMMAND ${CMAKE_COMMAND} --build . --config Release --target OSG4WebFirebreathPlugin)
else()
  #this is the folder where projects are (subdir of osgweb
  set(Package_specific_cmake_args ${Package_specific_cmake_args} -DPROJECTS_DIR=<SOURCE_DIR>/../../../osg4web/Linux/src)
   set(Package_build_command "")
endif()

set(Package_source_setup
	URL http://firebreath.googlecode.com/files/firebreath-1.6.0rc1.tar.gz
	URL_MD5 2d7428c687b66f54d3bd39f9bfa68861
)


PackageCmakeAdd()



