#this imports variables here
#override default as we force osg shared build
message("here in OpenSim CMAKE_FIND_ROOT_PATH_MODE_LIBRARY-->${CMAKE_FIND_ROOT_PATH_MODE_LIBRARY}<--")

PackageSetup()
message("here in OpenSim SOURCE_DIR -->${Package_Source_Dir}<--")
option(${PACKAGE}_examples "build   ${PACKAGE} examples" OFF)

set(Package_source_setup
	SVN_REPOSITORY https://simtk.org/svn/simbody/trunk/
	UPDATE_COMMAND ""
)

message("in simbody: LAPACK_LINKER_FLAGS-->${LAPACK_LINKER_FLAGS}<---")
set(Package_specific_cmake_args "-DSimTK_INSTALL_PREFIX:PATH=<INSTALL_DIR>;-DBUILD_USING_OTHER_LAPACK:STRING=${LAPACK_LINKER_FLAGS}")


PackageCmakeAdd()


