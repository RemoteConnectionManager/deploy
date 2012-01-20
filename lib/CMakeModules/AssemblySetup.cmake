
function(debug_message)
	if(MESSAGE_DEBUG_ACTIVE)
		message("${ARGN}")
	endif()
endfunction(debug_message)

option(MESSAGE_DEBUG_ACTIVE OFF)




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
option(EXTERNAL_ASSEMBLY_INDIVIDUAL_INSTALL_PACKAGE "set to on to install each package into its own folder" OFF)

# Allow the user to decide if Packages that use Find have to search in environment
option(EXTERNAL_ASSEMBLY_SEARCH_AND_USE_SYSTEM_MODULES "set to on if you prefer system modules" OFF)
if(NOT EXTERNAL_ASSEMBLY_SEARCH_AND_USE_SYSTEM_MODULES)
	#set(Package_search_hints NO_SYSTEM_ENVIRONMENT_PATH NO_DEFAULT_PATH)
	set(Package_search_hints NO_SYSTEM_ENVIRONMENT_PATH)
endif()

#
if(UNIX)
	set(EXTERNAL_ASSEMBLY_BUILD_COMMAND "make;-j;4" CACHE STRING "set this to define a folder for module override")
endif()
#
set(Package_list "")
set(Package_list_added "")
  

# 
#   FIND_PACKAGE(Subversion)
#   IF(Subversion_FOUND)
# 	debug_message("svn exec-->${Subversion_SVN_EXECUTABLE}<-->${Subversion_VERSION_SVN}<--")
#   ENDIF(Subversion_FOUND)
  
 
  find_program(PATCH_PROGRAM patch)
   IF(PATCH_PROGRAM)
	debug_message("patch exec-->${PATCH_PROGRAM}")
  ENDIF()


  include(ExternalProject)

set(EXTERNAL_ASSEMBLY_BASE_BUILD ${CMAKE_BINARY_DIR}/bld)
set(EXTERNAL_ASSEMBLY_COMMON_PREFIX ${CMAKE_BINARY_DIR}/install CACHE PATH "set this to the assembly installation")
if( NOT EXTERNAL_ASSEMBLY_INDIVIDUAL_INSTALL_PACKAGE)
	set(CMAKE_PREFIX_PATH ${EXTERNAL_ASSEMBLY_COMMON_PREFIX})
endif()

#here we want the sources to accumulate
if( NOT EXTERNAL_ASSEMBLY_BASE_SOURCE )
	get_filename_component(EXTERNAL_ASSEMBLY_BASE_SOURCE ${CMAKE_SOURCE_DIR}/../../Sources ABSOLUTE)
endif()


