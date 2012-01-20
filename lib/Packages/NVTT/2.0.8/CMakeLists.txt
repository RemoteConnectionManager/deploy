####################################################################
#These options seems to be mutually exclusive, 
#so depending on the assembly setup decide weather configure static or shared
####################################################################


#this imports variables here
PackageSetup()

# if(BUILD_SHARED_LIBS)
	# set(tmp OFF)
# else()
	# set(tmp ON)
# endif()
if(MSVC)
	set(${PACKAGE}_CMAKE_EXE_LINKER_FLAGS_RELEASE /NODEFAULTLIB:LIBCMT CACHE STRING "string to fix linking problems" )
endif()
message("here CMAKE_PREFIX_PATH -->${CMAKE_PREFIX_PATH}<--")
option(${PACKAGE}_static "build  ${PACKAGE} static" ON)

# FIND_PACKAGE(Ldap)
# if(LDAP_FOUND)
	# set(tmp OFF)
# else()
	# set(tmp ON)
# endif()
# option(${PACKAGE}_disable_ldap "build  ${PACKAGE} without ldap" ${tmp})




# PackageWriteMultiPatchFile(tmp 
	# p1.patch
# )

# file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})


set(Package_source_setup
	URL http://nvidia-texture-tools.googlecode.com/files/nvidia-texture-tools-2.0.8-1.tar.gz
	URL_MD5 7449c95ca1583b512561c83c5a5f401c
#	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	UPDATE_COMMAND ""
    )

if(${PACKAGE}_static)
	set(Package_specific_cmake_args  ${Package_specific_cmake_args} -DNVTT_SHARED:BOOL=OFF)
	set(BUILD_SHARED_LIBS OFF)
endif()
if(MSVC)
	set(Package_specific_cmake_args  ${Package_specific_cmake_args} -DCMAKE_EXE_LINKER_FLAGS_RELEASE:STRING=${${PACKAGE}_CMAKE_EXE_LINKER_FLAGS_RELEASE})
endif()
# if(UNIX) 
    # set(Package_specific_cmake_args ${Package_specific_cmake_args} -DPNG_NO_STDIO:BOOL=OFF)
# endif()
####################################################################
	

PackageCmakeAdd()