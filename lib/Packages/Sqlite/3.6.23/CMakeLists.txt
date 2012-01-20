#from http://www.sqlite.org/
#this imports variables here
PackageSetup()

set(Package_source_setup
                URL http://www.sqlite.org/sqlite-amalgamation-3.6.23.tar.gz
                URL_MD5 8f1e86b3909a27f8122b0981afd16fcd
		PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Patch/CMakeLists.txt <SOURCE_DIR>
)


if(WIN32)
	

	PackageCmakeAdd()
else()
	PackageUnixConfigureAdd()
# 	#skipping configure make and install as required as source
# 	ExternalProject_Add(
# 		${PACKAGE}
# 		${Package_std_dirs}
# 		URL http://www.sqlite.org/sqlite-amalgamation-3.6.23.tar.gz
# 		CONFIGURE_COMMAND <SOURCE_DIR>/configure --srcdir=<SOURCE_DIR>
# --prefix=<INSTALL_DIR>
# 	)
		
endif()



