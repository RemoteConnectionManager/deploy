

#this imports variables here
PackageSetup()


# set(Package_source_setup
# 	URL http://hpcforge.org/frs/download.php/32/h5fddsm-0.9.7.tar.bz2
# 	URL_MD5 7e190568f6637e8447ed5a5460e87dde
# )
set(Package_source_setup
	GIT_REPOSITORY http://hpcforge.org/anonscm/git/h5fddsm/h5fddsm.git
#	GIT_TAG pv-3.10.1
	UPDATE_COMMAND ""
)

set(Package_specific_cmake_args 
	-DH5FD_DSM_BUILD_FORTRAN:BOOL=ON
	-DH5FD_DSM_BUILD_STEERING:BOOL=ON
	-DH5FD_DSM_BUILD_TESTING:BOOL=ON
)

PackageCmakeAdd()


	





