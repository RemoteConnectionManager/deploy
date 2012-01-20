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
option(EXTERNAL_ASSEMBLY_BUILD_SHARED_HINT OFF)
set(EXTERNAL_ASSEMBLY_BUILD_SHARED ${EXTERNAL_ASSEMBLY_BUILD_SHARED_HINT})
#

# Allow the user to decide if Packages that use Find have to search in environment
option(EXTERNAL_ASSEMBLY_SEARCH_AND_USE_SYSTEM_MODULES "set to on if you prefer system modules" OFF)
if(NOT EXTERNAL_ASSEMBLY_SEARCH_AND_USE_SYSTEM_MODULES)
	set(Package_search_hints NO_SYSTEM_ENVIRONMENT_PATH NO_DEFAULT_PATH)
endif()
#
set(Package_list "")
set(Package_list_added "")
  


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



include(ExternalProject)

set(EXTERNAL_ASSEMBLY_BASE_BUILD ${CMAKE_BINARY_DIR}/bld)
set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/install)
set(CMAKE_PREFIX_PATH ${EXTERNAL_ASSEMBLY_COMMON_PREFIX})

#here we want the sources to accumulate
get_filename_component(EXTERNAL_ASSEMBLY_BASE_SOURCE ${CMAKE_SOURCE_DIR}/../../Sources ABSOLUTE)





#################################################################################
#this function really resolve a dependency, either find something or insert external
#################################################################################
function(add_external_package_dir pkg)
	get_filename_component(Package_source ${CMAKE_SOURCE_DIR}/../../Packages/${pkg} ABSOLUTE)
	message("WARNING testing  for ${pkg}  in folder -->${Package_source}<-- ARGV1-->${ARGV1}<--ARGC-->${ARGC}<--")
	if(ARGC GREATER 1)
		set(ver ${ARGV1})
	else()
		if(EXISTS ${Package_source}/Default.cmake)
			include(${Package_source}/Default.cmake)
			set(ver ${Package_default_version})
		else()
			file(GLOB versions RELATIVE ${Package_source} "${Package_source}/*")
			list(SORT versions)
			message("available versions for package ${pkg} in folder -->${Package_source}<-->${versions}")
			list(GET versions 0 ver)
		endif()
	endif()
	list(FIND Package_list ${pkg} pkg_found)
	if(pkg_found LESS 0)
		if(EXISTS ${Package_source}/${ver})
			message("########### handling package ${pkg} --->${Package_list}<--")
			unset(mymodulefile CACHE)
			find_file(
				mymodulefile 
				NAMES Find${pkg}.cmake ${pkg}Config.cmake
				PATHS ${CMAKE_MODULE_PATH} ${CMAKE_ROOT}/Modules 
			)
			message("mymodulefile-->${mymodulefile}<--")
			set(my_found 0)
			if(mymodulefile)
				get_cmake_property(previous_cache_var CACHE_VARIABLES)
								
				#find_package(${pkg} ${Package_search_hints}) #disable ${Package_search_hints} for packages
				find_package(${pkg} )
				
				if(${pkg}_FOUND)
					message(HERE!!!! found -->${pkg}<-- skipping external)
					set(my_found 1)
				else()
					get_cmake_property(current_cache_var CACHE_VARIABLES)
					list(REMOVE_ITEM current_cache_var ${previous_cache_var})
					foreach(v ${current_cache_var})
						message("unset cache var ->${v}<-->${${v}}<-")
						unset(${v} CACHE)
					endforeach()
				endif()
			else()
				message("NOT FOUND module ->${pkg}<- in files Find${pkg}.cmake ${pkg}Config.cmake in paths ${CMAKE_MODULE_PATH} ${CMAKE_ROOT}/Modules")
			endif()
			if(NOT my_found)
				set(Package_current_dependencies_effective "")
				if(EXISTS ${Package_source}/Depends.cmake)
					set(Package_current_dependencies "")
					include(${Package_source}/Depends.cmake)
					message("WARNING!!!!########## handling deps for ${pkg} -->${Package_current_dependencies}<--")
					foreach(mymodule ${Package_current_dependencies})
						add_external_package_dir(${mymodule})
						list(FIND Package_list_added ${mymodule} _found)
						if(NOT _found LESS 0)
							set(Package_current_dependencies_effective ${Package_current_dependencies_effective} ${mymodule})
						endif()
					endforeach()
				endif()
				if(Package_current_dependencies_effective)
					set(Package_current_dependencies_effective_line DEPENDS ${Package_current_dependencies_effective})
				else()
					set(Package_current_dependencies_effective_line "")
				endif()
				message("@@@@@@@@add_subdirectory(${Package_source}/${ver} ${EXTERNAL_ASSEMBLY_BASE_BUILD}/${pkg}) with dep line -->${Package_current_dependencies_effective_line}<--")
				add_subdirectory(${Package_source}/${ver} ${EXTERNAL_ASSEMBLY_BASE_BUILD}/${pkg})
				list(APPEND Package_list_added ${pkg})
			endif()
		endif()
		list(APPEND Package_list ${pkg})
	endif()
	set(Package_list ${Package_list}  PARENT_SCOPE)
	set(Package_list_added ${Package_list_added}  PARENT_SCOPE)