#set up initial flags

	set(BUILD_SHARED_LIBS ${EXTERNAL_ASSEMBLY_BUILD_SHARED})
	if(NOT EXTERNAL_ASSEMBLY_BUILD_SHARED)
		#this is to avoid linking errors on AMD64, basically add -fPIC also to static lib buildslike
		#relocation R_X86_64_32S
		#see
		#http://www.cmake.org/pipermail/cmake/2006-September/011316.html
		#http://www.gentoo.org/proj/en/base/amd64/howtos/index.xml?part=1&chap=3

		if("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "x86_64" )
			if(APPLE)
				message("ATTENZIONE!!!! uso hack per unix AMD64  !!!!!!!! ")
			endif()
			set(CMAKE_C_FLAGS "-fPIC ${CMAKE_C_FLAGS}")
			set(CMAKE_CXX_FLAGS "-fPIC ${CMAKE_CXX_FLAGS}")
		endif()
	endif()


	set(Package_Pass_Variables CMAKE_PREFIX_PATH CMAKE_MODULE_PATH CMAKE_DEBUG_POSTFIX BUILD_SHARED_LIBS CMAKE_VERBOSE_MAKEFILE CMAKE_BUILD_TYPE CMAKE_C_FLAGS	CMAKE_CXX_FLAGS CMAKE_EXE_LINKER_FLAGS CMAKE_CXX_COMPILER CMAKE_C_COMPILER CMAKE_Fortran_COMPILER Package_search_hints CMAKE_FIND_ROOT_PATH CMAKE_FIND_ROOT_PATH_MODE_PROGRAM CMAKE_FIND_ROOT_PATH_MODE_LIBRARY CMAKE_FIND_ROOT_PATH_MODE_INCLUDE CMAKE_MAKE_PROGRAM)
	  if(APPLE)
		set(Package_Pass_Variables ${Package_Pass_Variables} CMAKE_OSX_ARCHITECTURES)
	  endif()



#################################################################################
#this function really resolve a dependency, either find something or insert external
#################################################################################
function(add_external_package_dir pkg)
	get_filename_component(Package_source ${CMAKE_SOURCE_DIR}/../../Packages/${pkg} ABSOLUTE)
		debug_message("WARNING testing  for ${pkg}  in folder -->${Package_source}<-- ARGV1-->${ARGV1}<--ARGC-->${ARGC}<--")
	set(ForceBuild OFF)
	if(ARGC GREATER 1)
		set(ver ${ARGV1})
		if(ARGC GREATER 2)
			set(ForceBuild ${ARGV2})
		endif()
	else()
		if(EXISTS ${Package_source}/Default.cmake)
			include(${Package_source}/Default.cmake)
			set(ver ${Package_default_version})
		else()
			file(GLOB versions RELATIVE ${Package_source} "${Package_source}/*")
			if(versions)
				list(SORT versions)
				debug_message("available versions for package ${pkg} in folder -->${Package_source}<-->${versions}")
				list(GET versions 0 ver)
			else()
				message( FATAL_ERROR "package definition -->${Package_source}<-- UNAVAILABLE")
			endif()
		endif()
	endif()
	list(FIND Package_list ${pkg} pkg_found)
	if(pkg_found LESS 0 )
		if(EXISTS ${Package_source}/${ver})
			debug_message("########### handling package ${pkg} --->${Package_list}<--")
			unset(mymodulefile CACHE)
			find_file(
				mymodulefile 
				NAMES Find${pkg}.cmake ${pkg}Config.cmake
				PATHS ${CMAKE_MODULE_PATH} ${CMAKE_ROOT}/Modules 
			)
			debug_message("mymodulefile-->${mymodulefile}<--")
			set(my_found 0)
			if(mymodulefile)
				get_cmake_property(previous_cache_var CACHE_VARIABLES)
								
				#find_package(${pkg} ${Package_search_hints}) 
				string(TOUPPER ${pkg} pkg_upper_name)
				find_package(${pkg} ) #disable ${Package_search_hints} for packages
				
				if(${pkg_upper_name}_FOUND)
					debug_message(HERE!!!! found -->${pkg}<-- skipping external)
					set(my_found 1)
				else()
					get_cmake_property(current_cache_var CACHE_VARIABLES)
					list(REMOVE_ITEM current_cache_var ${previous_cache_var})
					foreach(v ${current_cache_var})
						debug_message("unset cache var ->${v}<-->${${v}}<-")
						unset(${v} CACHE)
					endforeach()
				endif()
			else()
				debug_message("NOT FOUND module ->${pkg}<- in files Find${pkg}.cmake ${pkg}Config.cmake in paths ${CMAKE_MODULE_PATH} ${CMAKE_ROOT}/Modules")
			endif()
			if(NOT my_found OR ForceBuild )
				set(Package_current_dependencies_effective "")
				if(EXISTS ${Package_source}/Depends.cmake)
					set(Package_current_dependencies "")
					include(${Package_source}/Depends.cmake)
					debug_message("WARNING!!!!########## handling deps for ${pkg} -->${Package_current_dependencies}<--")
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
				debug_message("@@@@@@@@add_subdirectory(${Package_source}/${ver} ${EXTERNAL_ASSEMBLY_BASE_BUILD}/${pkg}) with dep line -->${Package_current_dependencies_effective_line}<--")
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
#this function get setup variables into package cmakelists when called with the list of used vars
#################################################################################
function(PackageSetup )
	get_filename_component(Package_Dir ${CMAKE_PARENT_LIST_FILE} PATH)
	get_filename_component(tmp ${Package_Dir} PATH)
	get_filename_component(VERSION ${Package_Dir} NAME)
	get_filename_component(PACKAGE ${tmp} NAME)
	

#	set(_f1 -DBUILD_SHARED_LIBS:BOOL=${EXTERNAL_ASSEMBLY_BUILD_SHARED})
#	if(NOT EXTERNAL_ASSEMBLY_BUILD_SHARED)
		#this is to avoid linking errors on AMD64, basically add -fPIC also to static lib buildslike
		#relocation R_X86_64_32S
		#see
		#http://www.cmake.org/pipermail/cmake/2006-September/011316.html
		#http://www.gentoo.org/proj/en/base/amd64/howtos/index.xml?part=1&chap=3

#		if("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "x86_64" )
#			set(_f2 -DCMAKE_C_FLAGS:STRING=-fPIC ${CMAKE_C_FLAGS})
#			set(_f3 -DCMAKE_CXX_FLAGS:STRING=-fPIC ${CMAKE_CXX_FLAGS})
#		endif()
#	endif()

	set(list_separator "")
	set(Package_specific_cmake_args "")
	set(Package_std_cmake_args -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR> )
	if(EXTERNAL_ASSEMBLY_INDIVIDUAL_INSTALL_PACKAGE)
		foreach(dep_package ${Package_list})
			list(REMOVE_ITEM CMAKE_PREFIX_PATH ${EXTERNAL_ASSEMBLY_COMMON_PREFIX}/${PACKAGE})
			list(APPEND CMAKE_PREFIX_PATH ${EXTERNAL_ASSEMBLY_COMMON_PREFIX}/${PACKAGE})
		endforeach()
	endif()

	foreach(pass_var ${Package_Pass_Variables})
		if(DEFINED ${pass_var})
			if(NOT ${pass_var} STREQUAL "")
				set(pass_var_len 0)
				set(_tmp ${${pass_var}})
				debug_message("variable -->${pass_var}<-->${_tmp}")
				list(LENGTH _tmp pass_var_len)
				debug_message("length of -->${pass_var}<-->${pass_var_len}")
				if(pass_var_len GREATER 1)
					string(REPLACE ";" "@@" managed_list "${_tmp}" )
					debug_message("adding variable -->${pass_var}<-as list->${managed_list}")
					set(list_separator LIST_SEPARATOR @@)
					set(def_flag -D${pass_var}:CACHE=${managed_list})
				else()
					set(def_flag -D${pass_var}:CACHE=${${pass_var}})
				endif()
				list(APPEND Package_std_cmake_args ${def_flag})
			endif()
		endif()
	endforeach()
	
	

	

#	set(Package_std_cmake_args -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR> -DCMAKE_PREFIX_PATH:PATH=<INSTALL_DIR> -DCMAKE_MODULE_PATH:PATH=${CMAKE_MODULE_PATH} -DCMAKE_DEBUG_POSTFIX:STRING=${CMAKE_DEBUG_POSTFIX} ${_f1} ${_f2} ${_f3})

	
	set(Package_Source_Stamp_Dir ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/stamp )
	set(Package_Source_Dir ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/src )
	set(Package_Download_Dir ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/download )
	
	file(TO_NATIVE_PATH ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/src _NATIVE_SOURCE_DIR)
	file(TO_NATIVE_PATH ${Package_Source_Stamp_Dir} _NATIVE_SRCSTAMP_DIR)
	file(TO_NATIVE_PATH ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/download _NATIVE_DOWNLOAD_DIR)
	set(Package_std_source_dirs 
		SOURCE_DIR ${_NATIVE_SOURCE_DIR}
		#SRCSTAMP_DIR ${_NATIVE_SRCSTAMP_DIR}
		DOWNLOAD_DIR ${_NATIVE_DOWNLOAD_DIR}
	)
	file(TO_NATIVE_PATH ${EXTERNAL_ASSEMBLY_BASE_BUILD}/${PACKAGE}/build _NATIVE_BINARY_DIR)
	if(EXTERNAL_ASSEMBLY_INDIVIDUAL_INSTALL_PACKAGE)
		file(TO_NATIVE_PATH ${EXTERNAL_ASSEMBLY_COMMON_PREFIX}/${PACKAGE} _NATIVE_INSTALL_DIR)		
	else()
		file(TO_NATIVE_PATH ${EXTERNAL_ASSEMBLY_COMMON_PREFIX} _NATIVE_INSTALL_DIR)
	endif()
	set(Package_std_binary_dirs
		BINARY_DIR ${_NATIVE_BINARY_DIR}
		INSTALL_DIR ${_NATIVE_INSTALL_DIR}
	)
	set(Package_std_dirs ${Package_std_source_dirs} ${Package_std_binary_dirs} ${list_separator})

	debug_message("Processing Package ${PACKAGE} in-->${Package_Dir}")
	if(ARGN)
		set(varlist ${ARGN})
	else()
		set(varlist 
			Package_Dir
			VERSION 
			PACKAGE 
			Package_std_cmake_args 
			Package_specific_cmake_args
			Package_Source_Stamp_Dir 
			Package_Source_Dir
			Package_Download_Dir
			Package_std_source_dirs 
			Package_std_binary_dirs
			Package_std_dirs
		)
		debug_message(STATUS "exporting all vars-->${varlist}<--")
	endif()
	foreach(var ${varlist})
		if(NOT DEFINED ${var})
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
	#debug_message("--->${mycommand}<--")

endfunction(PackageWriteMultiPatchFile)

function(PackageBinarySimpleAdd URL download_subfolder)
	debug_message("!!!!! building ${PACKAGE} in  ${download_subfolder} with depnds-->${Package_current_dependencies_effective_line}<--")
	ExternalProject_Add(
		${PACKAGE}
		#WARNING!!!! this way  zip file directly expand into install/bin dir == source dir
		DOWNLOAD_DIR ${download_subfolder}
		SOURCE_DIR  ${EXTERNAL_ASSEMBLY_BASE_BUILD}/${PACKAGE}/build
		INSTALL_DIR ${EXTERNAL_ASSEMBLY_COMMON_PREFIX}
		URL ${URL}
		INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <INSTALL_DIR>
		CONFIGURE_COMMAND ""
		BUILD_COMMAND ""
		${Package_current_dependencies_effective_line}

	)
endfunction(PackageBinarySimpleAdd)



function(PackageWindowsBinarySimpleAdd URL)
	PackageBinarySimpleAdd(${URL} ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/win32_bin_download)
endfunction(PackageWindowsBinarySimpleAdd)



function(PackageBinaryAdd)
	debug_message("!!!!! building ${PACKAGE} in  ${download_subfolder} with depnds-->${Package_current_dependencies_effective_line}<--")
	ExternalProject_Add(
		${PACKAGE}-GetSource
		SOURCE_DIR ${Package_Source_Dir}
		DOWNLOAD_DIR ${Package_Download_Dir}
		STAMP_DIR ${Package_Source_Stamp_Dir}
		${Package_source_setup}
		CONFIGURE_COMMAND ""
		BUILD_COMMAND ""
		INSTALL_COMMAND ""
	)
	if(Package_current_dependencies_effective_line)
		set( Package_current_dependencies_effective_line ${Package_current_dependencies_effective_line} ${PACKAGE}-GetSource)
	else()
		set(Package_current_dependencies_effective_line DEPENDS ${PACKAGE}-GetSource)
	endif()

	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		DOWNLOAD_COMMAND ""
		INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <INSTALL_DIR>
		CONFIGURE_COMMAND ""
		BUILD_COMMAND ""
		${Package_current_dependencies_effective_line}
		STEP_TARGETS install
	)



