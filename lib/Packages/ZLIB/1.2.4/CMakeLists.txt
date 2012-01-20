#this imports variables here
PackageSetup()
####################################################################
#this is to patch a bug in file gzguts.h 
#equivalent to adding --->#  define snprintf _snprintf
if(MSVC)
	set(MY_CMAKE_C_FLAGS "/Dsnprintf=_snprintf ${CMAKE_C_FLAGS}")
else()
#this is to avoid linking errors on AMD64, basically add -fPIC also to static lib buildslike
#relocation R_X86_64_32S
#see
#http://www.cmake.org/pipermail/cmake/2006-September/011316.html
#http://www.gentoo.org/proj/en/base/amd64/howtos/index.xml?part=1&chap=3

#old#	if("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
#old#		set(MY_CMAKE_C_FLAGS "-fPIC ${CMAKE_C_FLAGS}")
#old#	else()
#old#		set(MY_CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
#old#	endif()
endif()	
message("Building ${PACKAGE} with -->-DCMAKE_C_FLAGS=${MY_CMAKE_C_FLAGS}")
#####################################################################

#these are the patches to apply (order important???)
PackageWriteMultiPatchFile(tmp     
	zconf_in_source.diff
	zconf_install.diff
)

file(WRITE ${Package_Source_Stamp_Dir}/patch.cmake ${tmp})


ExternalProject_Add(
	${PACKAGE}
	${Package_std_dirs}
	URL http://zlib.net/current/zlib-1.2.4.tar.gz
	PATCH_COMMAND ${CMAKE_COMMAND} -P ${Package_Source_Stamp_Dir}/patch.cmake
	CMAKE_COMMAND ${CMAKE_COMMAND}
	CMAKE_ARGS 
		${Package_std_cmake_args}
)

