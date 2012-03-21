#it defines common setup
PackageSetup()


set(Package_source_setup
                URL http://garr.dl.sourceforge.net/project/libjpeg-turbo/1.2.0/libjpeg-turbo-1.2.0.tar.gz
                URL_MD5 5329fa80953938cb4f097afae55059e2
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