endfunction(PackageBinaryAdd)




function(PackageCmakeAdd)

	ExternalProject_Add(
		${PACKAGE}-GetSource
		SOURCE_DIR ${Package_Source_Dir}
		DOWNLOAD_DIR ${Package_Download_Dir}
		STAMP_DIR ${Package_Source_Stamp_Dir}
		${Package_source_setup}
		CONFIGURE_COMMAND ""
		BUILD_COMMAND ""
		INSTALL_COMMAND ""
	)


	if(Package_current_dependencies_effective_line)
		set( Package_current_dependencies_effective_line ${Package_current_dependencies_effective_line} ${PACKAGE}-GetSource)
	else()
		set(Package_current_dependencies_effective_line DEPENDS ${PACKAGE}-GetSource)
	endif()

	if(EXTERNAL_ASSEMBLY_BUILD_COMMAND)
		set(make_command BUILD_COMMAND ${EXTERNAL_ASSEMBLY_BUILD_COMMAND})
	else()
		set(make_command "")
	endif()

	debug_message("Package_specific_cmake_args---->${Package_specific_cmake_args}<---")

	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		DOWNLOAD_COMMAND ""
		${make_command}
		CMAKE_GENERATOR ${CMAKE_GENERATOR}
		CMAKE_ARGS 
			${Package_std_cmake_args}
			${Package_specific_cmake_args}
		${Package_current_dependencies_effective_line} 
		STEP_TARGETS configure build install
	)
