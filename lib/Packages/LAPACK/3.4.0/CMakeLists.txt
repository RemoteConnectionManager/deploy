#this imports variables here
#override default as we force osg shared build
message("here in LAPACK CMAKE_FIND_ROOT_PATH_MODE_LIBRARY-->${CMAKE_FIND_ROOT_PATH_MODE_LIBRARY}<--")

PackageSetup()
message("here in LAPACK SOURCE_DIR -->${Package_Source_Dir}<--")
option(${PACKAGE}_examples "build   ${PACKAGE} examples" OFF)

set(Package_source_setup
	URL http://www.netlib.org/lapack/lapack-3.4.0.tgz
	URL_MD5 02d5706ec03ba885fc246e5fa10d8c70

)


PackageCmakeAdd()


