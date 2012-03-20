#it defines common setup
PackageSetup()


set(Package_source_setup
                URL http://garr.dl.sourceforge.net/project/libjpeg-turbo/1.1.1/libjpeg-turbo-1.1.1.tar.gz
                URL_MD5 03b9c1406c7bfdc204313c2917ce6962
        )

if(WIN32)
	PackageCmakeAdd()
else()
	option(${PACKAGE}_shared "build   ${PACKAGE} shared" OFF)
	set(Package_PkgConfig ON)
     	if(${PACKAGE}_shared)
#bad way		set(Package_configure_flags ${Package_configure_flags} --enable-shared PATH=$ENV{PATH}:<INSTALL_DIR>/bin)
		set(Package_configure_flags ${Package_configure_flags} --enable-shared )
	else()
		set(Package_configure_flags ${Package_configure_flags} --enable-shared=no )
	endif()
	message("Package_configure_flags-->${Package_configure_flags}<--")

	PackageUnixConfigureAdd()
endif()