endfunction(PackageCmakeAdd)





function(PackageUnixConfigureAdd)
	message("Package -->${PACKAGE}<--InSource->${Package_InSource}<-")
	if(Package_InSource)
		set(conf_command_body ./configure  --prefix=<INSTALL_DIR>)
	else()
		if(Package_nosrcdir)
			set(conf_command_body <SOURCE_DIR>/configure --prefix=<INSTALL_DIR>)
		else()
			set(conf_command_body <SOURCE_DIR>/configure --srcdir=<SOURCE_DIR> --prefix=<INSTALL_DIR>)
		endif()
	endif()
	if(Package_configure_flags)
		set(conf_command_body ${conf_command_body} ${Package_configure_flags})
	endif()
	if(Package_PkgConfig)
		string(REPLACE ";" "@@" managed_conf_command_body "${conf_command_body}" )
		set(conf_command CONFIGURE_COMMAND ${CMAKE_COMMAND} -Dmy_binary_dir:PATH=<BINARY_DIR> -Dmy_source_dir:PATH=<SOURCE_DIR> -Dmy_install_dir:PATH=<INSTALL_DIR> -Dmy_configure:STRING=${managed_conf_command_body} -P ${_mymoduledir}/pkgconfig_env.cmake) 

		set(make_command_body make --jobs 4)
		string(REPLACE ";" "@@" managed_make_command_body "${make_command_body}" )
		set(make_command BUILD_COMMAND ${CMAKE_COMMAND} -Dmy_binary_dir:PATH=<BINARY_DIR> -Dmy_source_dir:PATH=<SOURCE_DIR> -Dmy_install_dir:PATH=<INSTALL_DIR> -Dmy_configure:STRING=${managed_make_command_body} -P ${_mymoduledir}/pkgconfig_env.cmake) 
		set(list_separator "LIST_SEPARATOR @@")
	else()
		set(conf_command CONFIGURE_COMMAND ${conf_command_body})
		set(list_separator "")
	endif()
		debug_message("conf_command---->${conf_command}<---")

	ExternalProject_Add(
		${PACKAGE}-GetSource
		SOURCE_DIR ${Package_Source_Dir}
		DOWNLOAD_DIR ${Package_Download_Dir}
		STAMP_DIR ${Package_Source_Stamp_Dir}
		${Package_source_setup}
		UPDATE_COMMAND ""
		CONFIGURE_COMMAND ""
		BUILD_COMMAND ""
		INSTALL_COMMAND ""
	)

	if(Package_current_dependencies_effective_line)
		set( Package_current_dependencies_effective_line ${Package_current_dependencies_effective_line} ${PACKAGE}-GetSource)
	else()
		set(Package_current_dependencies_effective_line DEPENDS ${PACKAGE}-GetSource)
	endif()

	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		${Package_current_dependencies_effective_line} 
		DOWNLOAD_COMMAND ""	
		${conf_command}
		${make_command}
		${list_separator}
		STEP_TARGETS configure build install
	)
	debug_message("

	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		${Package_current_dependencies_effective_line} 
		DOWNLOAD_COMMAND ""	
		${conf_command}
		${make_command}
		${list_separator}
		STEP_TARGETS configure build install
	)

	")
