#from http://www.python.org
#this imports variables here
PackageSetup()

#for win32.... using the msi python installer:
#http://www.python.org/ftp/python/2.6.5/python-2.6.5.msi
#then using msiexec on command like as
#http://www.python.org/download/releases/2.4/msi/
#
#msiexec /i python-2.6.5.msi /qn TARGETDIR=d:\tmp\python_root  ADDLOCAL=Tools

	debug_message("!!!!! building ${PACKAGE} in  ${download_subfolder} with depnds-->${Package_current_dependencies_effective_line}<--")
	PackageUnixConfigureSimpleAdd(
		http://www.python.org/ftp/python/3.1.2/Python-3.1.2.tgz
	)
#	ExternalProject_Add(
#		${PACKAGE}
#		${Package_std_dirs}
#		URL http://www.python.org/ftp/python/3.1.2/Python-3.1.2.tgz
#		INSTALL_COMMAND ""
#		CONFIGURE_COMMAND ""
#		BUILD_COMMAND ""
#		${Package_current_dependencies_effective_line}
#	)

