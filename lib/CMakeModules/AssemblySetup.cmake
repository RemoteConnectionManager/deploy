cmake_minimum_required(VERSION 2.8)

set(CMAKE_DEBUG_POSTFIX "d")
get_filename_component(_mymoduledir ${CMAKE_CURRENT_LIST_FILE} PATH)

SET(USER_MODULE_PATH "" CACHE PATH "set this to define a folder for module override")
IF(USER_MODULE_PATH)
	SET(CMAKE_MODULE_PATH "${USER_MODULE_PATH};${_mymoduledir};${CMAKE_MODULE_PATH}")
ELSE(USER_MODULE_PATH)
	SET(CMAKE_MODULE_PATH "${_mymoduledir};${CMAKE_MODULE_PATH}")
ENDIF(USER_MODULE_PATH)

# Allow the user to toggle between static/shared builds
option(EXTERNAL_ASSEMBLY_BUILD_SHARED OFF)
#


  FIND_PACKAGE(Subversion)
  IF(Subversion_FOUND)
	MESSAGE("svn exec-->${Subversion_SVN_EXECUTABLE}<-->${Subversion_VERSION_SVN}<--")
  ENDIF(Subversion_FOUND)
  
  FIND_PROGRAM(Wget wget)
  IF(Wget)
	MESSAGE("wget exec-->${Wget}")
  ENDIF(Wget)
 
  find_program(PATCH_PROGRAM patch)
   IF(PATCH_PROGRAM)
	MESSAGE("patch exec-->${PATCH_PROGRAM}")
  ENDIF()



include(ExternalProject3)

set(EXTERNAL_ASSEMBLY_BASE_BUILD ${CMAKE_BINARY_DIR}/bld)
set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/install)
set(CMAKE_PREFIX_PATH ${EXTERNAL_ASSEMBLY_COMMON_PREFIX})

#here we want the sources to accumulate
get_filename_component(EXTERNAL_ASSEMBLY_BASE_SOURCE ${CMAKE_SOURCE_DIR}/../../Sources ABSOLUTE)

#################################################################################
#this function add ann external package
#################################################################################
function(add_external_package_dir pkg ver)
	if(EXISTS ${CMAKE_SOURCE_DIR}/../../Packages/${pkg})
		if(EXISTS ${CMAKE_SOURCE_DIR}/../../Packages/${pkg}/${ver})
			add_subdirectory(${CMAKE_SOURCE_DIR}/../../Packages/${pkg}/${ver} ${EXTERNAL_ASSEMBLY_BASE_BUILD}/${pkg})
		else()
			message("NOT FOUND Version ${ver} of Package  ${pkg} in ${CMAKE_SOURCE_DIR}/../../Packages/${pkg}")
		endif()
	else()
		message("NOT FOUND Package ${pkg} in ${CMAKE_SOURCE_DIR}/../../Packages")
	endif()
endfunction(add_external_package_dir)

#################################################################################
#this function get setup variables into package cmakelists when called with the list of used vars
#################################################################################
function(PackageSetup )
	get_filename_component(Package_Dir ${CMAKE_PARENT_LIST_FILE} PATH)
	get_filename_component(tmp ${Package_Dir} PATH)
	get_filename_component(VERSION ${Package_Dir} NAME)
	get_filename_component(PACKAGE ${tmp} NAME)
	

	set(Package_std_cmake_args -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR> -DCMAKE_PREFIX_PATH:PATH=<INSTALL_DIR> -DCMAKE_MODULE_PATH:PATH=${CMAKE_MODULE_PATH} -DCMAKE_DEBUG_POSTFIX:STRING=${CMAKE_DEBUG_POSTFIX} -DBUILD_SHARED_LIBS:BOOL=${EXTERNAL_ASSEMBLY_BUILD_SHARED} )
	set(Package_Source_Stamp_Dir ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/stamp )
	set(Package_std_source_dirs 
		SOURCE_DIR ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/src
		SRCSTAMP_DIR ${Package_Source_Stamp_Dir}
		DOWNLOAD_DIR ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/download
	)
	set(Package_std_binary_dirs
		BINARY_DIR ${EXTERNAL_ASSEMBLY_BASE_BUILD}/${PACKAGE}/build
		INSTALL_DIR ${EXTERNAL_ASSEMBLY_COMMON_PREFIX}
	)
	set(Package_std_dirs ${Package_std_source_dirs} ${Package_std_binary_dirs})

	message("Processing Package ${PACKAGE} in-->${Package_Dir}")
	if(ARGN)
		set(varlist ${ARGN})
	else()
		set(varlist 
			Package_Dir
			VERSION 
			PACKAGE 
			Package_std_cmake_args 
			Package_Source_Stamp_Dir 
			Package_std_source_dirs 
			Package_std_binary_dirs
			Package_std_dirs
		)
		message(STATUS "exporting all vars-->${varlist}<--")
	endif()
	foreach(var ${varlist})
		if(NOT ${var})
			message(FATAL_ERROR "PackageSetup does not have ${var} Variable ")
		else()
			set(${var} "${${var}}" PARENT_SCOPE)
		endif()
	endforeach()
endfunction(PackageSetup)

#################################################################################
#this function builds a cmake patch files out of a list of patches found in Patch folder
#################################################################################
function(PackageWriteMultiPatchFile outvar)
	set(mycommand "")
	#message("------------->${ARGN}<--------")
	foreach(p ${ARGN} )
		if(WIN32)
			set(PATCH_COMMAND_LINE "${PATCH_PROGRAM} -p1 --binary -i ${Package_Dir}/Patch/${p}")
		else()
			set(PATCH_COMMAND_LINE "${PATCH_PROGRAM} -p1 -i ${Package_Dir}/Patch/${p}")
		endif()
		set(mycommand "${mycommand} 
		execute_process(COMMAND ${PATCH_COMMAND_LINE}
			RESULT_VARIABLE status_code
			OUTPUT_VARIABLE log)
		if(NOT status_code EQUAL 0)
			message(FATAL_ERROR \"patch error in line: ${PATCH_COMMAND_LINE}
				status_code: \${status_code}
				log: \${log}
			\")
		endif()
		")
	endforeach(p)
	set(${outvar} ${mycommand} PARENT_SCOPE)
	#message("--->${mycommand}<--")

endfunction(PackageWriteMultiPatchFile)