# 		ExternalProject_Add(
# 			${PACKAGE}
# 			${Package_std_dirs}
# 			${Package_current_dependencies_effective_line}
# 			URL ${URL}
# 			${conf_command}
# 			${make_command}
# 			${list_separator}
# 
# 			#CONFIGURE_COMMAND  ./configure  --prefix=<INSTALL_DIR>
# 		)
	if(Package_InSource)
		ExternalProject_Add_Step(${PACKAGE} copy_source
			COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <BINARY_DIR>
			COMMENT "copying <SOURCE_DIR> to <BINARY_DIR>"
			DEPENDEES download update patch
			DEPENDERS configure
		)
	endif()
#	if(Package_PkgConfig)
#		ExternalProject_Add_Step(${PACKAGE} install_pkgconfig
#			COMMAND ${CMAKE_GENERATOR} install-pkgconfigDATA
#			COMMENT "installing pkgconfig"
#			DEPENDEES install
#		)
#	endif()

endfunction(PackageUnixConfigureAdd)

function(PackageUnixConfigureSimpleAdd URL)
	message("Package_InSource----->${Package_InSource}<---")
	if(Package_InSource)
		set(conf_command_body ./configure  --prefix=<INSTALL_DIR>)
	else()
		set(conf_command_body <SOURCE_DIR>/configure --srcdir=<SOURCE_DIR> --prefix=<INSTALL_DIR>)
	endif()
	if(Package_configure_flags)
		set(conf_command_body ${conf_command_body} ${Package_configure_flags})
	endif()
	if(Package_PkgConfig)
		string(REPLACE ";" "@@" managed_conf_command_body "${conf_command_body}" )
		set(conf_command CONFIGURE_COMMAND ${CMAKE_COMMAND} -Dmy_binary_dir:PATH=<BINARY_DIR> -Dmy_source_dir:PATH=<SOURCE_DIR> -Dmy_install_dir:PATH=<INSTALL_DIR> -Dmy_configure:STRING=${managed_conf_command_body} -P ${_mymoduledir}/pkgconfig_env.cmake) 

		set(make_command_body make --jobs 4)
		string(REPLACE ";" "@@" managed_make_command_body "${make_command_body}" )
		set(make_command BUILD_COMMAND ${CMAKE_COMMAND} -Dmy_binary_dir:PATH=<BINARY_DIR> -Dmy_source_dir:PATH=<SOURCE_DIR> -Dmy_install_dir:PATH=<INSTALL_DIR> -Dmy_configure:STRING=${managed_make_command_body} -P ${_mymoduledir}/pkgconfig_env.cmake) 
		set(list_separator "LIST_SEPARATOR @@")
	else()
		set(conf_command CONFIGURE_COMMAND ${conf_command_body})
		set(list_separator "")
	endif()
		debug_message("conf_command---->${conf_command}<---")
		ExternalProject_Add(
			${PACKAGE}
			${Package_std_dirs}
			${Package_current_dependencies_effective_line}
			URL ${URL}
			${conf_command}
			${make_command}
			${list_separator}

			#CONFIGURE_COMMAND  ./configure  --prefix=<INSTALL_DIR>
		)
	if(Package_InSource)
		ExternalProject_Add_Step(${PACKAGE} copy_source
			COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <BINARY_DIR>
			COMMENT "copying <SOURCE_DIR> to <BINARY_DIR>"
			DEPENDEES download update patch
			DEPENDERS configure
		)
	endif()