endfunction(add_external_package_dir)


#################################################################################
#this function add ann external package
#################################################################################
function(add_external_package_dir_old pkg)
	message("WARNING testing  for ${pkg}  ARGV1-->${ARGV1}<--ARGC-->${ARGC}<--")
	if(ARGC GREATER 1)
		set(ver ${ARGV1})
	else()
		get_filename_component(Package_source ${CMAKE_SOURCE_DIR}/../../Packages/${pkg} ABSOLUTE)
		file(GLOB versions RELATIVE ${Package_source} "${Package_source}/*")
		list(SORT versions)
		message("available versions for package ${pkg} in folder -->${Package_source}<-->${versions}")
		list(GET versions 0 ver)
	endif()
	list(FIND Package_list ${pkg} pkg_found)
	if(pkg_found LESS 0)
		message("########### handling package ${pkg} --->${Package_list}<--")
		if(EXISTS ${CMAKE_SOURCE_DIR}/../../Packages/${pkg})
			if(EXISTS ${CMAKE_SOURCE_DIR}/../../Packages/${pkg}/Include.cmake)
				include(${CMAKE_SOURCE_DIR}/../../Packages/${pkg}/Include.cmake)
				Package_Handle(${ver})
			else()
				if(EXISTS ${CMAKE_SOURCE_DIR}/../../Packages/${pkg}/Depends.cmake)
					set(Package_current_dependencies "")
					include(${CMAKE_SOURCE_DIR}/../../Packages/${pkg}/Depends.cmake)
					message("WARNING!!!!########## handling deps for ${pkg} -->${Package_current_dependencies}<--")
					set(Package_current_dependencies_effective "")
					foreach(mymodule ${Package_current_dependencies})
						unset(mymodulefile CACHE)
						find_file(
							mymodulefile 
							NAMES Find${mymodule}.cmake ${mymodule}Config.cmake
							PATHS ${CMAKE_MODULE_PATH} ${CMAKE_ROOT}/Modules 
						)
						message("mymodulefile-->${mymodulefile}<--")
						set(my_found 0)
						if(mymodulefile)
							get_cmake_property(previous_cache_var CACHE_VARIABLES)
							find_package(${mymodule} ${Package_search_hints})
							if(${mymodule}_FOUND)
								message(HERE!!!! found -->${mymodule}<-- skipping external)
								set(my_found 1)
							else()
								get_cmake_property(current_cache_var CACHE_VARIABLES)
								list(REMOVE_ITEM current_cache_var ${previous_cache_var})
								foreach(v ${current_cache_var})
									message("unset cache var ->${v}<-->${${v}}<-")
									unset(${v} CACHE)
								endforeach()
							endif()
						else()
							message("NOT FOUND module ->${mymodule}<- in files Find${mymodule}.cmake ${mymodule}Config.cmake in paths ${CMAKE_MODULE_PATH} ${CMAKE_ROOT}/Modules")
						endif()
						if(NOT my_found)
							message("DEBUG-----add_external_package_dir_old(${mymodule})")
							add_external_package_dir_old(${mymodule})
							set(Package_current_dependencies_effective "${Package_current_dependencies_effective} ${mymodule}")
						endif()
					endforeach()
				endif()
				if(EXISTS ${CMAKE_SOURCE_DIR}/../../Packages/${pkg}/${ver})
					list(APPEND Package_list ${pkg})
					if(Package_current_dependencies_effective)
						set(Package_current_dependencies_effective_line "DEPENDS ${Package_current_dependencies_effective}")
					else()
						set(Package_current_dependencies_effective_line "")
					endif()
					add_subdirectory(${CMAKE_SOURCE_DIR}/../../Packages/${pkg}/${ver} ${EXTERNAL_ASSEMBLY_BASE_BUILD}/${pkg})
				else()
					message("NOT FOUND Version ${ver} of Package  ${pkg} in ${CMAKE_SOURCE_DIR}/../../Packages/${pkg}")
				endif()
			endif()
		else()
			message("NOT FOUND Package ${pkg} in ${CMAKE_SOURCE_DIR}/../../Packages")
		endif()
	endif()
	set(Package_list ${Package_list}  PARENT_SCOPE)
