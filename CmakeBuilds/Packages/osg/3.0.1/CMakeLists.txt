#this imports variables here
#override default as we force osg shared build
message("here in osg CMAKE_FIND_ROOT_PATH_MODE_LIBRARY-->${CMAKE_FIND_ROOT_PATH_MODE_LIBRARY}<--")
option(osg_shared "build   ${PACKAGE} shared" ON)
set(EXTERNAL_ASSEMBLY_BUILD_SHARED osg_shared)

PackageSetup()
option(${PACKAGE}_examples "build   ${PACKAGE} examples" OFF)
#these are the patches to apply (order important???)
#to obtain successive patches:
#modify
#copy the mod to

#diff -Nur src_orig src > ..\..\..\Packages\osg\2.9.7\Patch\OpenThreads_versions.diff

##########################################################
#
#currently on Ubuntu need to have opengl dev so
#sudo apt-get install libgl1-mesa-glx libglu1-mesa-dev
#
##########################################################

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

set(Package_specific_cmake_args ${custom_cmake_args} -DBUILD_EXAMPLES:BOOL=${${PACKAGE}_examples})

set(Package_source_setup
	URL http://www.openscenegraph.org/downloads/stable_releases/OpenSceneGraph-3.0.1/source/OpenSceneGraph-3.0.1.zip
	URL_MD5 c43a25d023e635c3566b2083d8e6d956 
#	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
#	UPDATE_COMMAND ""
)

PackageCmakeAdd()




# ExternalProject_Add(
	# ${PACKAGE}-GetSource
	# SOURCE_DIR ${Package_Source_Dir}
	# STAMP_DIR ${Package_Source_Stamp_Dir}
	# URL 
	# URL_MD5 0d18aa6ccb8f0fc75ed7ebec1ac3b010
	# PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	# UPDATE_COMMAND ""
	# CONFIGURE_COMMAND ""
	# BUILD_COMMAND ""
	# INSTALL_COMMAND ""
# )

# if(Package_current_dependencies_effective_line)
	# set( Package_current_dependencies_effective_line ${Package_current_dependencies_effective_line} ${PACKAGE}-GetSource)
# else()
	# set(Package_current_dependencies_effective_line DEPENDS ${PACKAGE}-GetSource)
# endif()


# ExternalProject_Add(
	# ${PACKAGE}
	# ${Package_std_dirs}
	# DOWNLOAD_COMMAND ""	
	# CMAKE_COMMAND ${CMAKE_COMMAND}
	# CMAKE_ARGS 
		# ${Package_std_cmake_args}
# #		-DBUILD_OSG_EXAMPLES:BOOL=ON
        	# ${custom_cmake_args}
	# ${make_command}
	# ${Package_current_dependencies_effective_line}
	# STEP_TARGETS configure build
# )



