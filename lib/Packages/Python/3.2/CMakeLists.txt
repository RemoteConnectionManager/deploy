#from http://www.python.org
#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 

	set(Package_InSource ON)
	set(Package_source_setup
		URL http://www.python.org/ftp/python/3.2/Python-3.2.tgz
		URL_MD5 5efe838a7878b170f6728d7e5d7517af
	)
	set(Package_configure_flags LDFLAGS=-Wl,-rpath,<INSTALL_DIR>/lib)
	option(${PACKAGE}_shared "build   ${PACKAGE} shared" ON)
     	if(${PACKAGE}_shared)
		set(Package_configure_flags ${Package_configure_flags} --enable-shared)
	endif()

	PackageUnixConfigureAdd()
endif()




#for win32.... using the msi python installer:
#http://www.python.org/ftp/python/2.6.5/python-2.6.5.msi
#then using msiexec on command like as
#http://www.python.org/download/releases/2.4/msi/
#
#msiexec /i python-2.6.5.msi /qn TARGETDIR=d:\tmp\python_root  ADDLOCAL=Tools

# 	debug_message("!!!!! building ${PACKAGE} in  ${download_subfolder} with depnds-->${Package_current_dependencies_effective_line}<--")
# 	PackageUnixConfigureSimpleAdd(
# 		http://www.python.org/ftp/python/3.2/Python-3.2.tgz
# 	)
#	ExternalProject_Add(
#		${PACKAGE}
#		${Package_std_dirs}
#		URL http://www.python.org/ftp/python/3.1.2/Python-3.1.2.tgz
#		INSTALL_COMMAND ""
#		CONFIGURE_COMMAND ""
#		BUILD_COMMAND ""
#		${Package_current_dependencies_effective_line}
#	)

