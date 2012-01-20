#from http://www.sqlite.org/
#this imports variables here
PackageSetup()

if(MSVC)
	#### here we download the binary package, ase md5deep does not currently support building under windows..... sic
	
	get_filename_component(_tmp ${CMAKE_MAKE_PROGRAM} PATH)
	get_filename_component(_tmp ${_tmp} PATH)
	get_filename_component(_tmp ${_tmp} PATH)
	set(_vcvars ${_tmp}/VC/vcvarsall.bat)
	if(EXISTS ${_vcvars})
		file(TO_NATIVE_PATH ${_vcvars} _vcvars)
		message(" to setup, do -->${_vcvars} ${CMAKE_SYSTEM_PROCESSOR}<--")
	else()
		message(FATAL_ERROR "can not find vcvars like ${_vcvars}")
	endif()
	find_program(PERL_EXE perl)
	if(PERL_EXE)
		message("found Perl-->${PERL_EXE}<--")
		get_filename_component(_perl_path ${PERL_EXE} PATH)
		file(TO_NATIVE_PATH ${_perl_path} _perl_path)
	else()
		message(FATAL_ERROR "can not find Perl ")
	endif()

	configure_file(${CMAKE_CURRENT_SOURCE_DIR}/configure.bat.in ${CMAKE_CURRENT_BINARY_DIR}/configure.bat @ONLY)
	configure_file(${CMAKE_CURRENT_SOURCE_DIR}/build.bat.in ${CMAKE_CURRENT_BINARY_DIR}/build.bat @ONLY)
	configure_file(${CMAKE_CURRENT_SOURCE_DIR}/configure.cmake.in ${CMAKE_CURRENT_BINARY_DIR}/configure.cmake @ONLY)
	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		URL http://get.qt.nokia.com/qt/source/qt-everywhere-opensource-src-4.6.2.zip
		CONFIGURE_COMMAND ${CMAKE_COMMAND} -DMY_SOURCE_DIR:PATH=<SOURCE_DIR> -DMY_BINARY_DIR:PATH=<BINARY_DIR> -DMY_INSTALL_DIR:PATH=<INSTALL_DIR> -P ${CMAKE_CURRENT_BINARY_DIR}/configure.cmake 
#		BUILD_COMMAND ${CMAKE_COMMAND} -E chdir <BINARY_DIR> build.bat
#		BUILD_COMMAND build.bat
#		BUILD_COMMAND ${CMAKE_COMMAND} -E chdir <INSTALL_DIR> <BINARY_DIR>/build.bat
		BUILD_COMMAND <BINARY_DIR>/build.bat
		INSTALL_COMMAND ""
#		CONFIGURE_COMMAND <SOURCE_DIR>/configure --srcdir=<SOURCE_DIR> --prefix=<INSTALL_DIR>

	)
else()
	#skipping configure make and install as required as source
	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		URL http://get.qt.nokia.com/qt/source/qt-everywhere-opensource-src-4.6.2.zip
		CONFIGURE_COMMAND ""
		BUILD_COMMAND ""
		INSTALL_COMMAND""
#		CONFIGURE_COMMAND <SOURCE_DIR>/configure --srcdir=<SOURCE_DIR> --prefix=<INSTALL_DIR>
	)
	
	
	
endif()



