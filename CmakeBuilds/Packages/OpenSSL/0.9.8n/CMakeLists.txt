#http://www.openssl.org/
#this imports variables here
PackageSetup()

	debug_message("!!!!! building ${PACKAGE} in  ${download_subfolder} with depnds-->${Package_current_dependencies_effective_line}<--")
	ExternalProject_Add(
		${PACKAGE}
		${Package_std_dirs}
		URL http://www.openssl.org/source/openssl-0.9.8n.zip
		INSTALL_COMMAND ""
		CONFIGURE_COMMAND ""
		BUILD_COMMAND ""
		${Package_current_dependencies_effective_line}

	)

