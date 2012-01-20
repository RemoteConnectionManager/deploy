#from http://www.apache.org/dist/xerces/c/2.7/
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#set(Package_configure_flags --enable-xlib-xrender=no)
	set(Package_source_setup
		URL http://archive.apache.org/dist/xml/xerces-c/Xerces-C_2_7_0/source/xerces-c-src_2_7_0.tar.gz
		URL_MD5 04169609449a8846bc1e6891c04cadf4
	)

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

	#set(conf_command_body ./src/xercesc/configure  --prefix=<INSTALL_DIR>)
#	set(conf_command_body "export@@XERCESCROOT=<BUILD_DIR>;cd@@<BUILD_DIR>/src/xercesc;./runConfigure@@ -p<INSTALL_DIR>")

	set(conf_command_body  ./runConfigure  -p linux -P <INSTALL_DIR>)

	string(REPLACE ";" "@@" managed_conf_command_body "${conf_command_body}" )
#	set(conf_command CONFIGURE_COMMAND ${CMAKE_COMMAND} -Dmy_binary_dir:PATH=<BINARY_DIR> -Dmy_source_dir:PATH=<SOURCE_DIR> -Dmy_install_dir:PATH=<INSTALL_DIR> -Dmy_configure:STRING=${managed_conf_command_body} -P ${_mymoduledir}/pkgconfig_env.cmake) 

	set(conf_command CONFIGURE_COMMAND ${CMAKE_COMMAND} -Dmy_binary_dir:PATH=<BINARY_DIR> -Dmy_source_dir:PATH=<SOURCE_DIR> -Dmy_install_dir:PATH=<INSTALL_DIR> -Dmy_configure:STRING=${managed_conf_command_body} -P ${Package_Dir}/configure.cmake)


	set(make_command_body gmake)
	string(REPLACE ";" "@@" managed_make_command_body "${make_command_body}" )
#	set(conf_command CONFIGURE_COMMAND ${CMAKE_COMMAND} -Dmy_binary_dir:PATH=<BINARY_DIR> -Dmy_source_dir:PATH=<SOURCE_DIR> -Dmy_install_dir:PATH=<INSTALL_DIR> -Dmy_configure:STRING=${managed_conf_command_body} -P ${_mymoduledir}/pkgconfig_env.cmake) 

	set(make_command BUILD_COMMAND ${CMAKE_COMMAND} -Dmy_binary_dir:PATH=<BINARY_DIR> -Dmy_source_dir:PATH=<SOURCE_DIR> -Dmy_install_dir:PATH=<INSTALL_DIR> -Dmy_configure:STRING=${managed_make_command_body} -P ${Package_Dir}/configure.cmake)

	set(install_command_body gmake install)
	string(REPLACE ";" "@@" managed_install_command_body "${install_command_body}" )
#	set(conf_command CONFIGURE_COMMAND ${CMAKE_COMMAND} -Dmy_binary_dir:PATH=<BINARY_DIR> -Dmy_source_dir:PATH=<SOURCE_DIR> -Dmy_install_dir:PATH=<INSTALL_DIR> -Dmy_configure:STRING=${managed_conf_command_body} -P ${_mymoduledir}/pkgconfig_env.cmake) 

	set(install_command INSTALL_COMMAND ${CMAKE_COMMAND} -Dmy_binary_dir:PATH=<BINARY_DIR> -Dmy_source_dir:PATH=<SOURCE_DIR> -Dmy_install_dir:PATH=<INSTALL_DIR> -Dmy_configure:STRING=${managed_install_command_body} -P ${Package_Dir}/configure.cmake)

	set(list_separator LIST_SEPARATOR @@)


	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		${Package_current_dependencies_effective_line} 
		DOWNLOAD_COMMAND ""	
		${conf_command}
		${make_command}
		${install_command}
		${list_separator}
		STEP_TARGETS configure build install
	)

	ExternalProject_Add_Step(${PACKAGE} copy_source
		COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <BINARY_DIR>
		COMMENT "copying <SOURCE_DIR> to <BINARY_DIR>"
		DEPENDEES download update patch
		DEPENDERS configure
	)

# 	debug_message("Package_std_dirs--->${Package_std_dirs}<---")
# 	list(FIND Package_std_dirs SOURCE_DIR _my_list_index)
# 	math(EXPR _my_list_index "${_my_list_index} + 1")
# 	list(GET Package_std_dirs ${_my_list_index} _actual_source_dir )
# 	set(_actual_source_dir "${_actual_source_dir}/src/xercesc")
# 	list(REMOVE_AT Package_std_dirs ${_my_list_index} )
# 	list(INSERT Package_std_dirs ${_my_list_index} ${_actual_source_dir} )
# 	debug_message("Package_std_dirs--->${Package_std_dirs}<---" )
# 	set(Package_InSource ON)	
# 
# 	PackageUnixConfigureAdd()
endif()

