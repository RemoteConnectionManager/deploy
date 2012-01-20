#from http://www.sqlite.org/download.html

PackageSetup()

if(WIN32)
	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		URL http://www.sqlite.org/sqlite-amalgamation-3.7.3.tar.gz
		${Package_current_dependencies_effective_line}

		#This patch commands copy in the folder the provided makefilechange the name of scripts/libpng.pc.in to scripts/libpng-pc.in as it breaks the cmake command
		PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Patch/CMakeLists.txt <SOURCE_DIR>

		CMAKE_COMMAND ${CMAKE_COMMAND}
		CMAKE_ARGS 
			${Package_std_cmake_args}
#			${Package_add_cmake_args}
	)
else()
	message(FATAL_ERROR "package ${PACKAGE} not currently available for Linux")
	#skipping configure make and install as required as source
	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		URL http://www.sqlite.org/sqlite-amalgamation-3.7.3.tar.gz
		CONFIGURE_COMMAND <SOURCE_DIR>/configure --srcdir=<SOURCE_DIR>
--prefix=<INSTALL_DIR>
	)
	
	
	
endif()