#	if(Package_PkgConfig)
#		ExternalProject_Add_Step(${PACKAGE} install_pkgconfig
#			COMMAND ${CMAKE_GENERATOR} install-pkgconfigDATA
#			COMMENT "installing pkgconfig"
#			DEPENDEES install
#		)
#	endif()

endfunction(PackageUnixConfigureSimpleAdd)

function(PackageUnixAddCmakeVarsToConfigureFlags)
	if(CMAKE_C_FLAGS)
		set(Package_configure_flags ${Package_configure_flags} "CFLAGS=${CMAKE_C_FLAGS}")
	endif()
	if(CMAKE_C_COMPILER)
		set(Package_configure_flags ${Package_configure_flags} "CC=${CMAKE_C_COMPILER}")
	endif()
	if(CMAKE_CXX_FLAGS)
		set(Package_configure_flags ${Package_configure_flags} "CXXFLAGS=${CMAKE_CXX_FLAGS}")
	endif()
	if(CMAKE_CXX_COMPILER)
		set(Package_configure_flags ${Package_configure_flags} "CXX=${CMAKE_CXX_COMPILER}")
	endif()
	set(Package_configure_flags "${Package_configure_flags}" PARENT_SCOPE)
endfunction(PackageUnixAddCmakeVarsToConfigureFlags)

