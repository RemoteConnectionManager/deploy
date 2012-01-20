#this imports variables here
PackageSetup()
set(Package_specific_cmake_args -DBUILD_EXAMPLES:BOOL=ON)
if(WIN32)
  #this setuse of external boost configured as static
  set(Package_specific_cmake_args -DWITH_SYSTEM_BOOST:BOOL=ON -DBoost_USE_STATIC_LIBS:BOOL=ON)

  #this is the folder where projects are (subdir of osgweb
  set(Package_specific_cmake_args ${Package_specific_cmake_args} -DFB_PROJECTS_DIR=<SOURCE_DIR>/../../../osg4web/B7/src/firebreath_projects)
  set(Package_build_command BUILD_COMMAND ${CMAKE_COMMAND} --build . --config Release --target OSG4WebFirebreathPlugin)
else()
  #this is the folder where projects are (subdir of osgweb
  set(Package_specific_cmake_args ${Package_specific_cmake_args} -DFB_PROJECTS_DIR=<SOURCE_DIR>/../../../osg4web/Linux/src)
   set(Package_build_command "")
endif()

set(Package_source_setup
#	URL https://nodeload.github.com/firebreath/FireBreath/zipball/firebreath-1.6
	GIT_REPOSITORY git://github.com/firebreath/FireBreath.git
#	URL_MD5 2d7428c687b66f54d3bd39f9bfa68861
)


PackageCmakeAdd()



