#this imports variables here
#override default as we force osg shared build
message("here in OpenSim CMAKE_FIND_ROOT_PATH_MODE_LIBRARY-->${CMAKE_FIND_ROOT_PATH_MODE_LIBRARY}<--")

PackageSetup()
message("here in OpenSim SOURCE_DIR -->${Package_Source_Dir}<--")
option(${PACKAGE}_examples "build   ${PACKAGE} examples" OFF)

set(Package_source_setup
	DOWNLOAD_COMMAND ""
	UPDATE_COMMAND ""
)
set(Package_specific_cmake_args "-DXERCES_INCLUDE_DIR:PATH=${XERCES_INCLUDE_DIR};-DXERCES_LIBRARY_DIR:PATH=${XERCES_LIBRARY_DIR};-DBUILD_USING_OTHER_LAPACK:STRING=${LAPACK_LINKER_FLAGS}")


PackageCmakeAdd()