endfunction(add_external_package_dir_old)

#################################################################################
#this function get setup variables into package cmakelists when called with the list of used vars
#################################################################################
function(PackageSetup )
	get_filename_component(Package_Dir ${CMAKE_PARENT_LIST_FILE} PATH)
	get_filename_component(tmp ${Package_Dir} PATH)
	get_filename_component(VERSION ${Package_Dir} NAME)
	get_filename_component(PACKAGE ${tmp} NAME)
	

	set(_f1 -DBUILD_SHARED_LIBS:BOOL=${EXTERNAL_ASSEMBLY_BUILD_SHARED})
	if(NOT EXTERNAL_ASSEMBLY_BUILD_SHARED)
		#this is to avoid linking errors on AMD64, basically add -fPIC also to static lib buildslike
		#relocation R_X86_64_32S
		#see
		#http://www.cmake.org/pipermail/cmake/2006-September/011316.html
		#http://www.gentoo.org/proj/en/base/amd64/howtos/index.xml?part=1&chap=3

		if("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "x86_64" )
			set(_f2 -DCMAKE_C_FLAGS:STRING=-fPIC ${CMAKE_C_FLAGS})
			set(_f3 -DCMAKE_CXX_FLAGS:STRING=-fPIC ${CMAKE_CXX_FLAGS})
		endif()
	endif()
	set(Package_std_cmake_args -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR> -DCMAKE_PREFIX_PATH:PATH=<INSTALL_DIR> -DCMAKE_MODULE_PATH:PATH=${CMAKE_MODULE_PATH} -DCMAKE_DEBUG_POSTFIX:STRING=${CMAKE_DEBUG_POSTFIX} ${_f1} ${_f2} ${_f3})
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

function(PackageBinarySimpleAdd URL download_subfolder)
	message("!!!!! building ${PACKAGE} in  ${download_subfolder} with depnds-->${Package_current_dependencies_effective_line}<--")
	ExternalProject_Add(
		${PACKAGE}
		#WARNING!!!! this way  zip file directly expand into install/bin dir == source dir
		DOWNLOAD_DIR ${download_subfolder}
		SOURCE_DIR ${EXTERNAL_ASSEMBLY_COMMON_PREFIX}
		URL ${URL}
		INSTALL_COMMAND ""
		CONFIGURE_COMMAND ""
		BUILD_COMMAND ""
		${Package_current_dependencies_effective_line}

	)
endfunction(PackageBinarySimpleAdd)


function(PackageWindowsBinarySimpleAdd URL)
		message("!!!!! building ${PACKAGE} as win32 bin external with depnds-->${Package_current_dependencies_effective_line}<--")
		ExternalProject_Add(
			${PACKAGE}
			#WARNING!!!! this way  zip file directly expand into install/bin dir == source dir
			DOWNLOAD_DIR ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/win32_bin_download
			SOURCE_DIR ${EXTERNAL_ASSEMBLY_COMMON_PREFIX}
			URL ${URL}
			INSTALL_COMMAND ""
			CONFIGURE_COMMAND ""
			BUILD_COMMAND ""
			${Package_current_dependencies_effective_line}

		)
endfunction(PackageWindowsBinarySimpleAdd)

function(PackageUnixConfigureSimpleAdd URL)
		ExternalProject_Add(
			${PACKAGE}
			${Package_std_dirs}
			URL ${URL}
			CONFIGURE_COMMAND <SOURCE_DIR>/configure --srcdir=<SOURCE_DIR> --prefix=<INSTALL_DIR>
		)
endfunction(PackageUnixConfigureSimpleAdd)

function(PackageLinuxBinarySimpleAdd URL)
	PackageBinarySimpleAdd(${URL} ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/Linux_bin_download)
endfunction(PackageLinuxBinarySimpleAdd)

