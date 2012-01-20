#this imports variables here
PackageSetup()


if(UNIX)
  if(APPLE)
     #set(custom_cmake_args -DCMAKE_OSX_ARCHITECTURES=i386 -DDESIRED_QT_VERSION=10000 -DOSG_DEFAULT_IMAGE_PLUGIN_FOR_OSX=imageio -DOSG_WINDOWING_SYSTEM=Cocoa)
     set(custom_cmake_args  "")
     set(make_command "")
  else()
     set(make_command BUILD_COMMAND make --jobs 8)
     set(custom_cmake_args "")
  endif()
else()
  set(make_command "")
  set(custom_cmake_args "")
endif()

set(Package_specific_cmake_args ${custom_cmake_args} -DBUILD_EXAMPLES:BOOL=${${PACKAGE}_examples})

set(Package_source_setup
	SVN_REPOSITORY http://www.openscenegraph.org/svn/VirtualPlanetBuilder/trunk/
#	URL_MD5 c43a25d023e635c3566b2083d8e6d956 
#	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
#	UPDATE_COMMAND ""
)

PackageCmakeAdd()




