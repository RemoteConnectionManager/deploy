#this imports variables here
PackageSetup()
####################################################################
#this is to patch a bug in file gzguts.h 
#equivalent to adding --->#  define snprintf _snprintf
# if(MSVC)
# 	set(MY_CMAKE_C_FLAGS "/Dsnprintf=_snprintf ${CMAKE_C_FLAGS}")
# endif()	
# message("Building ${PACKAGE} with -->-DCMAKE_C_FLAGS=${MY_CMAKE_C_FLAGS}")
#####################################################################

set(Package_source_setup
	URL http://zlib.net/current/zlib-1.2.6.tar.gz
	URL_MD5 618e944d7c7cd6521551e30b32322f4a
	PATCH_COMMAND ${CMAKE_COMMAND} -E remove zconf.h
)

PackageCmakeAdd()



