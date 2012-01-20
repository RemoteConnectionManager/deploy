#this package cam build with:

#cmake -DAUTO_PACKAGE:PATH=TurboVNC -DTurboVNC_build_server:BOOL=ON ../../src/Assemblies/auto_package/

##### on a mean ubuntu it required
#sudo apt-get install libX11-dev
#sudo apt-get install libXaw7-dev

#this perhaps could be avoided if building libz from source
#sudo apt-get install libz-dev    

#this is for building xserver that requires xmkmf
#sudo apt-get install xutils-dev

#this is for building xserver that gives error:
#authpam.c:32:31: error: security/pam_appl.h: No such file or directory
#sudo apt-get install libpam0g-dev

PackageSetup()

option(${PACKAGE}_build_server "Build and install ${PACKAGE} server" OFF)


set(Package_source_setup
                URL http://garr.dl.sourceforge.net/project/virtualgl/TurboVNC/1.0.2/turbovnc-1.0.2.tar.gz
                URL_MD5 1d836e2cadaf2f67a19f4d298480cdc4
        )
	debug_message("Package_std_dirs--->${Package_std_dirs}<---")
	list(FIND Package_std_dirs SOURCE_DIR _my_list_index)
	math(EXPR _my_list_index "${_my_list_index} + 1")
	list(GET Package_std_dirs ${_my_list_index} _actual_source_dir )
	set(_actual_source_dir "${_actual_source_dir}/vnc_unixsrc")
	list(REMOVE_AT Package_std_dirs ${_my_list_index} )
	list(INSERT Package_std_dirs ${_my_list_index} ${_actual_source_dir} )
	debug_message("Package_std_dirs--->${Package_std_dirs}<---" )

	set(Package_configure_flags JPEG_CFLAGS=-I<INSTALL_DIR>/include  JPEG_LDFLAGS=-L<INSTALL_DIR>/lib\ -lturbojpeg)
	if(${PACKAGE}_build_server) 
		set(Package_configure_flags --with-x ${Package_configure_flags})
	endif()
	set(Package_PkgConfig ON)
 
	PackageUnixConfigureAdd()
	if(${PACKAGE}_build_server) 
		ExternalProject_Add_Step(
			  ${PACKAGE}	install_xserver	
			  COMMAND make  xserver-install
			  DEPENDEES install build_xserver
			  WORKING_DIRECTORY <BINARY_DIR>
		)

		ExternalProject_Add_Step(
		      ${PACKAGE} build_xserver
		      COMMAND make xserver
		      DEPENDEES build
		      DEPENDERS install_xserver
		      WORKING_DIRECTORY <BINARY_DIR>
		)
	endif()
