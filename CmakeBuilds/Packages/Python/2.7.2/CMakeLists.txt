#from http://www.python.org
#http://www.python.org/download/releases/2.7.1/


#this imports variables here
PackageSetup()

if(WIN32)
	message(FATAL_ERROR "package ${PACKAGE} not currently available for windows")
else()
	#configure based install 

	set(Package_InSource ON)
	set(Package_source_setup
		URL http://www.python.org/ftp/python/2.7.2/Python-2.7.2.tgz
		URL_MD5 0ddfe265f1b3d0a8c2459f5bf66894c7
	)
	set(Package_configure_flags LDFLAGS=-Wl,-rpath,<INSTALL_DIR>/lib)
	option(${PACKAGE}_shared "build   ${PACKAGE} shared" ON)
     	if(${PACKAGE}_shared)
		set(Package_configure_flags ${Package_configure_flags} --enable-shared)
	endif()

	PackageUnixConfigureAdd()
endif()



# set(PYTHON_CONFIGURE_FLAGS -opensource -confirm-license   -no-qt3support ) 
# set(MYURL http://www.python.org/ftp/python/2.7.1/Python-2.7.1.tgz)
# set(MYMD5URL 15ed56733655e3fab785e49a7278d2fb)
# 
# #for win32.... using the msi python installer:
# #http://www.python.org/ftp/python/2.6.5/python-2.6.5.msi
# #then using msiexec on command like as
# #http://www.python.org/download/releases/2.4/msi/
# #
# #msiexec /i python-2.6.5.msi /qn TARGETDIR=d:\tmp\python_root  ADDLOCAL=Tools
# 
# if(UNIX)
#      	set(make_command BUILD_COMMAND make -j 8)
# 	set(configure_command CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> LDFLAGS=-Wl,-rpath,<INSTALL_DIR>/lib )
# 	option(${PACKAGE}_shared "build   ${PACKAGE} shared" ON)
#      	if(${PACKAGE}_shared)
# 		set(configure_command ${configure_command} --enable-shared)
# 	endif()
# 
# endif()
# 
# 	debug_message("!!!!! building ${PACKAGE} in  ${download_subfolder} with depnds-->${Package_current_dependencies_effective_line}<--")
# 	ExternalProject_Add(
# 		${PACKAGE}
# 		${Package_std_dirs}
# 		URL ${MYURL}
# 		URL_MD5 ${MYMD5URL}
# 		${configure_command} 
# 		${make_command}
# 
# 		${Package_current_dependencies_effective_line}
# 
# 	)
# 
