#it defines common setup
#include(PackageSetup)

#this imports variables here
PackageSetup()


set(Package_source_setup
                URL http://garr.dl.sourceforge.net/project/virtualgl/TurboVNC/1.0.2/turbovnc-1.0.2.tar.gz
                URL_MD5 1d836e2cadaf2f67a19f4d298480cdc4
        )
	message("Package_std_dirs--->${Package_std_dirs}<---")
	list(FIND Package_std_dirs SOURCE_DIR _my_list_index)
	math(EXPR _my_list_index "${_my_list_index} + 1")
	list(GET Package_std_dirs ${_my_list_index} _actual_source_dir )
	set(_actual_source_dir "${_actual_source_dir}/vnc_unixsrc")
	list(REMOVE_AT Package_std_dirs ${_my_list_index} )
	list(INSERT Package_std_dirs ${_my_list_index} ${_actual_source_dir} )
	message("Package_std_dirs--->${Package_std_dirs}<---" )
	set(Package_configure_flags JPEG_CFLAGS=-I<INSTALL_DIR>/include  "JPEG_LDFLAGS='-L<INSTALL_DIR>/lib -lturbojpeg'")
 
 
 	PackageUnixConfigureAdd()


