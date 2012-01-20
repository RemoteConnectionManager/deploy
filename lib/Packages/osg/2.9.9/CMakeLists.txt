#this imports variables here
#override default as we force osg shared build
set(EXTERNAL_ASSEMBLY_BUILD_SHARED ON)
PackageSetup()

#these are the patches to apply (order important???)
#to obtain successive patches:
#modify
#copy the mod to

#diff -Nur src_orig src > ..\..\..\Packages\osg\2.9.7\Patch\OpenThreads_versions.diff

PackageWriteMultiPatchFile(tmp     
	module_override.diff
)
file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})

if(UNIX)
  if(APPLE)
     #set(custom_cmake_args -DCMAKE_OSX_ARCHITECTURES=i386 -DDESIRED_QT_VERSION=10000 -DOSG_DEFAULT_IMAGE_PLUGIN_FOR_OSX=imageio -DOSG_WINDOWING_SYSTEM=Cocoa)
     set(custom_cmake_args  -DOSG_DEFAULT_IMAGE_PLUGIN_FOR_OSX=imageio -DOSG_WINDOWING_SYSTEM=Cocoa)
     set(make_command "")
  else()
     set(make_command BUILD_COMMAND make --jobs 4)
     set(custom_cmake_args "")
  endif()
else()
  set(make_command "")
  set(custom_cmake_args "")
endif()

ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	URL http://www.openscenegraph.org/downloads/developer_releases/OpenSceneGraph-2.9.9.zip
	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
		-DBUILD_OSG_EXAMPLES:BOOL=ON
        	${custom_cmake_args}
	${make_command}
	${Package_current_dependencies_effective_line}
)



