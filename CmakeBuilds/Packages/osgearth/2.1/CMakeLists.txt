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

#set(Package_specific_cmake_args ${custom_cmake_args} -DBUILD_EXAMPLES:BOOL=${${PACKAGE}_examples})

set(Package_source_setup
	#URL https://github.com/gwaldron/osgearth/zipball/osgearth_2.1_T2011-08-31
	URL http://rvn05.plx.cineca.it:12000/files/ITABC/public/cmake_packages/osgearth_2.1_T2011-08-31.zip
	URL_MD5 dc927cc2414fbee43e09d3b092551079 
#	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
#	UPDATE_COMMAND ""
)

PackageCmakeAdd()