function(PackageUnixPkgConfigInstall LIBNAME PKGFILENAME)
		ExternalProject_Add_Step(${PACKAGE} install_pkgconfig
			COMMAND ${CMAKE_COMMAND} -Dprefix:PATH=<INSTALL_DIR> -Dname:STRING=${PACKAGE} -Dversion:STRING=${VERSION} -Dlibname:STRING=${LIBNAME} -Dpkgfilename:string=${PKGFILENAME} -P ${_mymoduledir}/pkgconfig_lib_configure.cmake
			COMMENT "installing pkgconfig"
			DEPENDEES install
		)
endfunction(PackageUnixPkgConfigInstall)


function(PackageUnixConfigureSimpleAddInSource URL)
		ExternalProject_Add(
			${PACKAGE}
			${Package_std_dirs}
			URL ${URL}
			CONFIGURE_COMMAND  ./configure  --prefix=<INSTALL_DIR>
		)
		ExternalProject_Add_Step(${PACKAGE} copy_source
			COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <BINARY_DIR>
			COMMENT "copying <SOURCE_DIR> to <BINARY_DIR>"
			DEPENDEES download update patch
			DEPENDERS configure
		)
endfunction(PackageUnixConfigureSimpleAddInSource)


function(PackageLinuxBinarySimpleAdd URL)
	PackageBinarySimpleAdd(${URL} ${EXTERNAL_ASSEMBLY_BASE_SOURCE}/${PACKAGE}/${VERSION}/Linux_bin_download)
endfunction(PackageLinuxBinarySimpleAdd)

function(PackagePythonSetupSimpleAdd URL)
	file(TO_NATIVE_PATH ${EXTERNAL_ASSEMBLY_COMMON_PREFIX} _install_dir)
	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		URL ${URL}
		CONFIGURE_COMMAND ""
		INSTALL_COMMAND ${CMAKE_COMMAND} -E chdir <SOURCE_DIR> ${PYTHON_EXECUTABLE} setup.py build --build-base=<BINARY_DIR> install --prefix=${_install_dir}
		BUILD_COMMAND ""
	)
	message("INSTALL_COMMAND-->${CMAKE_COMMAND} -E chdir <SOURCE_DIR> ${PYTHON_EXECUTABLE} setup.py build --build-base=<BINARY_DIR> install --prefix=${_install_dir}<----")
endfunction(PackagePythonSetupSimpleAdd)

