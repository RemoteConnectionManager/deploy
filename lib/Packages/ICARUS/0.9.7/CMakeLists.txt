#from http://www.paraview.org
#paraview_data http://paraview.org/files/v3.10/ParaViewData-3.10.0.zip

#this imports variables here
PackageSetup()
# message("Package_current_dependencies_effective_line------------------>${Package_current_dependencies_effective_line}<-----------------------")
# message("Package_std_cmake_args------->${Package_std_cmake_args}<--")
# set(make_command "")
# set(Package_specific_cmake_args "")
# if(UNIX)
#      set(make_command BUILD_COMMAND make -j 8)
# endif()


# set(Package_specific_cmake_args ${Package_specific_cmake_args}
# 	-DH5FD_DSM_BUILD_STEERING:BOOL=ON
# 	-DHDF5_BUILD_HL_LIB:BOOL=ON
# 	-DHDF5_ENABLE_PARALLEL:BOOL=ON
# 	-DXDMF_USE_H5FD_DSM:BOOL=ON
# )

set(Package_source_setup
	URL http://hpcforge.org/frs/download.php/30/icarus-0.9.7.tar.bz2
	URL_MD5 643695a9b7cc203f1c7a6fbee046ff7b
)

PackageCmakeAdd()







